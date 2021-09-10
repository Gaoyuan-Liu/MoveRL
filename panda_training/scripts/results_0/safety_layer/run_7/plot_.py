import pandas as pd
import os
import matplotlib.pyplot as plt

# Locate local working directory on where this file is
outdir = os.path.dirname(os.path.abspath(__file__))
os.chdir(outdir)

run = pd.read_csv('plot_data.csv')
print(run.head())
run.reset_index().plot(x='index', y='ct', kind='line',
                        linewidth=2,
                        fontsize=12)

plt.xlabel('episode', fontsize=12)
plt.ylabel('Collision Times', fontsize=12)
plt.legend(['collision times'], fontsize=12)
plt.show()

# Episode Length
run.reset_index().plot(x='index', y='el', kind='line',
                        linewidth=2,
                        fontsize=12)

plt.xlabel('episode', fontsize=12)
plt.ylabel('Episode Length', fontsize=12)
plt.legend(['episode length'], fontsize=12)
plt.show()

# Episode Reward
run.reset_index().plot(x='index', y='er', kind='line',
                        linewidth=2,
                        fontsize=12)

plt.xlabel('episode', fontsize=12)
plt.ylabel('Episode Reward', fontsize=12)
plt.legend(['episode reward'], fontsize=12)
plt.show()