#! /venv3.8/bin/python

# 2021.04.14: add the distance based reward function
# 2021.04.20: change cylinder object's position every step
# 2021.04.22: add cylinder's pose (3 position and 4 rotation) to state space and observation
# 2021.04.23: call cylinder scene object service every step


# source ~/venv3.8/bin/activate
import os

import gym
from gym import utils, spaces
from gym.utils import seeding
from gym.envs.registration import register
from gym import spaces
import rospy
import rospkg
import time
import numpy as np
import time

import sys
from gazebo_connection import GazeboConnection
from gazebo_msgs.srv import GetModelState

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

max_episode_steps=100

reg = register(
    id='PandaRlEnvironment-v0',
    entry_point='panda_env_v0:CobotEnv',
    max_episode_steps=100,
    )

class CobotEnv(gym.Env):
    def __init__(self):
      super(CobotEnv, self).__init__()

      self.time_fraction = 0.2
      
      self.q_min = np.array([-2.8973, -1.7628, -2.8973, -3.0718, -2.8973, -0.0175, -2.8973])
      self.q_max = np.array([2.8973, 1.7628, 2.8973, -0.0698, 2.8973, 3.7525, 2.8973])

      self.d_q_limit = self.time_fraction * np.array([2.1750, 2.1750, 2.1750, 2.1750, 2.6100, 2.6100, 2.6100])

      self.p_min = np.array([-0.855, -0.855, 0.0])
      self.p_max = np.array([0.855, 0.855, 1.19])

      self.goal_min = np.array([0.1, -0.6, 0.2]) # x, y, z
      self.goal_max = np.array([0.6, 0.6, 0.7])

      self.obj_pos_min = np.array([-2.0, -2.0, 0.0, -1.0, -1.0, -1.0, -1.0])
      self.obj_pos_max = np.array([2.0, 2.0, 3.0, 1.0, 1.0, 1.0, 1.0])


      # Action contains 7 joint angles
      #self.action_space = spaces.Box(low=-np.array(d_q_limit), high=np.array(d_q_limit), dtype=np.float64)
      self.action_space = spaces.Box(low=np.array([-1]*7, dtype=np.float32), high=np.array([1]*7, dtype=np.float32))

      # Observation contains 7 joint angles, end-effector current position, goal position, object position
      # 7 + 3 + 3 + 7
      self.observation_space = spaces.Box(low=np.concatenate((self.q_min, self.p_min, self.goal_min, self.obj_pos_min)), high=np.concatenate((self.q_max, self.p_max, self.goal_max, self.obj_pos_max)), dtype=np.float64)
      
      # Init pose
      self.init_state = np.array([0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0])

      # Gazebo interface
      self.gazebo = GazeboConnection() 

      # Set goal ee position
      self.goal = np.array([0.5, 0.2, 0.3]) # [0.5, 0.4, 0.3]
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
   
      # Cmd client
      self.panda_cmd = rospy.ServiceProxy('panda_cmd', PandaCmd)

      # Collision client
      self.panda_checker = rospy.ServiceProxy('/check_state_validity', GetStateValidity)
      self.checker_rs = RobotState()
      self.checker_rs.joint_state.name = ['panda_finger_joint1', 'panda_finger_joint2', 'panda_joint1', 'panda_joint2', 'panda_joint3', 'panda_joint4', 'panda_joint5', 'panda_joint6', 'panda_joint7']
      self.checker_rs.joint_state.position = [0.02, 0.0, 0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0]
      self.gsvr = GetStateValidityRequest()
      self.gsvr.robot_state = self.checker_rs
      self.gsvr.group_name = "panda_arm"

      # Scene changing
      self.obj_cmd = rospy.ServiceProxy('add_objects', AddObjects)
      self.obj_shape = String()
      self.obj_shape.data = 'cylinder'
      self.obj_name = String()
      self.obj_name.data = 'cylinder_1'
      self.obj_size = Float64MultiArray()
      self.obj_size.data = np.array([0.4, 0.1])
      self.obj_pose = PoseStamped()
      self.obj_pose.header.frame_id = 'world'
      self.data_ob_client = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)

      


    ###########################
    #           Reset         #
    ###########################

    def reset(self):
      # Countinue sim
      self.gazebo.unpauseSim()
      print("==== New episode ====")

      # Go initial pose
      self.init_pose()
      #time.sleep(self.time_fraction + 1)

      # Get observation
      observation = self.take_observation()
      #self.gazebo.pauseSim()
      self.step_count = 0
      
      # Set goal model
      #self.goal = np.random.uniform(low=self.goal_min, high=self.goal_max)
      self.goal_delete(self.model_name)

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
      self.gazebo.unpauseSim()
      
      print("== Step " + str(self.step_count) + " ==")
      print(action)
      # Calculate action command
      current_state = self.take_observation()
      a_low_bound = np.maximum(self.q_min, current_state[:7] - self.d_q_limit)
      a_up_bound = np.minimum(self.q_max, current_state[:7] + self.d_q_limit)
      action_cmd = a_low_bound + np.multiply(((action + np.array([1]*7))/2), (a_up_bound - a_low_bound))

      # Change the cylinder position in the moveit scene
      self.obj_pose.pose.position.x = current_state[13]
      self.obj_pose.pose.position.y = current_state[14]
      self.obj_pose.pose.position.z = current_state[15] - 1.0
      self.obj_pose.pose.orientation.x = current_state[16]
      self.obj_pose.pose.orientation.y = current_state[17]
      self.obj_pose.pose.orientation.z = current_state[18]
      self.obj_pose.pose.orientation.w = current_state[19]
      resp1 = self.obj_cmd(self.obj_shape, self.obj_name, self.obj_pose, self.obj_size)


      # Collision checking
      is_valid = self.collision_checking(action_cmd).valid
      #print(action_cmd)
      print(is_valid)
      
      # Send the command
      collision_punishment = 0.0
      if is_valid:
        cmd_req = Float64MultiArray()
        cmd_req.data = action_cmd
        self.panda_cmd(cmd_req)
        #time.sleep(self.time_fraction + 0.1)
      else:
        collision_punishment = -0.5

      # State
      state = self.take_observation()

      # Reward
      reward, achieve = self.get_reward(state)
      reward = reward + collision_punishment

      print(reward)

      # Done
      done = False
      self.step_count += 1
      if achieve or self.step_count > 100:
        done = True
        
      return state, reward, done, {}



    ###########################
    #    General Functions    #
    ###########################

    def take_observation(self):
      obs_data = None
      attempt = 0
      attempt_ob = 0
      while obs_data is None:
        try:
          data_js = rospy.wait_for_message('/panda/joint_states', JointState, timeout=2)
          data_rs = rospy.wait_for_message('/panda/robot_states', PoseStamped, timeout=2)

          #data_ob_client = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
          #data_ob = self.data_ob_client('object', 'world').pose
          
          # 7 + 3 + 3 + 7
          #obs_data = np.array(list(data_js.position[2:]) + [data_rs.pose.position.x, data_rs.pose.position.y, data_rs.pose.position.z] + list(self.goal) + 
          #                      [data_ob.position.x, data_ob.position.y, data_ob.position.z, data_ob.orientation.x, data_ob.orientation.y, data_ob.orientation.z, data_ob.orientation.w])
        except:
          rospy.loginfo("Current robot pose not ready yet, retrying for getting robot pose, hhhhhh")
          attempt += 1
          if attempt >= 10:
            #time.sleep(1)
            exit()

        try:
          data_ob = self.data_ob_client('object', 'world').pose
        except:
          rospy.loginfo("Current obstacle pose not ready yet, retrying for getting obstacle pose")
          attempt_ob += 1
          if attempt_ob >= 10:
            #time.sleep(1)
            exit()

        obs_data = np.array(list(data_js.position[2:]) + [data_rs.pose.position.x, data_rs.pose.position.y, data_rs.pose.position.z] + list(self.goal) + 
                                [data_ob.position.x, data_ob.position.y, data_ob.position.z, data_ob.orientation.x, data_ob.orientation.y, data_ob.orientation.z, data_ob.orientation.w])
      return obs_data


    def distance(self, point_1, point_2): 
      err = np.subtract(point_1, point_2)
      dist = np.linalg.norm(err)
      return dist

    def collision_checking(self, cmd):
      self.gsvr.robot_state.joint_state.position[2:] = cmd
      self.panda_checker.wait_for_service()
      result = self.panda_checker.call(self.gsvr)

      return result


    
    ###########################
    #     Reset Functions     #
    ###########################

    def init_pose(self):
      cmd_req = Float64MultiArray()
      cmd_req.data = self.init_state
      self.panda_cmd(cmd_req)

    ###########################
    #      Step Functions     #
    ###########################

    def get_reward(self, obs_data):
      reward = 0
      achieve = False
      ee_point = obs_data[7:10]
      dis = self.distance(ee_point, self.goal)
      if self.last_dis > dis:
        reward += 1
      else:
        reward -= 1
      self.last_dis = dis
      #print(dis)
      if dis < 0.2:
        achieve = True
        reward += 10
        print("Goal achieved!")
      else:
        reward -= 1

      return reward, achieve
