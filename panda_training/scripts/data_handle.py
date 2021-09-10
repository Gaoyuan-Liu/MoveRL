import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
import actionlib
import math
import time
import copy
import threading
from gazebo_msgs.srv import GetModelProperties, GetModelState, GetWorldProperties
from geometry_msgs.msg import PoseStamped, Pose
import numpy as np

from moveit_msgs.srv import GetStateValidityRequest, GetStateValidity
from moveit_msgs.msg import RobotState


class Data_Handle:
    
    def __init__(self):
        # Plot
        self.collision_times = 0
        self.episode_length = 0
        self.episode_return = 0
        self.plot_data = pd.DataFrame({'ct':[], 'el':[], 'er':[], 't':[]})
        self.t_start = time.time()
        self.t_now = time.time()

    def cmd_checking(self, cmd): # cmd should be a 7 dof np.array
        self.gsvr.robot_state.joint_state.position[2:] = list(cmd)
        self.panda_checker.wait_for_service()
        result = self.panda_checker.call(self.gsvr).valid
        return result
    
    def state_checking(self):
        self.gsvr.robot_state.joint_state.position[2:] = self.move_group.get_current_joint_values()
        self.panda_checker.wait_for_service()
        result = self.panda_checker.call(self.gsvr).valid
        return result


if __name__ == "__main__":
    rospy.init_node("text")
    collision_object = Collision_Handle()
    res = collision_object.state_checking()
    #print(res.valid)

    r = rospy.Rate(10)
    cmd = np.array([0.0, 2.0, 0.0, -0.5, 0.0, 0.5, 0.0])
    while not rospy.is_shutdown():
        res = collision_object.cmd_checking(cmd)
        print(res)
        r.sleep()







    




        
        
    