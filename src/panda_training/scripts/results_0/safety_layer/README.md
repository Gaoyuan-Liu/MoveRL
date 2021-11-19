# :panda_face:
# Safety Layer Training Results

| tun time | world        | distance reward factor   | achieve reward | collision punishment | steps | time fraction | exe_time | note |
| -------- | ------------ | ------------------------ | -------------- | -------------------- | ----- | ------------- | -------- | ---- |
| run_1    | train        | 10                       | 10             | -1                   | 40000 | 0.05          |          | using, goal is 422 |
| run_2    | human        | 20                       | 100            | -1                   | 40000 | 0.1           |          |      |
| run_3    | human        | 20                       | 10             | -1                   | 30000 | 0.1           |          |      |
| run_4    | one_cylinder | 20                       | 10             | -1                   | 50000 | 0.1           |          |      |
| run_5    | one_cylinder | 10                       | 10             | -1                   | 50000 | 0.05          |          |      |
| run_6    | train        | 10                       | 10             | -1                   | 20000 | 0.05          |          | ent_coef=0.0 |
| run_7    | train        | 10                       | 10             | -1                   | 20000 | 0.05          |          | ent_coef=0.0, solved the collision problem|
| run_8    | human        | 10                       | 10             | -1                   | 20000 | 0.05          |          | ent_coef=0.0, solved the collision problem better|
| run_9    | basket       | 10                       | 10             | -1                   | 20000 | 0.05          |          | ent_coef=0.0, solved the collision problem better|
| run_10   | human       | 10                       | 10             | -1                   | 40000 | 0.05          |          | ent_coef=0.0, goal is 422|
| run_11   | human       | 10                       | 10             | -1                   | 40000 | 0.05          |          | ent_coef=0.0, goal is 422, using as result|
| run_12   | basket      | 10                       | 10             | -1                   | 40000 | 0.05          |          | ent_coef=0.0, goal is 422, using as result|