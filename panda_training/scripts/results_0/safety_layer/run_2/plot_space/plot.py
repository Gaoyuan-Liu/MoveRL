import pandas as pd
import os
import matplotlib.pyplot as plt

# Locate local working directory on where this file is
outdir = os.path.dirname(os.path.abspath(__file__))

# Collision times
os.chdir(outdir + "/ct")

run_1 = pd.read_csv("run-first_run_1-tag-collision_times.csv")
run_2 = pd.read_csv("run-continue_run_0-tag-collision_times.csv")

run = pd.concat([run_1, run_2])
run.plot(x="Step", y="Value", kind="line", title="Collision times")
plt.savefig("collision_times")
plt.show()

# Episode length
os.chdir(outdir + "/el")

run_1 = pd.read_csv("run-first_run_1-tag-rollout_ep_len_mean.csv")
run_2 = pd.read_csv("run-continue_run_0-tag-rollout_ep_len_mean.csv")

run = pd.concat([run_1, run_2])
run.plot(x="Step", y="Value", kind="line", title="Episode length")
plt.savefig("episode_length")
plt.show()

# Episode reward
os.chdir(outdir + "/er")

run_1 = pd.read_csv("run-first_run_1-tag-rollout_ep_rew_mean.csv")
run_2 = pd.read_csv("run-continue_run_0-tag-rollout_ep_rew_mean.csv")

run = pd.concat([run_1, run_2])
run.plot(x="Step", y="Value", kind="line", title="Episode reward")
plt.savefig("episode_reward")
plt.show()
