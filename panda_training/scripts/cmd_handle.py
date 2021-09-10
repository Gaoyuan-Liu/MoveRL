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


class Cmd_Handle:
    
    def __init__(self, exe_time=5, mode='joint_space'): # cmd is a 7 dof np.array

        self.mode = mode
        if self.mode != 'joint_space' and self.mode != 'cartesian_space':
            print("Invalid cmd mode!")
            exit()

        self.cmdPublisher = rospy.Publisher('/panda/panda_arm_controller/command', JointTrajectory, queue_size=10)
        self.move_group = moveit_commander.MoveGroupCommander("panda_arm")
        self.move_group.set_planner_id("RRTstar")
        self.move_group.set_planning_time(0.1)

        self.joint_goal = self.move_group.get_current_joint_values()
        self.pose_goal = np.array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
        self.exe_time = exe_time
        self.jointTP = JointTrajectoryPoint()
        self.jointTP_half = JointTrajectoryPoint()
        self.jointTP_start = JointTrajectoryPoint()
        
        
        self.jointT = JointTrajectory()
        self.jointT.joint_names = ["panda_joint1", "panda_joint2", "panda_joint3", "panda_joint4", "panda_joint5", "panda_joint6", "panda_joint7"]

        self.ik_solver = IK("panda_link0", "panda_link8")
        self.seed_state = [0.0] * self.ik_solver.number_of_joints

    def update_cmd(self, cmd):
        if self.mode == 'joint_space':
            if len(cmd) != 7:
                rospy.logwarn("Size of joint space command should be 7, %s given now.", len(cmd))
            self.jointTP.positions = list(cmd)
            success = True

        elif self.mode == 'cartesian_space':
            if len(cmd) != 6:
                rospy.logwarn("Size of cartesian space command should be 6 dof, %s given now.", len(cmd))
            qua = tf.transformations.quaternion_from_euler(cmd[3], cmd[4], cmd[5], 'rxyz')
            solution = self.ik_solver.get_ik(self.seed_state,
                cmd[0], cmd[1], cmd[2],
                qua[0], qua[1], qua[2], qua[3],
                0.01, 0.01, 0.01,  # X, Y, Z bounds
                0.01, 0.01, 0.01)  # Rotation X, Y, Z bounds
            print("Ik solution = " + str(solution))
            if solution == None:
                self.jointTP.positions = self.move_group.get_current_joint_values()
                self.jointTP_half.positions = self.jointTP.positions
                self.jointTP_start.positions = self.jointTP.positions
                success = False

            else:
                # Solution is tuple
                self.jointTP_start.positions = self.move_group.get_current_joint_values()
                self.jointTP_half.positions = list((np.array(solution)-np.array(self.move_group.get_current_joint_values()))/2)
                self.jointTP.positions = list(solution)
                success = True
        else:
            print("Invalid cmd mode!")
            exit()

        self.jointTP.time_from_start = rospy.Duration(self.exe_time * 0.75)
        self.jointTP_half.time_from_start = rospy.Duration((self.exe_time)/2)
        self.jointTP_start.time_from_start = rospy.Duration(self.exe_time)
        self.jointT.points = [self.jointTP]
        return success

    def direct_panda_cmd(self, cmd):
        cmd_update_success = self.update_cmd(cmd)
        success = False
        start = time.time()
        end = start 
        i = 0
        try:
            # while end - start <= self.exe_time:
            self.cmdPublisher.publish(self.jointT)
                #end = time.time()
                # rospy.sleep(0.1)
                # print(end)
            success = True
        except:
            success = False
        rospy.sleep(self.exe_time)
        success = success and cmd_update_success
        return success
           
    def moveit_panda_cmd(self, cmd):
        if self.mode == 'joint_space':
            if len(cmd) != 7:
                rospy.logwarn("Size of joint space command should be 7, %s given now.", len(cmd))

            self.joint_goal[0] = cmd[0]
            self.joint_goal[1] = cmd[1]
            self.joint_goal[2] = cmd[2]
            self.joint_goal[3] = cmd[3]
            self.joint_goal[4] = cmd[4]
            self.joint_goal[5] = cmd[5]
            self.joint_goal[6] = cmd[6]
            success = self.move_group.go(self.joint_goal, wait=True)
            self.move_group.stop()

        elif self.mode == 'cartesian_space':
            if len(cmd) != 6:
                rospy.logwarn("Size of cartesian space command should be 6 dof, %s given now.", len(cmd))
            self.pose_goal = cmd
            self.move_group.set_pose_target(list(self.pose_goal))
            plan_tuple = self.move_group.plan()
            path = plan_tuple[1]
            success = self.move_group.execute(path)

            # success = self.move_group.go(wait=True)
            self.move_group.stop()

        return success, path

    def cmd_ik(self, cmd_p):
        qua = tf.transformations.quaternion_from_euler(cmd_p[3], cmd_p[4], cmd_p[5], 'rxyz')
            # print(cmd)
        solution = self.ik_solver.get_ik(self.seed_state,
            cmd_p[0], cmd_p[1], cmd_p[2],
            qua[0], qua[1], qua[2], qua[3],
            0.01, 0.01, 0.01,  # X, Y, Z bounds
            0.1, 0.1, 0.1)  # Rotation X, Y, Z bounds

        if solution == None:
            cmd_q = self.move_group.get_current_joint_values()
            success = False

        else:
            cmd_q= list(solution)
            success = True

        return cmd_q

    def plan(self, cmd):
        self.pose_goal = cmd
        self.move_group.set_pose_target(list(self.pose_goal))
        plan = self.move_group.plan()
        success = plan[0]
        path = plan[1]
        return success, path

    def execute(self, plan):
        success = self.move_group.execute(plan)
        return success 

    def initial_pose(self):
        success = False
        start = time.time()
        end = start

        self.jointTP_start.positions = [0, -0.785, 0, -1.8356, 0, 1.571, 0.785]
        self.jointTP_start.time_from_start = rospy.Duration(self.exe_time)
        self.jointT.points = [self.jointTP_start]

        try:
            # while end - start <= self.exe_time:
            self.cmdPublisher.publish(self.jointT)
                #end = time.time()
                # rospy.sleep(0.1)
                # print(end)
            success = True
        except:
            success = False
        rospy.sleep(self.exe_time)
        return success


        


            



       

if __name__ == "__main__":
    rospy.init_node("text")

    commander = Cmd_Handle(exe_time=0.5, mode="joint_space")
    rospy.sleep(2)
    # plan = commander.only_plan(np.array([0.4, 0, 0.6, 0, 0, 0, 0])) # Return a tuple (Bool, RobotTrajectory)
    # print(len(list(plan[1].joint_trajectory.points[-1].positions)))
    # sucess = commander.only_execute(plan[1])

    # Initial
    success = commander.direct_panda_cmd(np.array([0.0, 0.0, 0.0, -1.0, 0.0, 0.5, 0.0]))
    # Self Collision:
    # success = commander.direct_panda_cmd(np.array([0.0, 0.5, 0.0, -3.5, 0.0, 0.5, 0.0]))
    # Pose Collision:
    # success = commander.direct_panda_cmd(np.array([0.0, 0.0, 0.0, -2.5, 0.0, 2.0, 0.0]))
    # Path Collision:
    # success = commander.direct_panda_cmd(np.array([0.0, 0.0, 0.0, -0.5, 0.0, 0.5, 0.0]))


    # print(success)
    #commander.moveit_panda_cmd(np.array([0.00, 1.00, 1.00, -0.50, 0.00, 0.50, 0.00]))
    print(commander.move_group.get_current_joint_values())
    print(commander.move_group.get_current_pose())







    




        
        
    