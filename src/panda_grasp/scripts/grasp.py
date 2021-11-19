#!/usr/bin/env python

# Panda 1 do its own thing and doesn't give a fuck on what Panda 2 is doing 

from os import wait
from std_msgs.msg import Float64, Float64MultiArray, Bool
import rospy
import sys
import moveit_commander
from geometry_msgs.msg import PoseStamped
from gazebo_msgs.srv import GetModelState
import tf
# Deal to using the customized, the scripts need to run after source:
# cd panda_rl_2; source devel/setup.bash 
from gazebo_grasp_plugin.msg import GazeboGraspEvent



class subscriber_class:
    def __init__(self):
        self.data = GazeboGraspEvent()
        self.s = rospy.Subscriber('/gazebo/grasp_events', GazeboGraspEvent, self.cb)

    def cb(self, data):
        self.data = data

def object_location(obj_name):
  where_is = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
  obj_pose = where_is(obj_name, 'world').pose 
  return obj_pose

def grasp_configs(obj_name):
  obj_pose = object_location(obj_name)
  obj_xyz = [obj_pose.position.x, obj_pose.position.y, obj_pose.position.z]

  quaternion = [obj_pose.orientation.x,
                obj_pose.orientation.y,
                obj_pose.orientation.z,
                obj_pose.orientation.w]
  obj_rpy = list(tf.transformations.euler_from_quaternion(quaternion))

  obj_size = [0.1, 0.05, 0.8]

  # pose_config_1 = [obj_xyz[0], obj_xyz[1], obj_xyz[2]-1 + obj_size[2]/2 ] + [3.14, 0.0, obj_rpy[-1]-0.785]
  # pose_config_2 = [obj_xyz[0], obj_xyz[1], obj_xyz[2]-1 + obj_size[2]/2 ] + [3.14, 0.0, obj_rpy[-1]-0.785]

  # [1.5737947155389747, 0.7791102410712518, 1.5727253705462694]
  pose_config_1 = [obj_xyz[0] - 0.2, obj_xyz[1], obj_xyz[2]-1+0.3  ] + [1.57, 0.785, 1.57]
  pose_config_2 = [obj_xyz[0] - 0.1, obj_xyz[1], obj_xyz[2]-1+0.3  ] + [1.57, 0.785, 1.57]
  return pose_config_1, pose_config_2




if __name__ == "__main__":
    rospy.init_node("dual_panda")

    move_group_1 = moveit_commander.MoveGroupCommander("panda_arm")
    move_group_1.set_max_velocity_scaling_factor(0.5)
    move_group_1.set_max_acceleration_scaling_factor(0.5)

    move_group_2 = moveit_commander.MoveGroupCommander("hand")

    # Planning scene
    scene = moveit_commander.PlanningSceneInterface()
    name = 'table'
    success = name in scene.get_known_object_names()
    obs_pose = PoseStamped()
    obs_pose.header.frame_id = 'world'
    obs_pose.pose.position.x = 0
    obs_pose.pose.position.y = 0
    obs_pose.pose.position.z = -0.015
    while success == False:
      scene.add_box(name=name, pose=obs_pose, size=(2,2,0.03))
      success = name in scene.get_known_object_names()
    
    # Grasp success
    grasp_event = subscriber_class()

    
    pose_config_1, pose_config_2 = grasp_configs('cube')

    r = rospy.Rate(1) # 1Hz

  
    pose_config_3 = [-0.5, 0.0, 0.3, 3.14, 0.0, 0.0]

 

    print(pose_config_1)


    # while not rospy.is_shutdown():
    move_group_1.set_pose_target(pose_config_1)
    plan_tuple = move_group_1.plan()
    path_init = plan_tuple[1]
    joint_config_1 = path_init.joint_trajectory.points[-1].positions
    success = move_group_1.execute(path_init, wait=True)
    move_group_1.stop()
    
    move_group_2.set_joint_value_target([0.035, 0.035])
    move_group_2.go()

    move_group_1.set_pose_target(pose_config_2)
    plan_tuple = move_group_1.plan()
    path_init = plan_tuple[1]
    joint_config_1 = path_init.joint_trajectory.points[-1].positions
    success = move_group_1.execute(path_init, wait=True)
    move_group_1.stop()

    move_group_2.set_joint_value_target([0.0, 0.0])
    move_group_2.go()

    # Wait for object to attach
    grasp_success = grasp_event.data.attached
    while grasp_success == False:
      print("Waiting for object to attach...")
      grasp_success = grasp_event.data.attached
      rospy.sleep(0.5)


    move_group_1.set_pose_target(pose_config_3)
    plan_tuple = move_group_1.plan()
    path_init = plan_tuple[1]
    joint_config_1 = path_init.joint_trajectory.points[-1].positions
    success = move_group_1.execute(path_init, wait=True)
    move_group_1.stop()

    move_group_2.set_joint_value_target([0.035, 0.035])
    move_group_2.go()

    # move_group_1.set_pose_target(pose_config_2)
    # plan_tuple = move_group_1.plan()
    # path_1 = plan_tuple[1]
    # success = move_group_1.execute(path_1, wait=True)
    # move_group_1.stop()

    # move_group_1.set_joint_value_target(joint_config_1)
    # plan_tuple = move_group_1.plan()
    # path_2 = plan_tuple[1]
    # success = move_group_1.execute(path_2, wait=True)
    # move_group_1.stop()

    # Here the robot will be in pose 1

    # while not rospy.is_shutdown():

    #     move_group_1.execute(path_1, wait=True)
    #     move_group_1.execute(path_2, wait=True)


        # success = self.move_group.go(wait=True)
        # move_group_2.stop()
        # r.sleep()

