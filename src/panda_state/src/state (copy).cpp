#include <ros/ros.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

#include <moveit_visual_tools/moveit_visual_tools.h>

#include <moveit/planning_scene/planning_scene.h>

#include "planner.h"
#include <moveit/robot_state/robot_state.h>
#include <moveit/robot_model/robot_model.h>
#include <geometry_msgs/PoseStamped.h>



geometry_msgs::PoseStamped getPose(moveit::planning_interface::MoveGroupInterface* move_group ){
		// compute end effector pose 
		geometry_msgs::PoseStamped pose = move_group->getCurrentPose();
		return pose;
};

void publishPose(ros::Publisher robot_state_pub, geometry_msgs::PoseStamped pose){
	panda_simulation2::RobotStates msg;
	msg.xe[0].data = pose.pose.position.x;
	msg.xe[1].data = pose.pose.position.y;
	msg.xe[2].data = pose.pose.position.z;
	msg.header.stamp = pose.header.stamp;
	robot_state_pub.publish(msg);
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "state");
    ros::NodeHandle node_handle;
    // Create a ROS publisher
    robot_state_pub  = node_handle.advertise<panda_simulation2::RobotStates>("/panda/robot_states",50);
    // Create a rate
    ros::Rate rate(100);
    // Use the rate to publish at a fixed rate
    // inside the main function of the program
	static const std::string PLANNING_GROUP = "panda_arm";

	// The :planning_interface:`MoveGroupInterface` class can be easily
	// setup using just the name of the planning group you would like to control and plan for.
	moveit::planning_interface::MoveGroupInterface move_group(PLANNING_GROUP);


	ros::AsyncSpinner spinner(1);
	spinner.start();



	
    while (ros::ok())
    {
        geometry_msgs::PoseStamped val = getPose(&move_group);
		publishPose(robot_state_pub,val);
        rate.sleep();
    }
}
