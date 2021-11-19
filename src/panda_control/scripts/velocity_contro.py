#!/usr/bin/env python

from std_msgs.msg import Float64, Float64MultiArray, Bool
from sensor_msgs.msg import JointState
import rospy
import sys
import time

class subscriber_class:
    def __init__(self):
        self.data = JointState()
        self.s = rospy.Subscriber('/panda/joint_states', JointState, self.cb)

    def cb(self, data):
        self.data = data

def main(args):
    rospy.init_node('finger_2_follow')


    publisher = rospy.Publisher('/panda/joint1_position_controller/command', Float64, queue_size=10)
    
    subscriber = subscriber_class()

    cmd = Float64()
    rate = rospy.Rate(1000) # 1000Hz

    start = time.time()
    while not rospy.is_shutdown():

        now = time.time()

        wait = now - start
        if wait < 0.5:
            joint_v = -2.0
        else:
            joint_v = 2.0

        cmd.data = joint_v
        publisher.publish(cmd)

        rate.sleep()


if __name__ == "__main__":
    main(sys.argv)