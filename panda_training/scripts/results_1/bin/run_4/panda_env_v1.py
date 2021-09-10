#! /venv3.8/bin/python

# This env changes the action space to the end-effctor level

# source ~/venv3.8/bin/activate
import os

import gym
from gym import utils, spaces
from gym.utils import seeding
from gym.envs.registration import register
from gym import spaces
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
from rl_interface.srv import PandaCmd
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

# Data Collection
import pandas as pd


max_episode_steps=100

reg = register(
    id='PandaRlEnvironment-v1',
    entry_point='panda_env_v1:CobotEnv',
    max_episode_steps=100,
    )

class CobotEnv(gym.Env):
    def __init__(self):
      super(CobotEnv, self).__init__()

      self.time_fraction = 0.02

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
      self.cmd_handle = Cmd_Handle(exe_time=0.5, mode='cartesian_space')
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
      # self.p_min = np.array([-0.855, -0.855, 0.0, -3.14, -3.14, -3.14])
      self.p_min = np.array([-0.855, -0.855, 0.15, -3.14, -3.14, -3.14]) 	# 140 x 207 x 63 mm
      self.p_max = np.array([0.855, 0.855, 1.19, 3.14, 3.14, 3.14])

      self.goal_min = np.array([0.1, -0.6, 0.2, -3.14, -3.14, -3.14]) # x, y, z
      self.goal_max = np.array([0.6, 0.6, 0.7, 3.14, 3.14, 3.14])

      # self.d_p_limit = self.time_fraction * np.array([1.7000, 1.7000, 1.7000, 2.5000, 2.5000, 2.5000])
      self.d_p_limit = self.time_fraction * np.array([1.7000, 1.7000, 1.7000]) # x, y, z

      # Action contains end-effector position, x, y, z, yaw
      self.action_space = spaces.Box(low=np.array([-1]*3, dtype=np.float32), high=np.array([1]*3, dtype=np.float32))

      # Observation contains 6 end-effector current position, goal position
      # 6 + 6
      self.observation_space = spaces.Box(low=np.concatenate((self.p_min, self.goal_min)), 
                                          high=np.concatenate((self.p_max, self.goal_max)), 
                                          dtype=np.float64)

      # Init pose
      self.init_state = np.array([0.1, 0.0, 0.89, 3.14, 0.0, 0.0])

      # Gazebo interface
      self.gazebo = GazeboConnection() 

      # Set goal ee position
      self.goal = np.array([0.4, 0.0, 0.2, 3.14, 0.0, 0.0]) # [0.5, 0.4, 0.3]
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
      # Countinue sim
      self.gazebo.unpauseSim()
      print("==== New episode ====")
      self.goal_delete(self.model_name)

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
      self.step_count = 0
      
      # Set goal model
      self.initial_pose.position.x = self.goal[0]
      self.initial_pose.position.y = self.goal[1]
      self.initial_pose.position.z = self.goal[2] + 1.0
      ee_point = observation[:3]
      self.last_dis = self.distance(ee_point, self.goal[:3])
      self.goal_spawn(self.model_name, self.goal_model_xml, self.robot_namespace, self.initial_pose, self.reference_frame)

      return observation

    ###########################
    #           Step          #
    ###########################

    def step(self, action):
      if rospy.is_shutdown():
        exit()
      #self.gazebo.unpauseSim()

      print("== Step " + str(self.episode_length) + " ==")
      # action = np.array([0,0,1,-1])
      # Calculate action command
      current_state = self.take_observation()
      action_cmd_short = current_state[[0, 1, 2]] + np.multiply(self.d_p_limit, action) # dx, dy, dz, dyaw 
      # print("action_cmd type is" + str(type(action_cmd_short))) # numpy.ndarray
      action_cmd_unlimit = np.concatenate((action_cmd_short[:3], np.array([3.14, 0, 0] )))
      # Constrain
      action_cmd_1 = np.maximum(action_cmd_unlimit, self.p_min)
      action_cmd = np.minimum(action_cmd_1, self.p_max)
      print("action = " + str(action))
      print("action_cmd = " + str(action_cmd))
      if self.dynamic_world == True:
        self.scene_handle.update()
      
      # Send the command
      collision_punishment = 0.0

      #if is_valid:
      print("Here exectute the cmd...")
      plan_success, path = self.cmd_handle.plan(action_cmd)

      success = False
      if plan_success == True and self.collision_handle.cmd_checking(path.joint_trajectory.points[-1].positions) == True:
        success = self.cmd_handle.execute(path)
      # success, path = self.panda_cmd(action_cmd)
      # print(success)
      #else:
      if success == False:
        collision_punishment = self.collision_punishment

      
      
      #print("Here do collision checking...")
      #is_valid = self.collision_checking(action_cmd).valid
      #if is_valid == False:
      #  collision_punishment = -1.0
      
      # Collision time count
      state_is_valid = True
      if self.safety_layer == True: 
        if success == True:
          state_is_valid = self.collision_handle.cmd_checking(path.joint_trajectory.points[-1].positions)

      else:
        cmd_q = self.cmd_handle.cmd_ik(action_cmd)
        # print("-----" + str(self.move_group.get_current_joint_values()))
        state_is_valid = self.collision_handle.cmd_checking(self.move_group.get_current_joint_values())
      if state_is_valid == False:
        self.collision_times += 1
      # print(state_is_valid)

      # State
      state = self.take_observation()
      # Reward
      reward, achieve = self.get_reward(state)
      reward = reward + collision_punishment
      print("The final reward is = " + str(reward))
      print("The state is = " + str(state))

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
      
      while observed_data is None:
        try:
          data_ees_position_local = self.move_group.get_current_pose().pose.position
          data_ees_rpy_local = self.move_group.get_current_rpy()

          # 6 (current ee position) + 6 (goal ee position) = 12
          observed_data = np.array([data_ees_position_local.x, data_ees_position_local.y, data_ees_position_local.z] + 
                                    data_ees_rpy_local +
                                    list(self.goal))


        except:
          rospy.loginfo("Current robot pose not ready yet, retrying for getting robot pose")
          attempt += 1
          if attempt >= 10:
            exit()
      return observed_data

    # def observe_obstacles(self):
    #   observed_data = None
    #   attempt = 0
    #   data_obs = []
    #   while (observed_data is None) and (len(self.obs_list) >= 1):
    #     try:
    #       for i in self.obs_list:
    #         data_obs_ = self.data_ob_client(i, 'world').pose
    #         data_obs += [data_obs_.position.x, data_obs_.position.y, data_obs_.position.z, data_obs_.orientation.x, data_obs_.orientation.y, data_obs_.orientation.z, data_obs_.orientation.w]
    #         observed_data = np.array(data_obs)

    #     except:
    #       rospy.loginfo("Current robot pose not ready yet, retrying for getting robot pose")
    #       attempt += 1
    #       if attempt >= 10:
    #         exit()
    #   return observed_data


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
        path = None
      else:
        success, path = self.cmd_handle.moveit_panda_cmd(cmd)
      return success, path


    
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
    #      Step Functions     #
    ###########################

    def get_reward(self, observed_data):
      reward = 0
      achieve = False
      ee_point = observed_data[:3]
      #print("the ee_point = " + str(ee_point))
      #print(self.data_ees)
      #print("the goal = " + str(self.goal))
      dis = self.distance(ee_point, self.goal[:3])

      #print("the distance = " + str(dis))
      if self.last_dis > dis:
        reward += (self.last_dis - dis) * self.distance_rew_factor
        print("last dis = " + str(self.last_dis))
        print("dis = " + str(dis))
        print("Reward for getting nearer is " + str(reward))
      else:
        reward -= (dis - self.last_dis) * self.distance_rew_factor 
        print("Reward for getting further is " + str(reward))
      self.last_dis = dis
      if dis < 0.10:
        achieve = True
        reward += self.achieve_reward
        print("Goal achieved!")
      else:
        reward -= 0.2

      return reward, achieve
