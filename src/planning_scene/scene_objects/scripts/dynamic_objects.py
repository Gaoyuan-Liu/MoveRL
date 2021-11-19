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
from geometry_msgs.msg import PoseStamped, Pose
import numpy as np
from gazebo_msgs.srv import GetModelState

class scene_update():
    def __init__(self):
        self.scene = moveit_commander.PlanningSceneInterface()

        self.obj_shape= 'cylinder'
        self.obj_name= 'cylinder'
        self.obj_size = np.array([0.4, 0.1])
        self.obj_pose = PoseStamped()
        self.obj_pose.header.frame_id = 'world'
        self.data_ob_client = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
    
    def obj_cmd(self, shape, name, pose, size):
        success = False
        if shape == 'cylinder':
            self.scene.add_cylinder(name, pose, size[0], size[1])
            success = name in self.scene.get_known_object_names()
        return success

    def update(self):
        data_ob = self.data_ob_client('object', 'world').pose
        current_state = np.array([data_ob.position.x, data_ob.position.y, data_ob.position.z, 
                                data_ob.orientation.x, data_ob.orientation.y, data_ob.orientation.z, data_ob.orientation.w])
        self.obj_pose.pose.position.x = current_state[0]
        self.obj_pose.pose.position.y = current_state[1]
        self.obj_pose.pose.position.z = current_state[2] - 1.0
        self.obj_pose.pose.orientation.x = current_state[3]
        self.obj_pose.pose.orientation.y = current_state[4]
        self.obj_pose.pose.orientation.z = current_state[5]
        self.obj_pose.pose.orientation.w = current_state[6]
        
        success_1 = self.obj_cmd(self.obj_shape, self.obj_name, self.obj_pose, self.obj_size)

        data_ob_2 = self.data_ob_client('object_2', 'world').pose
        current_state = np.array([data_ob_2.position.x, data_ob_2.position.y, data_ob_2.position.z, 
                                data_ob_2.orientation.x, data_ob_2.orientation.y, data_ob_2.orientation.z, data_ob_2.orientation.w])
        self.obj_pose.pose.position.x = current_state[0]
        self.obj_pose.pose.position.y = current_state[1]
        self.obj_pose.pose.position.z = current_state[2] - 1.0
        self.obj_pose.pose.orientation.x = current_state[3]
        self.obj_pose.pose.orientation.y = current_state[4]
        self.obj_pose.pose.orientation.z = current_state[5]
        self.obj_pose.pose.orientation.w = current_state[6]
        
        success_2 = self.obj_cmd(self.obj_shape, 'cylinder_2', self.obj_pose, self.obj_size)

        success = success_1 and success_2

        return success


def main():

    rospy.init_node('add_objects')

    scene = scene_update()

    r = rospy.Rate(1000) # 1Hz

    while not rospy.is_shutdown():
        scene.update()
        r.sleep()
    

if __name__ == '__main__':
    main()