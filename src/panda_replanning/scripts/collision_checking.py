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

from moveit_msgs.srv import GetStateValidityRequest, GetStateValidity
from moveit_msgs.msg import RobotState

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
        data_ob = self.data_ob_client('obstacle_1', 'world').pose
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

        data_ob_2 = self.data_ob_client('obstacle_2', 'world').pose
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
class sub_class():
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

def distance(array_1, array_2):
  err = np.subtract(array_1, array_2)
  dist = np.linalg.norm(err)
  return dist

def reset():
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

def update_ee_goal(goal_1, goal_2, current_ee):
  dis_1 = distance(goal_1, current_ee)
  dis_2 = distance(goal_2, current_ee)
  if dis_1 > dis_2:
    ee_goal = goal_1
  else:
    ee_goal = goal_2
  return ee_goal

class execute_cmd():
  def __init__(self):
    self.joint1_pub = rospy.Publisher('/panda/joint1_position_controller/command', Float64, queue_size=10)
    self.joint2_pub = rospy.Publisher('/panda/joint2_position_controller/command', Float64, queue_size=10)
    self.joint3_pub = rospy.Publisher('/panda/joint3_position_controller/command', Float64, queue_size=10)
    self.joint4_pub = rospy.Publisher('/panda/joint4_position_controller/command', Float64, queue_size=10)
    self.joint5_pub = rospy.Publisher('/panda/joint5_position_controller/command', Float64, queue_size=10)
    self.joint6_pub = rospy.Publisher('/panda/joint6_position_controller/command', Float64, queue_size=10)
    self.joint7_pub = rospy.Publisher('/panda/joint7_position_controller/command', Float64, queue_size=10)

    self.cmd_1 = Float64()
    self.cmd_2 = Float64()
    self.cmd_3 = Float64()
    self.cmd_4 = Float64()
    self.cmd_5 = Float64()
    self.cmd_6 = Float64()
    self.cmd_7 = Float64()

    rospy.sleep(2.0)

  def execute(self, positions):
    self.cmd_1.data = positions[0]
    self.cmd_2.data = positions[1]
    self.cmd_3.data = positions[2]
    self.cmd_4.data = positions[3]
    self.cmd_5.data = positions[4]
    self.cmd_6.data = positions[5]
    self.cmd_7.data = positions[6]

    self.joint1_pub.publish(self.cmd_1)
    self.joint2_pub.publish(self.cmd_2)
    self.joint3_pub.publish(self.cmd_3)
    self.joint4_pub.publish(self.cmd_4)
    self.joint5_pub.publish(self.cmd_5)
    self.joint6_pub.publish(self.cmd_6)
    self.joint7_pub.publish(self.cmd_7)



class collision_checker():
  def __init__(self):
    self.panda_checker = rospy.ServiceProxy('/check_state_validity', GetStateValidity)

    self.checker_rs = RobotState()
    self.checker_rs.joint_state.name = ['panda_finger_joint1', 'panda_finger_joint2', 'panda_joint1', 'panda_joint2', 'panda_joint3', 'panda_joint4', 'panda_joint5', 'panda_joint6', 'panda_joint7']
    self.checker_rs.joint_state.position = [0.02, 0.0, 0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0]

    self.checker_gsvr = GetStateValidityRequest()
    self.checker_gsvr.robot_state = self.checker_rs
    self.checker_gsvr.group_name = "panda_arm"

  def check(self, cmd):
    self.checker_gsvr.robot_state.joint_state.position[2:] = cmd
    # self.panda_checker.wait_for_service()
    result = self.panda_checker.call(self.checker_gsvr).valid
    return result
      
    







if __name__ == "__main__":

  # subscriber
  subscribers = sub_class()

  scene = scene_update()

  rospy.init_node('test')
  move_group = moveit_commander.MoveGroupCommander("panda_arm")
  move_group.set_planner_id("BiTRRTkConfigDefault")

  #move_group.allow_replanning(True)
  ee_goal_1 = np.array([0.5, 0.2, 0.3])
  ee_goal_2 = np.array([0.1, 0.0, 0.9])
  ee_goal = ee_goal_2

  commander = execute_cmd()
  checker = collision_checker()

  commander.execute([0.0, 0.5, 0.0, -2.5, 0.0, 0.5, 0.0])

  start = time.time()
  ans = checker.check([0.0, 0.5, 0.0, -2.5, 0.0, 0.5, 0.0])
  end = time.time()
  print(ans)
  t = end-start
  print(t)

  pose_goal = geometry_msgs.msg.Pose()
  #pose_goal.orientation.w = 1.0
  pose_goal.position.x = ee_goal[0]
  pose_goal.position.y = ee_goal[1]
  pose_goal.position.z = ee_goal[2]
  
  move_group.set_pose_target(pose_goal)
  start = time.time()
  plan = move_group.plan()
  end = time.time()
  t = end-start
  print(t)
  # r = rospy.Rate(50) # 1Hz

  # while not rospy.is_shutdown():
    
  #   scene.update()

  #   pose_goal = geometry_msgs.msg.Pose()
  #   #pose_goal.orientation.w = 1.0
  #   pose_goal.position.x = ee_goal[0]
  #   pose_goal.position.y = ee_goal[1]
  #   pose_goal.position.z = ee_goal[2]
  #   #move_group.set_joint_value_target(joint_goal)
  #   move_group.set_pose_target(pose_goal)

  #   plan = move_group.plan()
  #   path = plan[1]
  #   # del path.joint_trajectory.points[0]


  #   print(plan[0])
  #   # sucess = move_group.execute(plan[1], wait = False)
  #   if len(path.joint_trajectory.points) >= 3:
  #     commander.execute(path.joint_trajectory.points[2].positions)
  #   else:
  #     print("No valid path.")
  #     break
    
  #   # ee_pose = move_group.get_current_pose().pose
  #   # ee_state = np.array([ee_pose.position.x, ee_pose.position.y, ee_pose.position.z])
  #   # dis = distance(ee_goal, ee_state)


  #   r.sleep()
    #break




