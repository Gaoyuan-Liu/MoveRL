import pandas as pd
import os
import matplotlib.pyplot as plt

# Locate local working directory on where this file is
outdir = os.path.dirname(os.path.abspath(__file__))
os.chdir(outdir)

# Import data
N = 5
runs = []
ct = pd.DataFrame()
el = pd.DataFrame()
er = pd.DataFrame()
min_len = len(pd.read_csv('plot_data_1.csv'))
for i in range(N):
    runs.append(pd.read_csv('plot_data_'+str(i+1)+'.csv'))
    min_len = min([min_len, len(runs[i])])
    runs[i] = runs[i].iloc[1: min_len, :].reset_index()
    ct['run_' + str(i)] = runs[i]['ct'] 
    el['run_' + str(i)] = runs[i]['el'] 
    er['run_' + str(i)] = runs[i]['er']    

ct['mean'] = ct.mean(axis=1)
ct['std'] = ct.std(axis=1)
el['mean'] = el.mean(axis=1)
el['std'] = el.std(axis=1)
er['mean'] = er.mean(axis=1)
er['std'] = er.std(axis=1)

plot_data = pd.DataFrame()
plot_data['ct_mean'] = ct['mean']
plot_data['ct_std'] = ct['std']
plot_data['el_mean'] = el['mean']
plot_data['el_std'] = el['std']
plot_data['er_mean'] = er['mean']
plot_data['er_std'] = er['std']

# print(plot_data.head())
# print(runs[3].head())
plot_data.to_csv('plot_data.csv')