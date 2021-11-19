#include <stabilizing_control/stabilizing_control.h>
#include <ros/package.h>

#include <string>
#include <cstdlib>
#include <algorithm>

using namespace std;
using namespace KDL;
using namespace Eigen;

StabilizingControl::StabilizingControl(string name) : n(name)
{
    print_q = false;

    samplingFreq = 1000.0; 

    finger_lowerlimit << 0.0, 0.0; 
    finger_upperlimit << 0.04, 0.04; 
    FingerVector finger (2); 
    FingerVector finger_r (2); 
    
    q_lowerlimit << -2.8973, -1.7628, -2.8973, -3.0718, -2.8973, -0.0175, -2.8973;
    q_upperlimit  << 2.8973, 1.7628, 2.8973, -0.0698, 2.8973, 3.7525, 2.8973;
    q_init << 0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0;
    JointVector q(7);    
    JointVector q_r(7); 
    JointVector dotq(7); 

    PositionVector pos_r(3);
    QuaternionVector orient_r(4);

    Kp << 120.0, 300.0, 180.0, 180.0, 70.0, 20.0, 20.0;
    Ki << 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
    Kd << 20.0, 20.0, 20.0, 20.0, 4.0, 3.0, 4.0;
    i_error << 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
    i_clamp << 2.5, 4.0, 2.5, 2.5, 1.0, 1.0, 1.0;
    JointVector tau_cmd(7);
    
    // ROS subscribers and publishers
    sub_state = n.subscribe("/panda/joint_states",1,&StabilizingControl::jointStatesCallback, this);
    for(int i=0; i<q.size(); i++)
    {
        pub_joint_cmd[i] = n.advertise<std_msgs::Float64>("/panda/joint" + std::to_string(i+1) + "_position_controller/command",100);
        pub_joint_effort_cmd[i] = n.advertise<std_msgs::Float64>("/panda/joint" + std::to_string(i+1) + "_effort_controller/command",100);
    }
    for(int i=0; i<finger.size(); i++)
    {
        if (i==0)
        {
            pub_finger_cmd[i] = n.advertise<std_msgs::Float64>("/panda/joint_leftfinger_position_controller/command",100);
        }
        else if(i==1)
        {
            pub_finger_cmd[i] = n.advertise<std_msgs::Float64>("/panda/joint_rightfinger_position_controller/command",100);
        }   
    }

    // create KDL chain
    // if panda_arm_hand.urdf.xacro is adapted, then don't forget to run in a terminal with sourced workspace
    // rosrun xacro xacro --inorder -o model.urdf model.urdf.xacro
    // https://p4sser8y-words.readthedocs.io/ROS/orocos_kdl.html#usage
    // kdl_parser::treeFromFile("/home/kmerckae/src/constrained_control_robotarm/ros_ws/src/panda_description/urdf/panda_arm_hand.urdf", kdl_tree);
    string path = ros::package::getPath("panda_description");
    if (!kdl_parser::treeFromFile(path + "/urdf/panda_arm_hand.urdf", kdl_tree))
    {
        ROS_ERROR("Failed to construct kdl tree");
    }
    if (!kdl_tree.getChain("panda_link0", "panda_hand", kdl_chain))
    {
        ROS_ERROR("Failed to get kdl chain");
    }
    ROS_INFO("Successfully get KDL Chain with %d joints", kdl_chain.getNrOfJoints());
    std::cout  << std::endl;

    joint_num = kdl_chain.getNrOfJoints();

    kdl_q.resize(joint_num);
    kdl_dotq.resize(joint_num);
    kdl_q_r.resize(joint_num);
    kdl_q_lowerlimit.resize(joint_num);
    kdl_q_upperlimit.resize(joint_num);
    for (int i = 0; i < joint_num; i++)
    {
        kdl_q_lowerlimit(i) = q_lowerlimit[i]; 
        kdl_q_upperlimit(i) = q_upperlimit[i];         
    }

    kdl_gravity_effort.resize(joint_num);
    gravity = Vector {0.0, 0.0, -9.81};
    dyn_param = make_shared<ChainDynParam>(kdl_chain, gravity);

    
}

StabilizingControl::~StabilizingControl()
{
}

void StabilizingControl::jointStatesCallback(const sensor_msgs::JointState& jointstatesmsg)
{
    // ROS_INFO("in jointStatesCallback");
    for (int i=0; i<jointstatesmsg.position.size(); i++)
    {
        if(i==0 || i==1)
        {
            finger[i] = jointstatesmsg.position[i]; // finger displacement [m]
        }
        else
        {
            q[i-2] = jointstatesmsg.position[i]; // arm joint positions [rad]
            dotq[i-2] = jointstatesmsg.velocity[i]; // arm joint velocities [rad/s]
        }
    }    

    if(print_q == false)
    {
        for (int i=0; i<q.size(); i++)
        {
            q_r[i]=q[i]; // initialization of q_r
            std::cout << "panda_joint_q" + std::to_string(i+1) + " : " + std::to_string(q_lowerlimit[i]) + " < " + std::to_string(q[i]) + " < " + std::to_string(q_upperlimit[i])  << std::endl;
        }
        for (int i=0; i<finger.size(); i++)
        {
            finger_r[i] = finger[i]; // initialization of finger_r
            std::cout << "panda_finger" + std::to_string(i+1) + " : " + std::to_string(finger_lowerlimit[i]) + " < " + std::to_string(finger[i]) + " < " + std::to_string(finger_upperlimit[i])  << std::endl;
        }
        std::cout << std::endl;
        print_q = true;
    }
}

void StabilizingControl::PIDcontrol()
{
    for (int i=0; i<joint_num;i++)
    {
        i_error[i] = i_error[i] + (q_r[i] - q[i]) *(1.0/samplingFreq);
        if (i_error[i] < -i_clamp[i])
        {
            i_error[i] = -i_clamp[i];
        }
        else if (i_error[i] > i_clamp[i])
        {
            i_error[i] = i_clamp[i];
        }
        updateKDLq(q);
        updateKDLdotq(dotq);
        updateKDLdynamics();
        tau_cmd[i] = Kp[i]*(q_r[i]-q[i]) - Kd[i]*dotq[i] + Ki[i]*i_error[i] + kdl_gravity_effort(i);
    }
    for (int i=0; i<joint_num;i++)
    {   
        std_msgs::Float64 tau_cmd_msg;
        tau_cmd_msg.data = tau_cmd[i];  
        pub_joint_effort_cmd[i].publish(tau_cmd_msg);             
    }
}

void StabilizingControl::updateKDLq(JointVector& jointVector_arg)
{
    for (int i = 0; i < joint_num; i++)
    {
        kdl_q(i) = jointVector_arg[i];
    }
}

void StabilizingControl::updateKDLdotq(JointVector& dotq_arg)
{
    for (int i = 0; i < joint_num; i++)
    {
        kdl_dotq(i) = dotq_arg[i]; 
    }
}
void StabilizingControl::updateKDLdynamics()
{
    dyn_param->JntToGravity(kdl_q, kdl_gravity_effort);
}


void StabilizingControl::armControl()
{
    for (int i=0; i<joint_num;i++)
    {   
        std_msgs::Float64 q_r_msg;
        q_r_msg.data = q_r[i];  
        pub_joint_cmd[i].publish(q_r_msg);             
    }
}

void StabilizingControl::handControl()
{
    for (int i=0; i<finger_r.size();i++)
    {
        std_msgs::Float64 finger_r_msg;
        finger_r_msg.data = finger_r[i];
        pub_finger_cmd[i].publish(finger_r_msg);
    }

}

void StabilizingControl::forwardKinematics()
{
    ChainFkSolverPos_recursive fksolver(kdl_chain);
    kinematics_status = fksolver.JntToCart(kdl_q,kdl_x);
    if(kinematics_status>=0)
    {
        // std::cout << "rotation matrix" << std::endl;
        // std::cout << kdl_x.M << std::endl;
        // std::cout << "end-effector position" << std::endl;
        // std::cout << kdl_x.p << std::endl;
        // std::cout << std::endl;

        // printf("%s \n","Succes, thanks KDL!");
    }
    else
    {
        // printf("%s \n","Error: could not calculate forward kinematics :(");
    }
}

void StabilizingControl::inverseKinematics()
{
    updateKDLq(q_init); //kdl_q = q_init
        
    ChainFkSolverPos_recursive fksolver(kdl_chain);
    ChainIkSolverVel_pinv ikvelsolver(kdl_chain);
    // ChainIkSolverPos_NR iksolver(kdl_chain, fksolver, ikvelsolver);
    ChainIkSolverPos_NR_JL iksolver(kdl_chain, kdl_q_lowerlimit, kdl_q_upperlimit,fksolver, ikvelsolver); 

    Rotation R;
    kdl_x = Frame(R.Quaternion(orient_r[0],orient_r[1],orient_r[2],orient_r[3]),Vector(pos_r[0],pos_r[1],pos_r[2]));
    // std::cout << "DESIRED FRAME" << std::endl;
    // std::cout << kdl_x << std::endl;

    inversekinematics_status = iksolver.CartToJnt(kdl_q,kdl_x,kdl_q_r);

    if(inversekinematics_status>=0)
    {
        // std::cout << "INVERSE KINEMATICS: desired joint angles" << std::endl;
        for (int i=0; i<joint_num;i++)
        {   
            q_r[i] = kdl_q_r(i); 
            // std::cout << " q_r" << i << " = " << kdl_q_r(i) << std::endl;            
        }
    }
    else
    {
        // printf("%s \n","Error: could not calculate forward kinematics :(");
    }
    
  

}