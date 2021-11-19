#!/usr/bin/env python

from __future__ import print_function

from rl_interface.srv import PandaCmd, PandaCmdResponse
from std_msgs.msg import Float64, Float64MultiArray, Bool
import rospy
import sys

class service_class:
    def __init__(self):
        self.cmd = Float64MultiArray()
        self.s = rospy.Service('panda_cmd', PandaCmd, self.servicecb)

    def servicecb(self, req):
        self.cmd = req.cmd
        res = Bool()
        res.data = True
        return PandaCmdResponse(res)

def main(args):
    rospy.init_node('panda_cmd_server')
    service = service_class()
    
    # Set the initial command
    service.cmd.data = [0.00, 0.00, 0.00, -0.50, 0.00, 0.50, 0.00]

    pub_1 = rospy.Publisher('/panda/joint1_position_controller/command', Float64, queue_size=10)
    pub_2 = rospy.Publisher('/panda/joint2_position_controller/command', Float64, queue_size=10)
    pub_3 = rospy.Publisher('/panda/joint3_position_controller/command', Float64, queue_size=10)
    pub_4 = rospy.Publisher('/panda/joint4_position_controller/command', Float64, queue_size=10)
    pub_5 = rospy.Publisher('/panda/joint5_position_controller/command', Float64, queue_size=10)
    pub_6 = rospy.Publisher('/panda/joint6_position_controller/command', Float64, queue_size=10)
    pub_7 = rospy.Publisher('/panda/joint7_position_controller/command', Float64, queue_size=10)

    rate = rospy.Rate(1000) # 1000Hz
    while not rospy.is_shutdown():
        pub_1.publish(service.cmd.data[0])
        pub_2.publish(service.cmd.data[1])
        pub_3.publish(service.cmd.data[2])
        pub_4.publish(service.cmd.data[3])
        pub_5.publish(service.cmd.data[4])
        pub_6.publish(service.cmd.data[5])
        pub_7.publish(service.cmd.data[6])

        rate.sleep()


if __name__ == "__main__":
    main(sys.argv)