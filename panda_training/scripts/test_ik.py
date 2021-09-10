#!/usr/bin/env python

from trac_ik_python.trac_ik import IK
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
import rospy
from rospy.timer import sleep
import numpy as np
import tf


if __name__ == "__main__":

    rospy.init_node('test')
    ik_solver = IK("panda_link0",
               "panda_link7")

    seed_state = [0.0] * ik_solver.number_of_joints
    q = tf.transformations.quaternion_from_euler(0.0, 1.57, 1.57, axes='rxyz')

    solution = ik_solver.get_ik(seed_state,
                0.45, 0.1, 0.3,
                q[0], q[1], q[2], q[3],
                #0.0, 0.0, 0.0, 1.0,
                0.01, 0.01, 0.01,  # X, Y, Z bounds
                0.1, 0.1, 0.1)  # Rotation X, Y, Z bounds
    print(len(solution))

    jointTP = JointTrajectoryPoint()
    jointTP.positions = list(solution)
    jointTP.time_from_start = rospy.Duration(0.1)

    jointT = JointTrajectory()
    jointT.joint_names = ["panda_joint1", "panda_joint2", "panda_joint3", "panda_joint4", "panda_joint5", "panda_joint6", "panda_joint7"]
    jointT.points = [jointTP]

    cmdPublisher = rospy.Publisher('/panda/panda_arm_controller/command', JointTrajectory, queue_size=10)

    sleep(10) # Wait for the subscriber 

    r = rospy.Rate(10)
    cmdPublisher.publish(jointT)