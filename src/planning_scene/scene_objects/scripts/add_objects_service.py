#!/usr/bin/env python

from __future__ import print_function

from std_msgs.msg import Float64, Bool, Float64MultiArray
from scene_objects.srv import AddObjects, AddObjectsResponse
import rospy
import sys
import numpy as np
import moveit_commander

class service_class:
    def __init__(self):
        self.s = rospy.Service('add_objects', AddObjects, self.servicecb)
        self.scene = moveit_commander.PlanningSceneInterface()

    def servicecb(self, req):
        if req.shape.data == 'cylinder':
            self.scene.add_cylinder(req.name.data, req.pose, req.size.data[0], req.size.data[1])

            success = req.name.data in self.scene.get_known_object_names()
            
            res = Bool()
            res.data = success
            return AddObjectsResponse(res)

def main(args):
    rospy.init_node('add_objects_service')
    service = service_class()

    rospy.spin()
    
    
if __name__ == "__main__":
    main(sys.argv)