#include <cmath>
#include <iostream>

#include "ros/ros.h"
#include <sensor_msgs/JointState.h>
#include <std_msgs/Float64.h>

std::vector<double> q_lowerlimit = {-2.8973, -1.7628, -2.8973, -3.0718, -2.8973, -0.0175, -2.8973}; // [rad]
std::vector<double> q_upperlimit = {2.8973, 1.7628, 2.8973, -0.0698, 2.8973, 3.7525, 2.8973}; // [rad]
std::vector<double> q(7);   // current joint angles[rad]
std::vector<double> qr(7);  // reference joint angles[rad]

std::vector<double> finger_lowerlimit = {0.0, 0.0}; // [m]
std::vector<double> finger_upperlimit = {0.04, 0.04}; // [m]
std::vector<double> finger(2); // current finger displacement [m]
std::vector<double> finger_r(2); // reference finger displacement [m]

bool get_config; // get current joint angles
bool get_config_r; // get reference joint angles

// publishers and subscribers
ros::Subscriber sub_state;
ros::Publisher pub_joint_cmd[7];
ros::Publisher pub_finger_cmd[2];

void jointStatesCallback(const sensor_msgs::JointState& jointstatesmsg)
{
    if( (get_config == false) || (get_config == true && get_config_r==true) )
    {
        for (int i=0; i<jointstatesmsg.position.size(); i++)
        {
            if(i==0 || i==1)
            {
                finger[i] = jointstatesmsg.position[i]; // finger displacement // i=0: panda_finger_joint1, i=1: panda_finger_joint_2
            }
            else
            {
                q[i-2]= jointstatesmsg.position[i]; // arm joints
            }
        } 
        get_config = true;
    }   

    if(get_config == true && get_config_r==false)
    {
        for (int i=0; i<q.size(); i++)
        {
            std::cout << "panda_joint_q" + std::to_string(i+1) + " : " + std::to_string(q_lowerlimit[i]) + " < " + std::to_string(q[i]) + " < " + std::to_string(q_upperlimit[i])  << std::endl;
        }
        for (int i=0; i<finger.size(); i++)
        {
            std::cout << "panda_finger" + std::to_string(i+1) + " : " + std::to_string(finger_lowerlimit[i]) + " < " + std::to_string(finger[i]) + " < " + std::to_string(finger_upperlimit[i])  << std::endl;
        }
        std::cout << std::endl;
    }
}

int main(int argc, char **argv)
{
    get_config = false;
    get_config_r = false;

    // initialize ROS, specify ROS node, and initialize this ROS node
    ros::init(argc, argv, "panda_positioncontrol_jointspace"); 
    ros::NodeHandle n;
    ros::Rate loop_rate(1000); 

    // get the current robot configuration (joint angles and finger displacements)
    sub_state = n.subscribe("/panda/joint_states",1,jointStatesCallback);

    // send joint commands to robot
    for(int i=0; i<q.size(); i++)
    {
        pub_joint_cmd[i] = n.advertise<std_msgs::Float64>("/panda/joint" + std::to_string(i+1) + "_position_controller/command",100);
    }
    // send finger displacement commands to robot
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


    while(ros::ok())
    {
        if(get_config==true && get_config_r==false)
        {
            std::cout << "Give 7 desired joint angles: " << std::endl;
            for (int i=0; i<qr.size();i++)
            {
                double input_joint;
                std::cin >> input_joint;
                qr[i] = input_joint;
            }
            std::cout << std::endl;
            std::cout << "Give the desired finger displacement" << std::endl;
            double input_finger;
            std::cin >> input_finger;

            for (int i=0; i<finger_r.size();i++)
            {
                finger_r[i] = input_finger;
            }
            get_config_r=true;
        }

        else if(get_config==true && get_config_r==true)
        {
            for (int i=0; i<qr.size();i++)
            {
                std_msgs::Float64 qr_msg;
                qr_msg.data = qr[i];
                pub_joint_cmd[i].publish(qr_msg);
            }
            for (int i=0; i<finger_r.size();i++)
            {
                std_msgs::Float64 finger_r_msg;
                finger_r_msg.data = finger_r[i];
                pub_finger_cmd[i].publish(finger_r_msg);
            }
        }

        ros::spinOnce();
        loop_rate.sleep();    
    }
    ros::waitForShutdown();
    return 0;
}