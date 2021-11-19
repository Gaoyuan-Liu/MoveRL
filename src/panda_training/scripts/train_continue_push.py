from codecs import ignore_errors
import os
import sys
from matplotlib.pyplot import plot_date

from stable_baselines3.common.env_checker import check_env
from stable_baselines3 import PPO
from stable_baselines3.ppo import MlpPolicy
from stable_baselines3.common.env_util import make_vec_env

# Import panda training environment
from panda_env_push import CobotEnv


import rospy
import gym
from gym import wrappers
from std_msgs.msg import Float64
import numpy as np
from gazebo_msgs.srv import SpawnModel, DeleteModel
from geometry_msgs.msg import Pose
from stable_baselines3.common.monitor import Monitor
from stable_baselines3.common.callbacks import BaseCallback
import pandas as pd

class TensorboardCallback(BaseCallback):
  """
  Custom callback for plotting additional values in tensorboard.
  """

  def __init__(self, verbose=0):
    super(TensorboardCallback, self).__init__(verbose)

  def _on_step(self) -> bool:
    # Log scalar value (here a random variable)
    value = self.training_env.get_attr('collision_times')[0]
    print(value)
    self.logger.record('collision_times', value)
    return True

if __name__ == "__main__":
  # Set the current dir
  outdir = os.path.dirname(os.path.abspath(__file__))
  os.chdir(outdir)

  rospy.init_node('cobot_training')

  env = gym.make('PandaRlEnvironmentPush-v0')
  
  #env = wrappers.Monitor(env, outdir, force=True)
  env = Monitor(env, outdir)

  # Parallel environment
  #env = make_vec_env(lambda:env, n_envs=1)
  
  model = PPO.load("ppo_panda", env=env, tensorboard_log="./tensorboard/")
  model.set_env(env)
  # PPO
  #model.learn(total_timesteps=5000, tb_log_name="second_run", reset_num_timesteps=False)
  env.reset()
  model.learn(total_timesteps=20000, tb_log_name="continue_run", reset_num_timesteps=False, callback=TensorboardCallback())
  model.save("ppo_panda")

  # Save data
  plot_date_1 = pd.read_csv('plot_data.csv')
  plot_date_2 = env.plot_data
  plot_data = plot_date_1.append(plot_date_2, ignore_index=True)
  plot_data.to_csv('plot_data_extended.csv')

  del model
  