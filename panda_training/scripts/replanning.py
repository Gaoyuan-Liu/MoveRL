#from stable_baselines3.common.env_checker import check_env
#from panda_env import CobotEnv
import time
import rospy
#import gym
from std_msgs.msg import Float64
import numpy as np

from gazebo_msgs.srv import SpawnModel, DeleteModel
from geometry_msgs.msg import Pose,PoseStamped
import geometry_msgs.msg
import os

from gazebo_msgs.srv import GetModelState
import moveit_commander
from sensor_msgs.msg import JointState

class scene_update():
    def __init__(self):
        self.scene = moveit_commander.PlanningSceneInterface()

        self.obj_shape= 'cylinder'
        self.obj_name= 'cylinder'
        self.obj_size = np.array([0.4, 0.1])
        self.obj_pose = PoseStamped()
        self.obj_pose.header.frame_id = 'world'
        self.data_ob_client = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
    
    def obj_cmd(self, shape, name, pose, size):
        success = False
        if shape == 'cylinder':
            self.scene.add_cylinder(name, pose, size[0], size[1])
            success = name in self.scene.get_known_object_names()
        return success

    def update(self):
        data_ob = self.data_ob_client('object', 'world').pose
        current_state = np.array([data_ob.position.x, data_ob.position.y, data_ob.position.z, 
                                data_ob.orientation.x, data_ob.orientation.y, data_ob.orientation.z, data_ob.orientation.w])
        self.obj_pose.pose.position.x = current_state[0]
        self.obj_pose.pose.position.y = current_state[1]
        self.obj_pose.pose.position.z = current_state[2] - 1.0
        self.obj_pose.pose.orientation.x = current_state[3]
        self.obj_pose.pose.orientation.y = current_state[4]
        self.obj_pose.pose.orientation.z = current_state[5]
        self.obj_pose.pose.orientation.w = current_state[6]
        
        success_1 = self.obj_cmd(self.obj_shape, self.obj_name, self.obj_pose, self.obj_size)

        data_ob_2 = self.data_ob_client('object_2', 'world').pose
        current_state = np.array([data_ob_2.position.x, data_ob_2.position.y, data_ob_2.position.z, 
                                data_ob_2.orientation.x, data_ob_2.orientation.y, data_ob_2.orientation.z, data_ob_2.orientation.w])
        self.obj_pose.pose.position.x = current_state[0]
        self.obj_pose.pose.position.y = current_state[1]
        self.obj_pose.pose.position.z = current_state[2] - 1.0
        self.obj_pose.pose.orientation.x = current_state[3]
        self.obj_pose.pose.orientation.y = current_state[4]
        self.obj_pose.pose.orientation.z = current_state[5]
        self.obj_pose.pose.orientation.w = current_state[6]
        
        success_2 = self.obj_cmd(self.obj_shape, 'cylinder_2', self.obj_pose, self.obj_size)

        success = success_1 and success_2

        return success
class test_sub():
  def __init__(self):
    JOINT_STATE_TOPIC = '/panda/joint_states'
    EE_STATE_TOPIC = '/panda/robot_states'
    self.data_js = None
    self.data_ees = None
    self._sub_joint = rospy.Subscriber(JOINT_STATE_TOPIC, JointState, self.sub_joint_cb)
    self._sub_ee = rospy.Subscriber(EE_STATE_TOPIC, PoseStamped, self.sub_ee_cb)
  
  def sub_joint_cb(self, data):
    self.data_js = data

  def sub_ee_cb(self, data):
    self.data_ees = data

  def step(self):
    a = self.data_js
    print(a)
    #rospy.spin()


if __name__ == "__main__":

  # test subscriber
  test_object = test_sub()
  #rospy.init_node('test')
  #while True:
    #test_object.step()
  #  print(test_object.data_js)
  #  rospy.sleep(1)

  scene = scene_update()

  # test moveit
  rospy.init_node('test')
  move_group = moveit_commander.MoveGroupCommander("panda_arm")

  #move_group.allow_replanning(True)

  # Reset
  joint_goal = move_group.get_current_joint_values()
  joint_goal[0] = 0.0
  joint_goal[1] = 0.0
  joint_goal[2] = 0.0
  joint_goal[3] = -0.5
  joint_goal[4] = 0.0
  joint_goal[5] = 0.0
  joint_goal[6] = -0.5
  move_group.set_joint_value_target(joint_goal)
  plan = move_group.plan()
  move_group.execute(plan[1])
  
  r = rospy.Rate(1) # 1Hz

  while not rospy.is_shutdown():
    
    scene.update()
    #scene = scene_update()
    #joint_goal = move_group.get_current_joint_values()
    #joint_goal[0] = 0.0
    #joint_goal[1] = 0.0
    #joint_goal[2] = 0.0
    #joint_goal[3] = -0.5
    #joint_goal[4] = 0.0
    #joint_goal[5] = 0.0
    #joint_goal[6] = -0.5
    #move_group.set_joint_value_target(joint_goal)
    #plan = move_group.plan()
    #print(plan)
    #move_group.execute(plan[1])
    #move_group.stop()
    #uccess = move_group.go(joint_goal, wait=True)
    #move_group.stop()

    #time.sleep(1.5)

    #joint_goal = move_group.get_current_joint_values()
    #joint_goal[0] = -1.0
    #joint_goal[1] = 0.5
    #joint_goal[2] = 0.0
    #joint_goal[3] = -0.5
    #joint_goal[4] = 0.0
    #joint_goal[5] = 1.0
    #joint_goal[6] = -0.5
    #success = move_group.go(joint_goal, wait=True)
    #move_group.set_joint_value_target(joint_goal)
    #plan = move_group.plan()
    #move_group.execute(plan[1])
    pose_goal = geometry_msgs.msg.Pose()
    pose_goal.orientation.w = 1.0
    pose_goal.position.x = 0.6
    pose_goal.position.y = 0.2
    pose_goal.position.z = 0.3
    move_group.set_joint_value_target(pose_goal)
    plan = move_group.plan()

    sucess = move_group.execute(plan[1], wait = False)
    #print(sucess)
    #time.sleep(1.0)
    #move_group.stop()
    #success = move_group.go(pose_goal, wait=True)
    #move_group.stop()
    #if sucess == True:
    #  break
    r.sleep()


  #data_ees_local = test_object.data_ees
  #point_1 = np.array([data_ees_local.pose.position.x, data_ees_local.pose.position.y, data_ees_local.pose.position.z, data_ees_local.pose.orientation.x, data_ees_local.pose.orientation.y, data_ees_local.pose.orientation.z, data_ees_local.pose.orientation.w])
  #point_2 = np.array([0.4, 0.2, 0.3, 1.0, 0.0, 0.0, 0.0])




