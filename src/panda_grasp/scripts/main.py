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

if __name__=='__main__':
    
    rospy.init_node('grasp_node')

    move_group_1 = moveit_commander.MoveGroupCommander("panda_arm")
    a = move_group_1.get_current_rpy()
    print(a)


    # r = rospy.Rate(10)

    # while not rospy.is_shutdown():



    #     r.sleep()