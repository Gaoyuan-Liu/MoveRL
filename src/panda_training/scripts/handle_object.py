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
from gazebo_msgs.srv import GetModelProperties, GetModelState, GetWorldProperties, SetModelState, SpawnModel, DeleteModel
from gazebo_msgs.msg import ModelState
from geometry_msgs.msg import PoseStamped, Pose
import numpy as np
import tf
import os


class Object_Handle:
    
    def __init__(self):
        self.model_spawn = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
        self.model_delete = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
        self.set_pose_client = rospy.ServiceProxy('/gazebo/set_model_state', SetModelState)
        self.get_pose_client = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)

        # self.model_state_init()
        
    def object_state_init(self):
        model_state_set = ModelState()
        model_state_set.model_name = 'pushed_object'
        model_state_set.reference_frame = 'world'
        obj_pose = Pose()
        obj_pose.position.x = 0.5
        obj_pose.position.y = 0.0
        obj_pose.position.z = 1.05
        obj_pose.orientation.z = np.random.uniform(0, 3.14)
        model_state_set.pose = obj_pose
        self.set_pose_client(model_state_set)

    def get_obj_pose(self, obj_name='pushed_object'):
        model_state_get = ModelState()
        model_state_get = self.get_pose_client(obj_name, 'world')
        return model_state_get.pose
    
    def spawn_goal(self, goal_position):
        model_name = 'goal'

        goal_pose = Pose()
        goal_pose.position.x = goal_position[0]
        goal_pose.position.y = goal_position[1]
        goal_pose.position.z = goal_position[2] + 1.0

        robot_namespace = ''

        outdir = os.path.dirname(os.path.abspath(__file__))
        f = open(outdir + "/../../panda_gazebo/models/push_goal/model.sdf",'r')
        goal_model_xml = f.read()

        reference_frame = 'world'

        self.model_spawn(model_name, goal_model_xml, robot_namespace, goal_pose, reference_frame)

    def move_static_model(self, model_name, model_position):
        self.model_delete(model_name)
        rospy.sleep(0.5)
        model_name = model_name

        goal_pose = Pose()
        goal_pose.position.x = model_position[0]
        goal_pose.position.y = model_position[1]
        goal_pose.position.z = 1.0005 # model_position[2] + 1.0

        robot_namespace = ''

        outdir = os.path.dirname(os.path.abspath(__file__))
        f = open(outdir + "/../../panda_gazebo/models/push_goal/model.sdf",'r')
        goal_model_xml = f.read()

        reference_frame = 'world'

        self.model_spawn(model_name, goal_model_xml, robot_namespace, goal_pose, reference_frame)



if __name__ == "__main__":
    # Locate local working directory on where this file is
    # outdir = os.path.dirname(os.path.abspath(__file__))
    # os.chdir(outdir)

    rospy.init_node("text")
    object_object = Object_Handle()

    # object_object.spawn_goal([0.4, 0.4, 0.005])
    pose = object_object.get_obj_pose('pushed_object')
    print(pose)
    # rospy.sleep(2.0)
    # object_object.move_static_model('goal', [0.0, 0.4, 0.0005])
    # object_object.object_state_init()
