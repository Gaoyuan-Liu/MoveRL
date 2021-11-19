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


class Collision_Handle:
    
    def __init__(self):
        self.move_group = moveit_commander.MoveGroupCommander("panda_arm")
        self.scene = moveit_commander.PlanningSceneInterface()
        rospy.sleep(1.0)
        self.panda_checker = rospy.ServiceProxy('/check_state_validity', GetStateValidity)
        self.rs = RobotState()
        self.rs.joint_state.name = ['panda_finger_joint1', 'panda_finger_joint2', 'panda_joint1', 'panda_joint2', 'panda_joint3', 'panda_joint4', 'panda_joint5', 'panda_joint6', 'panda_joint7']
        self.rs.joint_state.position = [0.02, 0.0, 0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0]
        self.gsvr = GetStateValidityRequest()
        self.gsvr.robot_state = self.rs
        self.gsvr.group_name = "panda_arm"

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







    




        
        
    