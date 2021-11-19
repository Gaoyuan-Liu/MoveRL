import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
import actionlib
import math
import time
import copy
import threading
from gazebo_msgs.srv import GetModelProperties, GetModelState, GetWorldProperties, SetModelState
from gazebo_msgs.msg import ModelState
from geometry_msgs.msg import PoseStamped, Pose
import numpy as np
import tf
import os
from gazebo_msgs.srv import SpawnModel


class Gazebo_Handle:
    
    def __init__(self):
        self.model_spawn = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
        self.set_pose_client = rospy.ServiceProxy('/gazebo/set_model_state', SetModelState)
        self.get_pose_client = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
        self.model_state_set = ModelState()
        self.model_state_get = ModelState()
        # self.model_state_init()
        
    def model_state_init(self):
        self.model_state_set.model_name = 'pushed_cylinder'
        self.model_state_set.reference_frame = 'world'
        obj_pose = Pose()
        obj_pose.position.x = 0.5
        obj_pose.position.y = 0.0
        obj_pose.position.z = 1.05
        self.model_state_set.pose = obj_pose
        self.set_pose_client(self.model_state_set)

    def get_obj_pose(self, obj_name):
        self.model_state_get = self.get_pose_client(obj_name, 'world')
        return self.model_state_get.pose
    

if __name__ == "__main__":
    # Locate local working directory on where this file is
    outdir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(outdir)

    rospy.init_node("text")
    object_object = Object_Handle()

    object_object.model_state_init()
    pose = object_object.get_obj_pose('pushed_cylinder')
    print(pose)