import pandas as pd
import os
import matplotlib.pyplot as plt

# Locate local working directory on where this file is
outdir = os.path.dirname(os.path.abspath(__file__))
os.chdir(outdir)

# Import data
run = pd.read_csv('plot_data_extended.csv')
run = run.iloc[1: , :].reset_index()

# Collision times
print(run.head())
run.reset_index().plot(x='index', y='ct', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color='black')

plt.xlabel('episode', fontsize=12)
plt.ylabel('Collision Times', fontsize=12)
plt.legend(['collision times'], fontsize=12)
plt.show()

# Episode Length
el_average = pd.DataFrame({'el_ave':[]})
window = 30
for i in range(len(run['el'])):
    
    if i == 0:
        df = pd.DataFrame({'el_ave':[run['el'][i]]})
        el_average = el_average.append(df, ignore_index=True)
    else:
        windowsum = 0
        windowlist = []
        for j in range(window):
            index = i - (window%2) + j
            if index >= 0 and index < len(run['el']):
                windowlist.append(run['el'][index])
        if len(windowlist) == window:
            windowsum = sum(windowlist)
            ave = windowsum / len(windowlist)
            df = pd.DataFrame({'el_ave':[ave]})
            el_average = el_average.append(df, ignore_index=True)

el_average.reset_index().plot(x='index', y='el_ave', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color='black')

plt.xlabel('episode', fontsize=12)
plt.ylabel('Episode Length', fontsize=12)
plt.legend(['episode length'], fontsize=12)
plt.show()

# Episode Reward
er_average = pd.DataFrame({'er_ave':[]})
window = 30
for i in range(len(run['er'])):
    if i == 0:
        df = pd.DataFrame({'er_ave':[run['er'][i]]})
        er_average = er_average.append(df, ignore_index=True)
    else:
        windowsum = 0
        windowlist = []
        for j in range(window):
            index = i - (window%2) + j
            if index >= 0 and index < len(run['er']):
                windowlist.append(run['er'][index])
        if len(windowlist) == window:
            windowsum = sum(windowlist)
            ave = windowsum / len(windowlist)
            df = pd.DataFrame({'er_ave':[ave]})
            er_average = er_average.append(df, ignore_index=True)
        # sum += run['er'][i]
        # ave = sum / i
        # df = pd.DataFrame({'er_ave':[ave]})
        # er_average = er_average.append(df, ignore_index=True)

er_average.reset_index().plot(x='index', y='er_ave', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color='black')

plt.xlabel('episode', fontsize=12)
plt.ylabel('Episode Reward', fontsize=12)
plt.legend(['episode reward'], fontsize=12)
plt.show()