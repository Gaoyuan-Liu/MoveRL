#!/usr/bin/env python

import sys
import copy
import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
from math import pi
from std_msgs.msg import String
from moveit_commander.conversions import pose_to_list

def main():
    rospy.init_node('add_objects')
    scene = moveit_commander.PlanningSceneInterface()
    rospy.sleep(1)

    # Table 
    box_pose = geometry_msgs.msg.PoseStamped()
    box_pose.header.frame_id = "world"
    box_pose.pose.orientation.w = 1.0
    box_pose.pose.position.x = 0.0
    box_pose.pose.position.y = 0.0
    box_pose.pose.position.z = -0.015 # -0.015
    box_name = "table"
    scene.add_box(box_name, box_pose, size=(1.5, 0.8, 0.03)) #(2.0, 2.0, 0.03))

    # Cylinder
    # cylinder_pose = geometry_msgs.msg.PoseStamped()
    # cylinder_pose.header.frame_id = "world"
    # cylinder_pose.pose.orientation.w = 1.0
    # cylinder_pose.pose.position.x = 0.0
    # cylinder_pose.pose.position.y = 0.0
    # cylinder_pose.pose.position.z = -0.015
    # cylinder_name = "cylinder"
    # height = 1.0
    # radius = 0.2
    # scene.add_cylinder(cylinder_name, cylinder_pose, height, radius)

    

    current_known_objects = scene.get_known_object_names()
    timeout = 4
    start = rospy.get_time()
    while True:
        current_known_objects = scene.get_known_object_names()
        if box_name not in current_known_objects:
            print("Wait for the object to spawn.")
            rospy.sleep(0.5)
            seconds = rospy.get_time()
            if seconds - start > timeout:
                print("Add objects failed.")
                break

        else:
            print("Add objects done!")
            break

    #tutorial.remove_box()
    
    #return True

if __name__ == '__main__':
    main()