import pandas as pd
import os
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure
import matplotlib
import numpy as np

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

# Global definiation
color_1 = 'red'
color_2 = 'blue'
linewidth_1 = 1
linewidth_2 = 2
fontsize = 18
titlename = "Human scenario"
# plt.rcParams["figure.figsize"] = (20,3)
# figure(figsize=(8, 6), dpi=80)
# Collision times
# fig = plt.figure(figsize = [3.5,2]) 

ax = run_unsafe.reset_index().plot(x='index', y='ct', kind='line',
                        linewidth=linewidth_1,
                        fontsize=fontsize,
                        color=color_1, 
                        # alpha=0.9, 
                        # figsize=(8, 6)
                        xticks=np.arange(0, (len(run_unsafe)//100)*100 + 400, step=400)
                        )

run_safe.reset_index().plot(x='index', y='ct', kind='line',
                        linewidth=linewidth_2,
                        #fontsize=12,
                        color=color_2, 
                        # alpha=0.9,
                        ax=ax)
# box = ax.get_position()
# ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])

plt.xlabel('episode', fontsize=fontsize)
plt.ylabel('Collision time count', fontsize=fontsize)
# plt.legend(['Without safety layer', 'With safety layer'], bbox_to_anchor=(1.04, 1.0), fontsize=fontsize, borderaxespad=0) # loc=1,borderaxespad=0
ax.get_legend().remove()
plt.suptitle(titlename, fontsize=fontsize)
# plt.subplots_adjust(right=0.7)
# plt.tight_layout(rect=[0,0,0.75,1])
# legend(ax, y0=0.8, direction="h", borderaxespad=0.2)
plt.savefig("ct_human.pdf", bbox_inches="tight")
plt.show()

#######################
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
                        linewidth=linewidth_1,
                        fontsize=fontsize,
                        xticks=np.arange(0, (len(run_unsafe)//100)*100 + 400, step=400),
                        color=color_1)
el_average_safe.reset_index().plot(x='index', y='el_ave', kind='line',
                        linewidth=linewidth_2,
                        fontsize=fontsize,
                        color=color_2,
                        ax = ax)

plt.xlabel('episode', fontsize=fontsize)
plt.ylabel('Average episode length', fontsize=fontsize)
# plt.legend(['Without safety layer', 'With safety layer'], bbox_to_anchor=(1.04, 1.0), fontsize=fontsize, borderaxespad=0) # loc=1,borderaxespad=0
ax.get_legend().remove()
# plt.legend(['Without safety layer', 'With safety layer'], fontsize=fontsize)
# plt.suptitle(titlename, fontsize=fontsize)
plt.savefig("el_human.pdf", bbox_inches="tight")
plt.show()

#################################
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
                        linewidth=linewidth_1,
                        fontsize=fontsize,
                        xticks=np.arange(0, (len(run_unsafe)//100)*100 + 100, step=400),
                        color=color_1)
er_average_safe.reset_index().plot(x='index', y='er_ave', kind='line',
                        linewidth=linewidth_2,
                        fontsize=fontsize,
                        color=color_2,
                        ax=ax)

plt.xlabel('episode', fontsize=fontsize)
plt.ylabel('Average return', fontsize=fontsize)
# plt.legend(['Without safety layer', 'With safety layer'], fontsize=fontsize)
ax.get_legend().remove()
plt.suptitle(titlename, fontsize=fontsize)
plt.savefig("er_human.pdf", bbox_inches="tight")
plt.show()