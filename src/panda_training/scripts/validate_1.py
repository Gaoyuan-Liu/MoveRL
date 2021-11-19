import os
import sys

from stable_baselines3.common.env_checker import check_env
from stable_baselines3 import PPO
from stable_baselines3.ppo import MlpPolicy
from stable_baselines3.common.env_util import make_vec_env

# Import panda training environment
from panda_env_v1 import CobotEnv


import rospy
import gym
from gym import wrappers
from std_msgs.msg import Float64
import numpy as np
from gazebo_msgs.srv import SpawnModel, DeleteModel
from geometry_msgs.msg import Pose

if __name__ == "__main__":
  # Set the current dir
  outdir = os.path.dirname(os.path.abspath(__file__))
  os.chdir(outdir)

  rospy.init_node('cobot_training')

  env = gym.make('PandaRlEnvironment-v1')
  
  env = wrappers.Monitor(env, outdir, force=True)

  # Parallel environment
  env = make_vec_env(lambda:env, n_envs=1)
  
  model = PPO.load("ppo_panda", env=env, tensorboard_log="./tensorboard/")
  model.set_env(env)

  obs = env.reset()
  success_times = 0
  for i in range(1000):
    action, _state = model.predict(obs, deterministic=True)
    obs, reward, dones, info = env.step(action)
    if dones == True:
      success_times += 1 
    if success_times >= 10:
      break


  del model
  