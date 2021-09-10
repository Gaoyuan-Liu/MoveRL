# :panda_face:
# No Safety Layer Training Results

| tun time | world        | distance reward factor   | achieve reward | collision punishment | steps | time fraction | exe_time | note |
| -------- | ------------ | ------------------------ | -------------- | -------------------- | ----- | --------------| -------- | ---- |
| run_1    | train        | 10                       | 10             | 0                    | 40000 | 0.05          | 0.5      | using, goal is 422 |
| run_5    | human        | 20                       | 100            | -1                   | 40000 | 0.1           |          |      |
| run_6    | human        | 20                       | 10             | -1                   | 30000 | 0.1           |          |      |
| run_7    | one_cylinder | 20                       | 10             | -1                   | 30000 | 0.1           |          |      |
| run_10   | train        | 10                       | 10             | 0                    | 30000 | 0.05          | 0.5      | ent_coef=0.0001 |
| run_11   | train        | 10                       | 10             | 0                    | 30000 | 0.05          | 0.5      | ent_coef=0 |
| run_13   | human        | 10                       | 10             | 0                    | 60000 | 0.05          | 0.5      | learning very slowly |
| run_14   | basket       | 10                       | 10             | 0                    | 60000 | 0.05          | 0.5      | |
| run_15   | human        | 10                       | 10             | 0                    | 40000 | 0.05          | 0.5      | |