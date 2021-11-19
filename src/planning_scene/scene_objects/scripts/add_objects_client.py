#!/usr/bin/env python

from __future__ import print_function

from std_msgs.msg import String, Float64, Float64MultiArray
from geometry_msgs.msg import PoseStamped
from scene_objects.srv import AddObjects, AddObjectsResponse
import rospy
import sys
import numpy as np

def main(args):
    rospy.init_node('add_objects_client')
    #print("get here1")
    rospy.wait_for_service('add_objects')

    try:
        obj_cmd = rospy.ServiceProxy('add_objects', AddObjects)
        #print("get here")
        shape = String()
        shape.data = 'cylinder'

        name = String()
        name.data = 'cylinder_1'

        pose = PoseStamped()
        pose.header.frame_id = 'world'
        pose.pose.orientation.w = 1.0
        pose.pose.position.z = 1.0

        size = Float64MultiArray()
        size.data = np.array([0.4, 0.1])

        resp1 = obj_cmd(shape, name, pose, size)
        return resp1.success
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)
    



    #p.addCylinder("my_cylinder", 0.6, 0.2, 0.5, 0, 0.3) # Size first location later

    
if __name__ == "__main__":
    main(sys.argv)