import pandas as pd
import os
import matplotlib.pyplot as plt

# Locate local working directory on where this file is
outdir = os.path.dirname(os.path.abspath(__file__))
os.chdir(outdir)

# Import data
run_safe = pd.read_csv('s_plot_data.csv')
run_unsafe = pd.read_csv('n_plot_data.csv')
min_len = min([len(run_safe), len(run_unsafe)])
run_safe = run_safe.iloc[1: min_len, :].reset_index()
run_unsafe = run_unsafe.iloc[1: min_len, : ].reset_index()

# Define colors
RebeccaPurple = (102/255, 51/255, 153/255)
OrangeRed = (255/255, 69/255, 0)
YellowGreen = (154/255, 205/255, 50/255)


fig, (ax1, ax2, ax3) = plt.subplots(3)
fig.set_size_inches(6, 15)
fig.subplots_adjust(hspace = 0.5) 
# Collision times
ax = run_unsafe.reset_index().plot(x='index', y='ct', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color=OrangeRed, alpha=0.9,
                        ax = ax1)

run_safe.reset_index().plot(x='index', y='ct', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color=YellowGreen, alpha=0.9,
                        ax=ax)

ax1.set_xlabel('episode', fontsize=12)
ax1.set_ylabel('Collision Times', fontsize=12)
ax1.get_legend().remove()
# ax1.legend(['Without safety layer', 'With safety layer'], fontsize=12)
# plt.show()


#####################################

# Episode Length
el_average_unsafe = pd.DataFrame({'el_ave':[]})
el_average_safe = pd.DataFrame({'el_ave':[]})

window = 50

for i in range(len(run_unsafe['el'])):
    if i == 0:
        df = pd.DataFrame({'el_ave':[run_unsafe['el'][i]]})
        el_average_unsafe = el_average_unsafe.append(df, ignore_index=True)
    else:
        windowsum = 0
        windowlist = []
        for j in range(window):
            index = i - (window%2) + j
            if index >= 0 and index < len(run_unsafe['el']):
                windowlist.append(run_unsafe['el'][index])
        if len(windowlist) == window:
            windowsum = sum(windowlist)
            ave = windowsum / len(windowlist)
            df = pd.DataFrame({'el_ave':[ave]})
            el_average_unsafe = el_average_unsafe.append(df, ignore_index=True)

for i in range(len(run_safe['el'])):
    if i == 0:
        df = pd.DataFrame({'el_ave':[run_safe['el'][i]]})
        el_average_safe = el_average_safe.append(df, ignore_index=True)
    else:
        windowsum = 0
        windowlist = []
        for j in range(window):
            index = i - (window%2) + j
            if index >= 0 and index < len(run_safe['el']):
                windowlist.append(run_safe['el'][index])
        if len(windowlist) == window:
            windowsum = sum(windowlist)
            ave = windowsum / len(windowlist)
            df = pd.DataFrame({'el_ave':[ave]})
            el_average_safe = el_average_safe.append(df, ignore_index=True)

ax = el_average_unsafe.reset_index().plot(x='index', y='el_ave', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color=OrangeRed,
                        ax = ax2)
el_average_safe.reset_index().plot(x='index', y='el_ave', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color=YellowGreen,
                        ax = ax)
ax2.set_xlabel('episode', fontsize=12)
ax2.set_ylabel('Average Episode Length', fontsize=12)
ax2.get_legend().remove()
# ax2.legend(['Without safety layer', 'With safety layer'], fontsize=12)

# plt.xlabel('episode', fontsize=12)
# plt.ylabel('Average Episode Length', fontsize=12)
# plt.legend(['Without safety layer', 'With safety layer'], fontsize=12)
# plt.show()

# Episode Reward
er_average_unsafe = pd.DataFrame({'er_ave':[]})
er_average_safe = pd.DataFrame({'er_ave':[]})

for i in range(len(run_unsafe['er'])):
    if i == 0:
        df = pd.DataFrame({'er_ave':[run_unsafe['er'][i]]})
        er_average_unsafe = er_average_unsafe.append(df, ignore_index=True)
    else:
        windowsum = 0
        windowlist = []
        for j in range(window):
            index = i - (window%2) + j
            if index >= 0 and index < len(run_unsafe['er']):
                windowlist.append(run_unsafe['er'][index])
        if len(windowlist) == window:
            windowsum = sum(windowlist)
            ave = windowsum / len(windowlist)
            df = pd.DataFrame({'er_ave':[ave]})
            er_average_unsafe = er_average_unsafe.append(df, ignore_index=True)

for i in range(len(run_safe['er'])):
    if i == 0:
        df = pd.DataFrame({'er_ave':[run_safe['er'][i]]})
        er_average_safe = er_average_safe.append(df, ignore_index=True)
    else:
        windowsum = 0
        windowlist = []
        for j in range(window):
            index = i - (window%2) + j
            if index >= 0 and index < len(run_safe['er']):
                windowlist.append(run_safe['er'][index])
        if len(windowlist) == window:
            windowsum = sum(windowlist)
            ave = windowsum / len(windowlist)
            df = pd.DataFrame({'er_ave':[ave]})
            er_average_safe = er_average_safe.append(df, ignore_index=True)

ax = er_average_unsafe.reset_index().plot(x='index', y='er_ave', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color=OrangeRed,
                        ax = ax3)
er_average_safe.reset_index().plot(x='index', y='er_ave', kind='line',
                        linewidth=2,
                        fontsize=12,
                        color=YellowGreen,
                        ax=ax)

ax3.set_xlabel('episode', fontsize=12)
ax3.set_ylabel('Average Episode Reward', fontsize=12)
plt.legend(['Without safety layer', 'With safety layer'], fontsize=12)
plt.show()