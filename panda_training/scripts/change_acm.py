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
import tf
import os
from moveit_msgs.msg import PlanningScene, PlanningSceneComponents
from moveit_msgs.srv import GetPlanningScene
    


if __name__ == "__main__":
    rospy.init_node("text")
    _pubPlanningScene = rospy.Publisher('/planning_scene', PlanningScene, queue_size=10)
    rospy.wait_for_service('/get_planning_scene', 10.0)
    get_planning_scene = rospy.ServiceProxy('/get_planning_scene', GetPlanningScene)
    request = PlanningSceneComponents(components=PlanningSceneComponents.ALLOWED_COLLISION_MATRIX)
    response = get_planning_scene(request)

    rospy.sleep(5.0)
    acm = response.scene.allowed_collision_matrix
    # if not 'table' in acm.default_entry_names:
        # add button to allowed collision matrix
    acm.default_entry_names += ['table']
    acm.default_entry_values += [True]

    planning_scene_diff = PlanningScene(
            is_diff=True,
            allowed_collision_matrix=acm)

    r = rospy.Rate(1000)
    while rospy.is_shutdown() == False:
        _pubPlanningScene.publish(planning_scene_diff)

        response = get_planning_scene(request)
        print(response.scene.allowed_collision_matrix.default_entry_names)
        r.sleep()
