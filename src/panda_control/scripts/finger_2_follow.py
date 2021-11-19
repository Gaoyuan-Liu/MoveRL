#!/usr/bin/env python

from std_msgs.msg import Float64, Float64MultiArray, Bool
from sensor_msgs.msg import JointState
import rospy
import sys

class subscriber_class:
    def __init__(self):
        self.data = JointState()
        self.s = rospy.Subscriber('/panda/joint_states', JointState, self.cb)

    def cb(self, data):
        self.data = data

def main(args):
    rospy.init_node('finger_2_follow')


    publisher = rospy.Publisher('/panda/joint_rightfinger_position_controller/command', Float64, queue_size=10)
    
    subscriber = subscriber_class()


    rate = rospy.Rate(1000) # 1000Hz
    while not rospy.is_shutdown():
        try:
            fingure_1_position = subscriber.data.position[0]

        except:
            fingure_1_position = 0.0
        

        cmd = Float64()
        cmd.data = fingure_1_position

        publisher.publish(cmd)
        rate.sleep()


if __name__ == "__main__":
    main(sys.argv)