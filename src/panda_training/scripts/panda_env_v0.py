#! /venv3.8/bin/python


# source ~/venv3.8/bin/activate
import os

import gym
from gym import utils, spaces
from gym.utils import seeding
from gym.envs.registration import register
from gym import spaces
from matplotlib.pyplot import step
from numpy.core.fromnumeric import size
import rospy
import rospkg
import time
import numpy as np
import time

import sys
from gazebo_connection import GazeboConnection
from gazebo_msgs.srv import GetModelState, GetWorldProperties

# Import msgs
from std_msgs.msg import Float64, String
from sensor_msgs.msg import JointState
from geometry_msgs.msg import Point
#from rl_interface.srv import PandaCmd
from std_msgs.msg import Float64, Float64MultiArray
from scene_objects.srv import AddObjects, AddObjectsResponse

from moveit_msgs.srv import GetStateValidityRequest, GetStateValidity
from moveit_msgs.msg import RobotState

from gazebo_msgs.srv import SpawnModel, DeleteModel
from geometry_msgs.msg import PoseStamped, Pose

# Import moveit
import moveit_commander

# Handles
from scene_handle import Scene_Handle
from cmd_handle import Cmd_Handle
from collision_handle import Collision_Handle

# Plot
import pandas as pd

max_episode_steps=100

reg = register(
    id='PandaRlEnvironment-v0',
    entry_point='panda_env_v0:CobotEnv',
    max_episode_steps=100,
    )

class CobotEnv(gym.Env):
    def __init__(self):
      super(CobotEnv, self).__init__()

      self.time_fraction = 0.05

      # Reward function parameters
      self.distance_rew_factor = 10
      self.achieve_reward = 10
      self.collision_punishment = 0

      # Planning scene
      self.scene_handle = Scene_Handle()
      obs_num = self.scene_handle.obs_num
      self.obs_list = self.scene_handle.obs_list
      self.dynamic_world = False

      # Commander
      # TODO: discussing the exe_time
      self.cmd_handle = Cmd_Handle(exe_time=0.3, mode='joint_space')
      self.safety_layer = True

      # Collision checker
      self.collision_handle = Collision_Handle()

      # Data collecting
      self.collision_times = 0
      self.episode_length = 0
      self.episode_return = 0
      self.plot_data = pd.DataFrame({'ct':[], 'el':[], 'er':[], 't':[]})
      self.t_start = time.time()
      self.t_now = time.time()
    
      # State limits
      self.q_min = np.array([-2.8973, -1.7628, -2.8973, -3.0718, -2.8973, -0.0175, -2.8973])
      self.q_max = np.array([2.8973, 1.7628, 2.8973, -0.0698, 2.8973, 3.7525, 2.8973])

      self.d_q_limit = self.time_fraction * np.array([2.1750, 2.1750, 2.1750, 2.1750, 2.6100, 2.6100, 2.6100])

      self.p_min = np.array([-0.855, -0.855, 0.0, -3.14, -3.14, -3.14])
      self.p_max = np.array([0.855, 0.855, 1.19, 3.14, 3.14, 3.14])

      self.goal_min = np.array([0.1, -0.6, 0.2, -3.14, -3.14, -3.14]) # x, y, z
      self.goal_max = np.array([0.6, 0.6, 0.7, -3.14, -3.14, -3.14])

      self.obs_pos_min = np.array([-2.0, -2.0, 0.0, -1.0, -1.0, -1.0, -1.0] * obs_num)
      self.obs_pos_max = np.array([2.0, 2.0, 3.0, 1.0, 1.0, 1.0, 1.0] * obs_num)


      # Action contains 7 joint angles
      self.action_space = spaces.Box(low=np.array([-1]*7, dtype=np.float32), high=np.array([1]*7, dtype=np.float32))

      # Observation contains 7 joint angles, end-effector current position, goal position, obstacle position
      # 7 + 7 + 7 + 14
      self.observation_space = spaces.Box(low=np.concatenate((self.q_min, self.p_min, self.goal_min, self.obs_pos_min)), 
                                          high=np.concatenate((self.q_max, self.p_max, self.goal_max, self.obs_pos_max)), 
                                          dtype=np.float64)

      # Init pose
      self.init_state = np.array([0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0])

      # Gazebo interface
      self.gazebo = GazeboConnection() 

      # Set goal ee position
      self.goal = np.array([0.35, 0.0, 0.2]) # [0.35, 0.0, 0.2] [0.4 0.2 0.3][0.4, 0.2, 0.2]
      self.goal_spawn = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
      self.goal_delete = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
      self.model_name = 'goal'
      outdir = os.path.dirname(os.path.abspath(__file__))
      f = open(outdir + "/../../panda_gazebo/models/goal/model.sdf",'r')
      self.goal_model_xml = f.read()
      self.robot_namespace = ''
      self.initial_pose = Pose()
      self.initial_pose.position.x = self.goal[0]
      self.initial_pose.position.y = self.goal[1]
      self.initial_pose.position.z = self.goal[2] + 1.0
      self.reference_frame = 'world'
      self.goal_spawn(self.model_name, self.goal_model_xml, self.robot_namespace, self.initial_pose, self.reference_frame)
   
      # Moveit interface
      # Here we only use move_group to do observation
      self.move_group = moveit_commander.MoveGroupCommander("panda_arm")

      # Collision client
      self.panda_checker = rospy.ServiceProxy('/check_state_validity', GetStateValidity)
      self.checker_rs = RobotState()
      self.checker_rs.joint_state.name = ['panda_finger_joint1', 'panda_finger_joint2', 'panda_joint1', 'panda_joint2', 'panda_joint3', 'panda_joint4', 'panda_joint5', 'panda_joint6', 'panda_joint7']
      self.checker_rs.joint_state.position = [0.02, 0.0, 0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0]
      self.gsvr = GetStateValidityRequest()
      self.gsvr.robot_state = self.checker_rs
      self.gsvr.group_name = "panda_arm"

      # For observation
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
      


    ###########################
    #           Reset         #
    ###########################

    def reset(self):

      self.goal_delete(self.model_name)

      # Countinue sim
      self.gazebo.unpauseSim()
      print("==== New episode ====")

      # Go initial pose
      self.init_pose()

      # Get observation
      observation = self.take_observation()

      #self.gazebo.pauseSim()
      # Data collection
      print("Collision times = " + str(self.collision_times))
      self.t_now = time.time()
      df = pd.DataFrame({'ct':[self.collision_times], 'el':[self.episode_length], 'er':[self.episode_return], 't':[self.t_now-self.t_start]})
      self.plot_data = self.plot_data.append(df, ignore_index=True)
      self.episode_length = 0
      self.episode_return = 0
      self.collision_times = 0
      
      # Set goal model
      # self.goal_delete(self.model_name)

      self.initial_pose.position.x = self.goal[0]
      self.initial_pose.position.y = self.goal[1]
      self.initial_pose.position.z = self.goal[2] + 1.0
      ee_point = observation[7:10]
      self.last_dis = self.distance(ee_point, self.goal)
      self.goal_spawn(self.model_name, self.goal_model_xml, self.robot_namespace, self.initial_pose, self.reference_frame)
      

      return observation

    ###########################
    #           Step          #
    ###########################

    def step(self, action):
      # if self.episode_length == 0:
      #   self.collision_times = 0

      #self.gazebo.unpauseSim()
      if rospy.is_shutdown():
        exit()

      print("== Step " + str(self.episode_length) + " ==")
      #print(action)
      # Calculate action command
      current_state = self.take_observation()
      # a_low_bound = np.maximum(self.q_min, current_state[:7] - self.d_q_limit)
      # a_up_bound = np.minimum(self.q_max, current_state[:7] + self.d_q_limit)
      # action_cmd = a_low_bound + np.multiply(((action + np.array([1]*7))/2), (a_up_bound - a_low_bound))

      delta_q = np.multiply(action, self.d_q_limit)
      action_cmd_unlimit = current_state[:7] + delta_q
      # print("cmd_unlimit = " + str(action_cmd_unlimit))
      action_cmd_1 = np.maximum(action_cmd_unlimit, self.q_min)
      # print("cmd_1 = " + str(action_cmd_1))
      action_cmd_2 = np.minimum(action_cmd_1, self.q_max)
      # print("cmd_2 = " + str(action_cmd_2))
      action_cmd = action_cmd_2 # action_cmd_unlimit


      # action_cmd = np.array(current_state[:7]) + action #np.array([0, 0, 0, 0, 0, 0, 36])

      print("action_cmd = " + str(action_cmd))
      if self.dynamic_world == True:
        self.scene_handle.update()

      # Collision checking
      #is_valid = self.collision_checking(action_cmd).valid
      #print(action_cmd)
      #print(is_valid)
      
      # Send the command
      collision_reward = 0.0
      if self.safety_layer == True:
        cmd_is_valid = self.collision_handle.cmd_checking(action_cmd)
        if cmd_is_valid == True:
          success = self.panda_cmd(action_cmd)
        else:
          success = False
      else:
        success = self.panda_cmd(action_cmd)
      
      # Count collision
      # With safety layer
      state_is_valid = True
      if self.safety_layer == True:
        if success == True:
          state_is_valid = self.collision_handle.cmd_checking(action_cmd)
          if state_is_valid == False:
            self.collision_times += 1
        else: # Cmd has already executed
          collision_reward = self.collision_punishment
          
      # Without safety layer
      else:
        state_is_valid = self.collision_handle.cmd_checking(action_cmd)
        if state_is_valid == False:
          print("Collide!")
          collision_reward = self.collision_punishment
          self.collision_times += 1

      # if state_is_valid == False:
      #   self.collision_times += 1

      print("Here take another observation...")
      # State
      state = self.take_observation()
      print("state = " + str(state))
      
      # Reward
      print("Calculate reward...")
      reward, achieve = self.get_reward(state)
      reward = reward + collision_reward

      print("Final reward for this step is " + str(reward))
      # Done
      done = False
      self.episode_length += 1
      if achieve or self.episode_length > 100:
        done = True
      self.episode_return += reward 

      return state, reward, done, {}



    ###########################
    #    General Functions    #
    ###########################

    def take_observation(self):
      observed_data = None
      attempt = 0
      attempt_ob = 0
      data_obs = []
      while observed_data is None:
        try:
          
          data_js_local = self.data_js
          data_ees_local = self.data_ees
          data_ees_rpy_local = self.move_group.get_current_rpy()
          #print("data_ees_rpy_local = " + str(data_ees_rpy_local))
          data_obs = self.scene_handle.observe_obstacles()
          print("data_obs = " + str(data_obs))
          #print(data_obs)
          # 7 (current joint angles) + 6 (current ee position) + 7 (goal ee position) + 7xn (obstacle pose) = 35
          observed_data = np.array(list(data_js_local.position[2:]) + 
                              [data_ees_local.pose.position.x, data_ees_local.pose.position.y, data_ees_local.pose.position.z] +  # data_ees_local.pose.orientation.x, data_ees_local.pose.orientation.y, data_ees_local.pose.orientation.z, data_ees_local.pose.orientation.w] + 
                              data_ees_rpy_local + 
                              list(self.goal) + [3.14, 0.0, 0.0] +
                              list(data_obs)
                              )

        except:
          rospy.loginfo("Current robot pose not ready yet, retrying for getting robot pose...")
          attempt += 1
          if attempt >= 10:
            exit()

      return observed_data


    def distance(self, point_1, point_2): 
      err = np.subtract(point_1, point_2)
      dist = np.linalg.norm(err)
      return dist

    def collision_checking(self, cmd):
      self.gsvr.robot_state.joint_state.position[2:] = cmd
      self.panda_checker.wait_for_service()
      result = self.panda_checker.call(self.gsvr)
      return result

    def panda_cmd(self, cmd):
      if self.safety_layer == False:
        success = self.cmd_handle.direct_panda_cmd(cmd)
      else:
        success = self.cmd_handle.moveit_panda_cmd(cmd)
      return success


    
    ###########################
    #     Reset Functions     #
    ###########################

    def init_pose(self):
      self.scene_handle.update()
      success = self.panda_cmd(self.init_state)
      while success == False:
        self.scene_handle.update()
        success = self.panda_cmd(self.init_state)
        time.sleep(0.5)

    ###########################
    #     Reward Functions    #
    ###########################

    def get_reward(self, observed_data):
      reward = 0
      achieve = False
      ee_point = observed_data[7:10]
      ee_rpy = observed_data[10:13]
      
      o_dis = self.distance(abs(ee_rpy[0]), 3.14)

      if o_dis <= 0.1:
        print("Orientation is right!")
        reward += 0

      dis = self.distance(ee_point, self.goal[:3])

      
      print("the distance = " + str(dis))
      if self.last_dis > dis:
        reward += (self.last_dis - dis) * self.distance_rew_factor
        print("Reward for getting nearer is " + str(reward))
      else:
        reward -= (dis - self.last_dis) * self.distance_rew_factor
        print("Reward for getting further is " + str(reward))
      self.last_dis = dis
      if dis < 0.1:
        achieve = True
        reward += self.achieve_reward
        print("Goal achieved!")
        # if o_dis <= 0.1:
        #   reward += self.achieve_reward
      else:
        reward -= 0.2

      return reward, achieve
