/*********************************************************************
 * Software License Agreement (BSD License)
 *
 *  Copyright (c) 2013, SRI International
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above
 *     copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided
 *     with the distribution.
 *   * Neither the name of SRI International nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 *  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 *  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 *  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *  POSSIBILITY OF SUCH DAMAGE.
 *********************************************************************/

/* Author: Sachin Chitta, Dave Coleman, Mike Lautman */
#include <ros/ros.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

#include <moveit_visual_tools/moveit_visual_tools.h>

#include <moveit/planning_scene/planning_scene.h>

#include <moveit/robot_state/robot_state.h>
#include <moveit/robot_model/robot_model.h>
#include <geometry_msgs/PoseStamped.h>





int main(int argc, char** argv)
{
	ros::init(argc, argv, "planner");
	ros::NodeHandle node_handle;
	ros::AsyncSpinner spinner(1);
	spinner.start();



	// BEGIN_TUTORIAL
	//
	// Setup
	// ^^^^^
	//
	// MoveIt operates on sets of joints called "planning groups" and stores them in an object called
	// the `JointModelGroup`. Throughout MoveIt the terms "planning group" and "joint model group"
	// are used interchangably.
	static const std::string PLANNING_GROUP = "panda_arm";

	// The :planning_interface:`MoveGroupInterface` class can be easily
	// setup using just the name of the planning group you would like to control and plan for.
	moveit::planning_interface::MoveGroupInterface move_group(PLANNING_GROUP);

	// We will use the :planning_interface:`PlanningSceneInterface`
	// class to add and remove collision objects in our "virtual world" scene
	moveit::planning_interface::PlanningSceneInterface planning_scene_interface;

	// Raw pointers are frequently used to refer to the planning group for improved performance.
	const moveit::core::JointModelGroup* joint_model_group = move_group.getCurrentState()->getJointModelGroup(PLANNING_GROUP);


	robot_model_loader::RobotModelLoader robot_model_loader("robot_description");
	const moveit::core::RobotModelPtr& robot_model = robot_model_loader.getModel();


	// Using the :moveit_core:`RobotModel`, we can construct a :planning_scene:`PlanningScene`
	// that maintains the state of the world (including the robot).
	planning_scene::PlanningScenePtr planning_scene(new planning_scene::PlanningScene(robot_model));

	// Configure a valid robot state
	planning_scene->getCurrentStateNonConst().setToDefaultValues(joint_model_group, "ready");
	
	// (Optional) Create a publisher for visualizing plans in Rviz.
	ros::Publisher display_publisher = node_handle.advertise<moveit_msgs::DisplayTrajectory>("/move_group/display_planned_path", 1, true);
	moveit_msgs::DisplayTrajectory display_trajectory;
	// Visualization
	// ^^^^^^^^^^^^^
	//
	// The package MoveItVisualTools provides many capabilities for visualizing objects, robots,
	// and trajectories in RViz as well as debugging tools such as step-by-step introspection of a script.
	namespace rvt = rviz_visual_tools;
	moveit_visual_tools::MoveItVisualTools visual_tools("panda_link0");
	//visual_tools.deleteAllMarkers();

	// Remote control is an introspection tool that allows users to step through a high level script
	// via buttons and keyboard shortcuts in RViz
	//visual_tools.loadRemoteControl();


	// Adding objects to the environment
	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 	// adding the obstacles
	moveit_msgs::CollisionObject collision_object;
	collision_object.header.frame_id = move_group.getPlanningFrame();

	//The id of the object is used to identify it.
	collision_object.id = "obst";

	
	// define a sphere
	shape_msgs::SolidPrimitive primitive;
	primitive.type = primitive.BOX;
	primitive.dimensions.resize(3);
	primitive.dimensions[0] = 0.3;
	primitive.dimensions[1] = 0.1;
	primitive.dimensions[2] = 1;

	geometry_msgs::Pose pose;
	pose.orientation.w = 1.0;
	pose.position.x = 0.6;
	pose.position.y = 0.3;
	pose.position.z = 0;


	collision_object.primitives.push_back(primitive);
	collision_object.primitive_poses.push_back(pose);
	collision_object.operation = collision_object.ADD;

	std::vector<moveit_msgs::CollisionObject> collision_objects;
	collision_objects.push_back(collision_object);
	//planning_scene_interface.addCollisionObjects(collision_objects);

	move_group.setPlannerId("PRMkConfigDefault");


	// we define the task space poses to reach an ask moveit to plan
	geometry_msgs::Pose target_pose;
	float positions[4][7] = {
		{1, 0, 0, 0, 0.6, 0.1, 0.1},
		{1, 0, 0, 0, 0.6, 0.5, 0.1},
		{0.258968, -0.3913198, -0.8754454, 0.1157574, 0, 0, 1},
		{0.8665724, -0.4105948, -0.1214592, -0.2563433, -0.3, -0.5, 0.6} 
	};


	
	moveit::core::RobotStatePtr kinematic_state(new moveit::core::RobotState(robot_model));



	// we loop for 4 references and return to the departure
	for (int i=0; i<=4; i++){
		target_pose.orientation.x = positions[i%4][0];
		target_pose.orientation.y = positions[i%4][1];
		target_pose.orientation.z = positions[i%4][2];
		target_pose.orientation.w = positions[i%4][3];


		target_pose.position.x = positions[i%4][4];
		target_pose.position.y = positions[i%4][5];
		target_pose.position.z = positions[i%4][6];
		
		move_group.setPoseTarget(target_pose);

		// Now, we call the planner to compute the plan
		// and visualize it.
		// Note that we are just planning, not asking move_group 
		// to actually move the robot.
		moveit::planning_interface::MoveGroupInterface::Plan my_plan;
 		moveit::planning_interface::MoveItErrorCode success = move_group.plan(my_plan); 
		//visual_tools.publishTrajectoryLine(my_plan.trajectory_, joint_model_group);
		//visual_tools.trigger();
		// Sleep to give Rviz time to visualize the plan. 
		move_group.move();	
//		ros::Duration(6.0).sleep();

	}

		






	/** Now, let's remove the objects from the world.
	std::vector<std::string> object_ids;
	object_ids.push_back(collision_object.id);
	object_ids.push_back(object_to_attach.id);
	planning_scene_interface.removeCollisionObjects(object_ids); **/


	// END_TUTORIAL

	ros::shutdown();
	return 0;
}
