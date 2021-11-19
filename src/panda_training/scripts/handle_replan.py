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
import moveit_commander
import tf
from trac_ik_python.trac_ik import IK
from handle_object import Object_Handle

from std_msgs.msg import Float64

from moveit_msgs.srv import GetStateValidityRequest, GetStateValidity
from moveit_msgs.msg import RobotState



class Replan_Handle:
    
    def __init__(self): 

 
        self.cmdPublisher = rospy.Publisher('/panda/panda_arm_controller/command', JointTrajectory, queue_size=10)
        self.move_group = moveit_commander.MoveGroupCommander("panda_arm")
        #self.move_group.set_planner_id("RRTstar")
        #self.move_group.set_planning_time(0.1)

        self.joint_goal = self.move_group.get_current_joint_values()
        self.pose_goal = np.array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
        
        self.jointT = JointTrajectory()
        self.jointT.joint_names = ["panda_joint1", "panda_joint2", "panda_joint3", "panda_joint4", "panda_joint5", "panda_joint6", "panda_joint7"]

        self.ik_solver = IK("panda_link0", "panda_link8")
        self.seed_state = [0.0] * self.ik_solver.number_of_joints

        self.obj_handle = Object_Handle()

        self.qua_push_x = tf.transformations.quaternion_from_euler(3.14, 0.0, 0.785, 'rxyz')
        self.qua_push_y = tf.transformations.quaternion_from_euler(3.14, 0.0, -0.785, 'rxyz')

        # For position command execution
        self.joint1_pub = rospy.Publisher('/panda/joint1_position_controller/command', Float64, queue_size=10)
        self.joint2_pub = rospy.Publisher('/panda/joint2_position_controller/command', Float64, queue_size=10)
        self.joint3_pub = rospy.Publisher('/panda/joint3_position_controller/command', Float64, queue_size=10)
        self.joint4_pub = rospy.Publisher('/panda/joint4_position_controller/command', Float64, queue_size=10)
        self.joint5_pub = rospy.Publisher('/panda/joint5_position_controller/command', Float64, queue_size=10)
        self.joint6_pub = rospy.Publisher('/panda/joint6_position_controller/command', Float64, queue_size=10)
        self.joint7_pub = rospy.Publisher('/panda/joint7_position_controller/command', Float64, queue_size=10)
        self.leftfinger_pub = rospy.Publisher('/panda/joint_leftfinger_position_controller/command', Float64, queue_size=10)
        self.rightfinger_pub = rospy.Publisher('/panda/joint_rightfinger_position_controller/command', Float64, queue_size=10)
        self.cmd_1 = Float64()
        self.cmd_2 = Float64()
        self.cmd_3 = Float64()
        self.cmd_4 = Float64()
        self.cmd_5 = Float64()
        self.cmd_6 = Float64()
        self.cmd_7 = Float64()
        self.cmd_finger = Float64()
        rospy.sleep(2.0)

        # For collision checking
        self.panda_checker = rospy.ServiceProxy('/check_state_validity', GetStateValidity)
        self.checker_rs = RobotState()
        self.checker_rs.joint_state.name = ['panda_finger_joint1', 'panda_finger_joint2', 'panda_joint1', 'panda_joint2', 'panda_joint3', 'panda_joint4', 'panda_joint5', 'panda_joint6', 'panda_joint7']
        self.checker_rs.joint_state.position = [0.02, 0.0, 0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0]
        self.checker_gsvr = GetStateValidityRequest()
        self.checker_gsvr.robot_state = self.checker_rs
        self.checker_gsvr.group_name = "panda_arm"

    def object_location(self, obj_name):
        where_is = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
        obj_pose = where_is(obj_name, 'world').pose 
        return obj_pose

    def grasp_configs(self, obj_name):
        obj_pose = self.object_location(obj_name)
        obj_xyz = [obj_pose.position.x, obj_pose.position.y, obj_pose.position.z]

        quaternion = [obj_pose.orientation.x,
                        obj_pose.orientation.y,
                        obj_pose.orientation.z,
                        obj_pose.orientation.w]
        obj_rpy = list(tf.transformations.euler_from_quaternion(quaternion))

        obj_size = [0.05, 0.05, 0.05]

        pose_config_1 = [obj_xyz[0], obj_xyz[1], obj_xyz[2]-1+0.2] + [3.14, 0.0, obj_rpy[-1]-0.785]
        pose_config_2 = [obj_xyz[0], obj_xyz[1], obj_xyz[2]-1+0.1] +  [3.14, 0.0, obj_rpy[-1]-0.785]

        return pose_config_1, pose_config_2

    def check(self, cmd):
        self.checker_gsvr.robot_state.joint_state.position[2:] = cmd
        # self.panda_checker.wait_for_service()
        result = self.panda_checker.call(self.checker_gsvr).valid
        return result

    def go(self, pose_config):
        r = rospy.Rate(100) # 
        self.move_group.set_pose_target(pose_config)
        plan_tuple = self.move_group.plan()
        # print(plan_tuple[0])
        while not rospy.is_shutdown():

            success = plan_tuple[0]
            path = plan_tuple[1]

            # Check future m points
            # if len(path.joint_trajectory.points) >= 5:
            #     m = 5
            # else:
            #     m = len(path.joint_trajectory.points)
            # for i in range(m):
            #     point_valid = self.check(path.joint_trajectory.points[i].positions)
            #     if point_valid == False:
            #         plan_tuple = self.move_group.plan()
            #         success = plan_tuple[0]
            #         path = plan_tuple[1]
            #         print("Replan.")

            # Unable checking and pure replanning:
            plan_tuple = self.move_group.plan()
            
            del path.joint_trajectory.points[0]
            if success==True:
                if len(path.joint_trajectory.points) >= 5:
                    self.execute(path.joint_trajectory.points[4].positions)
                elif len(path.joint_trajectory.points) >= 4:
                    self.execute(path.joint_trajectory.points[3].positions)
                elif len(path.joint_trajectory.points) >= 3:
                    self.execute(path.joint_trajectory.points[2].positions)

                else:
                    print("Pose reached.")
                    break
            r.sleep()

        

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

    def open_fingers(self):
        self.cmd_finger.data = 0.04
        self.leftfinger_pub.publish(self.cmd_finger)
        self.rightfinger_pub.publish(self.cmd_finger)

    def close_fingers(self):
        self.cmd_finger.data = 0.0
        self.leftfinger_pub.publish(self.cmd_finger)
        self.rightfinger_pub.publish(self.cmd_finger)
            

    def grasp(self, obj_name):
        pose_config_1, pose_config_2 = self.grasp_configs(obj_name)
        self.go(pose_config_1)
        rospy.sleep(0.5)
        self.open_fingers()
        rospy.sleep(0.5)
        self.go(pose_config_2)
        rospy.sleep(0.5)
        self.close_fingers()
        rospy.sleep(0.5)


    

if __name__ == "__main__":
    rospy.init_node("text")

    commander = Replan_Handle()
    # commander.grasp('task_2')

    # rospy.sleep(1.0)

    commander.go([-0.5, 0.0, 0.5, 3.14, 0, 0])

    

 
    
    # commander.close_fingers()
    # commander.open_fingers()









    




        
        
    