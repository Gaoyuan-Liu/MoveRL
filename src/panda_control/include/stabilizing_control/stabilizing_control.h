#include <cmath>
#include <iostream>

#include <ros/ros.h>

#include <std_msgs/Float64.h>
#include <std_msgs/Empty.h>
#include <sensor_msgs/JointState.h>

#include <Eigen/Dense>
#include <Eigen/Core>

#include <kdl_parser/kdl_parser.hpp>
#include <kdl/chain.hpp>
#include <kdl/jntarray.hpp>
#include <kdl/chaindynparam.hpp>
#include <kdl/chainfksolver.hpp>
#include <kdl/chainfksolverpos_recursive.hpp>
#include <kdl/frames_io.hpp>

#include <kdl/chainiksolver.hpp>
#include <kdl/chainiksolvervel_pinv.hpp>
#include <kdl/chainiksolverpos_nr.hpp>
#include <kdl/chainiksolverpos_nr_jl.hpp>

class StabilizingControl
{
private:
    ros::NodeHandle n;
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW
    
public:
    StabilizingControl(std::string name);
    ~StabilizingControl();   

    // ROS subscribers and publishers
    ros::Subscriber sub_state;
    ros::Publisher pub_joint_effort_cmd[7];
    ros::Publisher pub_joint_cmd[7];
    ros::Publisher pub_finger_cmd[2];


    bool print_q;  // get current joint angles and initialize q_r
    bool kinematics_status;
    bool inversekinematics_status;

    unsigned int joint_num; // can only be a positive value
    double samplingFreq; //[Hz]

    typedef Eigen::Matrix<double,7,1> JointVector; 
    typedef Eigen::Matrix<double,2,1> FingerVector;
    typedef Eigen::Matrix<double,3,1> PositionVector;
    typedef Eigen::Matrix<double,4,1> QuaternionVector;


    FingerVector finger_lowerlimit;
    FingerVector finger_upperlimit; 
    FingerVector finger;
    FingerVector finger_r; 

    JointVector q_lowerlimit; 
    JointVector q_upperlimit;
    JointVector q_init;
    JointVector q;
    JointVector q_r; 
    JointVector dotq;
        
    PositionVector pos_r; 
    QuaternionVector orient_r;

    JointVector Kp;
    JointVector Ki;
    JointVector Kd;
    JointVector i_error;
    JointVector i_clamp;
    JointVector tau_cmd;


    KDL::Tree kdl_tree;
    KDL::Chain kdl_chain;

    KDL::JntArray kdl_q_lowerlimit;
    KDL::JntArray kdl_q_upperlimit;
    KDL::JntArray kdl_q;            // represents actual, predicted, and applied joint angles
    KDL::JntArray kdl_q_r;
    KDL::JntArray kdl_dotq;         // represents actual and predicted joint velocities
    
    KDL::JntArray kdl_gravity_effort;
    KDL::Vector gravity;
    std::shared_ptr<KDL::ChainDynParam> dyn_param;

    KDL::Frame kdl_x;;
    
    void jointStatesCallback(const sensor_msgs::JointState& jointstatesmsg);
    void PIDcontrol();
    void updateKDLq(JointVector& q_arg);
    void updateKDLdotq(JointVector& dotq_arg);
    void updateKDLdynamics();
    void armControl();
    void handControl();
    void forwardKinematics();
    void inverseKinematics();
};