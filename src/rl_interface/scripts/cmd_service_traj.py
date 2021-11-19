#!/usr/bin/env python

from __future__ import print_function

from rl_interface.srv import PandaCmd, PandaCmdResponse
from std_msgs.msg import Float64, Float64MultiArray, Bool
import rospy
import sys
import moveit_commander
import numpy as np

class service_class:
    def __init__(self):
        self.cmd = Float64MultiArray()
        self.s = rospy.Service('panda_cmd', PandaCmd, self.servicecb)
        self.move_group = moveit_commander.MoveGroupCommander("panda_arm")

    def servicecb(self, req):
        self.cmd = req.cmd
        #self.get_new = True

        joint_goal = self.move_group.get_current_joint_values()
        joint_goal[0] = self.cmd.data[0]
        joint_goal[1] = self.cmd.data[1]
        joint_goal[2] = self.cmd.data[2]
        joint_goal[3] = self.cmd.data[3]
        joint_goal[4] = self.cmd.data[4]
        joint_goal[5] = self.cmd.data[5]
        joint_goal[6] = self.cmd.data[6]

        success = self.move_group.go(joint_goal, wait=True)
        self.move_group.stop()
        #print("++++++++++ res = " + str(res1) + " ++++++++++++++")

        res = Bool()
        res.data = success

        return PandaCmdResponse(res)
        #return res

def main(args):
    rospy.init_node('panda_cmd_server')

    service = service_class()
    
    #service.cmd.data = [0.00, 0.00, 0.00, -0.50, 0.00, 0.50, 0.00]
    # Set initial pose
    cmd_data = Float64MultiArray()
    cmd_data.data = np.array([0.00, 0.00, 0.00, -0.50, 0.00, 0.50, 0.00])
    panda_cmd_client = rospy.ServiceProxy('panda_cmd', PandaCmd)
    panda_cmd_client(cmd_data)

    
    rospy.spin()


if __name__ == "__main__":
    main(sys.argv)