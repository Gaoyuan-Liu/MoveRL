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
import pandas as pd
import time



# df = pd.DataFrame({'$a':[1,2], '$b': [10,20]})
# df_1 = pd.DataFrame({'$a': [3], '$b': [30]})
# df = df.append(df_1, ignore_index=True)
# print(df)
# # print(df_2)

# plot_data = pd.DataFrame({'ct':[], 'el':[], 'er':[]})
# print(plot_data)

# start = time.time()
# print("hello")
# end = time.time()
# hours, rem = divmod(end-start, 3600)
# minutes, seconds = divmod(rem, 60)

# print(hours)
# print(minutes)
# print(seconds)
# print(end-start)

a = np.array([1,2,3])
b = np.array([1,1,1])
print(a-b)




 