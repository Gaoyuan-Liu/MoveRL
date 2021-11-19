#!/usr/bin/env python

from __future__ import print_function

from rl_interface.srv import PandaCmd, PandaCmdResponse
from std_msgs.msg import Float64, Float64MultiArray
import rospy
import sys
import numpy as np

def main(args):
    rospy.init_node('panda_cmd_client')
    print("get here1")
    rospy.wait_for_service('panda_cmd')

    try:
        panda_cmd = rospy.ServiceProxy('panda_cmd', PandaCmd)
        print("get here")
        cmd_data = Float64MultiArray()
        cmd_data.data = np.array([1.00, 1.00, 1.00, -0.50, 0.00, 0.50, 0.00])
        resp1 = panda_cmd(cmd_data)
        print(resp1.success)
        return resp1.success
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)

if __name__ == "__main__":
    main(sys.argv)