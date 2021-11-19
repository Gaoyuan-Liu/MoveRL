#from stable_baselines3.common.env_checker import check_env
#from panda_env import CobotEnv
import rospy
from rospy.timer import sleep
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
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

import tf


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

  # Go joint space
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
  
  # Go pose
  # pose_goal = geometry_msgs.msg.Pose()
  # pose_goal.orientation.x = 1.0
  # pose_goal.orientation.y = 0.0
  # pose_goal.orientation.z = 0.0
  # pose_goal.orientation.w = 0.0
  # pose_goal.position.x = 0.5
  # pose_goal.position.y = 0.2
  # pose_goal.position.z = 0.3
  # move_group.set_pose_target(pose_goal)
  # move_group.set_pose_target([0.5, 0.0, 0.4, 3.14, 0.0, 0.0])
  # move_group.plan()
  # plan = move_group.go(wait=True)
  # move_group.stop()
  # move_group.clear_pose_targets()

  # Get ee position
  # data_ees_local = test_object.data_ees
  # wpose = move_group.get_current_pose().pose
  # point_1 = np.array([data_ees_local.pose.position.x, data_ees_local.pose.position.y, data_ees_local.pose.position.z, data_ees_local.pose.orientation.x, data_ees_local.pose.orientation.y, data_ees_local.pose.orientation.z, data_ees_local.pose.orientation.w])
  # point_2 = np.array([wpose.position.x, wpose.position.y, wpose.position.z, wpose.orientation.x, wpose.orientation.y, wpose.orientation.z, wpose.orientation.w])

  # Get rpy
  # ee_rpy = move_group.get_current_rpy()
  #print(ee_rpy)


  # Compute cartesian path
  q = tf.transformations.quaternion_from_euler(3.14, 0, 0, axes='ryxz')
  wpose = geometry_msgs.msg.Pose()
  wpose.orientation.w = q[0]
  wpose.orientation.x = q[1]
  wpose.orientation.y = q[2]
  wpose.orientation.z = q[3]
  wpose.position.x = 0.21
  wpose.position.y =  0.01
  wpose.position.z = 0.41

  waypoints = [wpose]
  (traj, fraction) = move_group.compute_cartesian_path(waypoints,   # waypoints to follow
                                                        0.01,        # eef_step
                                                        0,
                                                        False)

  #move_group.execute(traj)
  print(traj)
  cmdPublisher = rospy.Publisher('/panda/panda_arm_controller/command', JointTrajectory, queue_size=10)

  sleep(10) # Wait for the subscriber 

  r = rospy.Rate(10)
  cmdPublisher.publish(traj.joint_trajectory)

  # Allow looking
  # move_group.allow_looking(False)
  # move_group.set_pose_target([0.3, 0.0, 0.1, 3.14, 0.0, 0.0])
  # success = move_group.go()
  # move_group.stop()




