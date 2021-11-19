#from stable_baselines3.common.env_checker import check_env
#from panda_env import CobotEnv
import rospy
#import gym
from std_msgs.msg import Float64
import numpy as np

from gazebo_msgs.srv import SpawnModel, DeleteModel
from geometry_msgs.msg import Pose,PoseStamped
import geometry_msgs.msg
import os

from gazebo_msgs.srv import GetModelState
import moveit_commander
from sensor_msgs.msg import JointState


class sub_class():
  def __init__(self):
    JOINT_STATE_TOPIC = '/panda/joint_states'
    EE_STATE_TOPIC = '/panda/robot_states'
    self.data_js = None
    self.data_ees = None
    self._sub_joint = rospy.Subscriber(JOINT_STATE_TOPIC, JointState, self.sub_joint_cb)
    self._sub_ee = rospy.Subscriber(EE_STATE_TOPIC, PoseStamped, self.sub_ee_cb)
  
  def sub_joint_cb(self, data):
    self.data_js = data

  def sub_ee_cb(self, data):
    self.data_ees = data

  def step(self):
    a = self.data_js
    print(a)
    #rospy.spin()


if __name__ == "__main__":

  # test subscriber
  test_object = sub_class()

  # test moveit
  rospy.init_node('test')
  move_group = moveit_commander.MoveGroupCommander("panda_arm")

  # joint_goal = move_group.get_current_joint_values()
  # joint_goal[0] = 0.0
  # joint_goal[1] = 0.0
  # joint_goal[2] = 0.0
  # joint_goal[3] = -0.5
  # joint_goal[4] = 0.0
  # joint_goal[5] = 0.0
  # joint_goal[6] = -0.5
  # success = move_group.go(joint_goal, wait=True)
  # move_group.stop()
  #ctl + / to comment out a section of code

  # pose_goal = geometry_msgs.msg.Pose()
  # pose_goal.orientation.x = 1.0
  # pose_goal.orientation.y = 0.0
  # pose_goal.orientation.z = 0.0
  # pose_goal.orientation.w = 0.0
  # pose_goal.position.x = 0.5
  # pose_goal.position.y = 0.2
  # pose_goal.position.z = 0.3

  # move_group.set_pose_target(pose_goal)
  move_group.set_pose_target([0.55, 0.0, 0.5, 3.14, 0 , -0.54])
  plan = move_group.go(wait=True)
  move_group.stop()
  move_group.clear_pose_targets()

  # Test methods to get ee position
  # data_ees_local = test_object.data_ees
  # wpose = move_group.get_current_pose().pose
  # point_1 = np.array([data_ees_local.pose.position.x, data_ees_local.pose.position.y, data_ees_local.pose.position.z, data_ees_local.pose.orientation.x, data_ees_local.pose.orientation.y, data_ees_local.pose.orientation.z, data_ees_local.pose.orientation.w])
  # point_2 = np.array([wpose.position.x, wpose.position.y, wpose.position.z, wpose.orientation.x, wpose.orientation.y, wpose.orientation.z, wpose.orientation.w])
  #point_2 = np.array([0.5, 0.2, 0.3, 1.0, 0.0, 0.0, 0.0])
  #point_1 = np.array([data_ees_local.pose.position.x, data_ees_local.pose.position.y, data_ees_local.pose.position.z])
  #point_2 = np.array([0.5, 0.2, 0.3])
  #point_1 = np.array([data_ees_local.pose.orientation.x, data_ees_local.pose.orientation.y, data_ees_local.pose.orientation.z, data_ees_local.pose.orientation.w])
  #point_2 = np.array([1.0, 0.0, 0.0, 0.0])

  # err = np.subtract(point_1, point_2)
  # dist = np.linalg.norm(err)
  # print(point_1)
  # print(point_2)

  # ee_rpy = move_group.get_current_rpy()
  # print(type(ee_rpy))


  # print(err)
  # print(dist)



