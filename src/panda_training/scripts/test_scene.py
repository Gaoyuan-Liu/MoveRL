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
from gazebo_msgs.msg import LinkStates
import moveit_commander
from sensor_msgs.msg import JointState

class scene_update():
  def __init__(self):
    self.scene = moveit_commander.PlanningSceneInterface()

    self.obj_shape= 'cylinder'
    self.obj_name= 'cylinder'
    self.obj_size = np.array([0.4, 0.1]) # length, radius
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



class sub_class():
  def __init__(self):
    JOINT_STATE_TOPIC = '/panda/joint_states'
    EE_STATE_TOPIC = '/panda/robot_states'
    ARM_STATE_TOPIC = '/gazebo/link_states'
    self.data_js = None
    self.data_ees = None
    self._sub_joint = rospy.Subscriber(JOINT_STATE_TOPIC, JointState, self.sub_joint_cb)
    self._sub_ee = rospy.Subscriber(EE_STATE_TOPIC, PoseStamped, self.sub_ee_cb)
    self._sub_arms = rospy.Subscriber(ARM_STATE_TOPIC, LinkStates, self.sub_arms_cb)
  
  def sub_joint_cb(self, data):
    self.data_js = data

  def sub_ee_cb(self, data):
    self.data_ees = data

  def sub_arms_cb(self, data):
    self.data_arms = data

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
  updater = scene_update()

  r = rospy.Rate(10)

  upper_arm_size = np.array([0.27379, 0.030014])
  fore_arm_size = np.array([0.22718, 0.020009])

  obj_pose_1 = PoseStamped()
  obj_pose_2 = PoseStamped()

  obj_pose_1.header.frame_id = 'world'
  obj_pose_2.header.frame_id = 'world'

  while not rospy.is_shutdown():

    lu_arm_index = test_object.data_arms.name.index('human_model::LeftUpperArm')
    lu_arm_pose = test_object.data_arms.pose[lu_arm_index]
    lu_arm_pose.position.z = lu_arm_pose.position.z - 1

    

    lf_arm_index = test_object.data_arms.name.index('human_model::LeftForeArm')
    lf_arm_pose = test_object.data_arms.pose[lf_arm_index]
    lf_arm_pose.position.z = lf_arm_pose.position.z - 1



    obj_pose_1.pose = lu_arm_pose
    updater.obj_cmd('cylinder', 'lu', obj_pose_1, upper_arm_size)

    obj_pose_2.pose = lf_arm_pose
    updater.obj_cmd('cylinder', 'lf', obj_pose_2, fore_arm_size)




    r.sleep()






