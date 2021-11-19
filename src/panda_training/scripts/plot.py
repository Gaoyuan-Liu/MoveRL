#from stable_baselines3.common.env_checker import check_env
#from panda_env import CobotEnv
from numpy.core.fromnumeric import size
import rospy
#import gym
from std_msgs.msg import Float64
import numpy as np
import tf
import matplotlib
import matplotlib.pyplot as plt
from csv import writer
import csv
import os
import pandas as pd
  

FIG_NAME = 'collision_times'

outdir = os.path.dirname(os.path.abspath(__file__))
os.chdir(outdir)

# ct_list = np.loadtxt('collision_counting.csv')
ct_dataframe = pd.read_csv('collision_counting.csv')
# ct_dataframe.plot()
print(ct_dataframe.head())
# fig, ax = plt.subplots()
# n_episode = np.arange(len(ct_list))


# ax.plot(n_episode, ct_list)

# ax.set(xlabel='n_epsode', ylabel='collision times',
#        title='Collision times without safety layer')
# ax.grid()

# fig.savefig(FIG_NAME + '.png')
# plt.show()

# data = pd.read_csv('continue_run_0.csv')
# value = pd.DataFrame(data, columns = ['Value'])
# list = pd.DataFrame.to_numpy(value)
# list_ = []
# for i in np.arange(len(list)):
#        list_.append(list[i][0])
# n_episode = np.arange(len(list_))

# ax.plot(n_episode, list_)

# ax.set(xlabel='n_epsode', ylabel='collision times',
#        title='Collision times without safety layer')
# ax.grid()

# fig.savefig(FIG_NAME + '.png')
# plt.show()






 