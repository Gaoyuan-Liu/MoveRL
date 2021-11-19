import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
from franka_gripper.msg import MoveAction, GraspEpsilon, MoveGoal, GraspAction, GraspEpsilon, GraspGoal
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
import actionlib
import math
import time
import copy
import threading




class Franka_Controller:
    
    def __init__(self, ROSInterface):
        moveit_commander.roscpp_initialize('/joint_states:=joint_states')
        
        
        self.robot = moveit_commander.RobotCommander()
        self.scene = moveit_commander.PlanningSceneInterface()
        
        self.hand_group = moveit_commander.MoveGroupCommander("hand")
        self.arm_group = moveit_commander.MoveGroupCommander("panda_arm")
        
        #Grasping parameters
        self.gripperPublisher = rospy.Publisher('/panda_hand_controller/command', JointTrajectory, queue_size=1)
        
        self.ROSInterface = ROSInterface

        
    # Best niet gebruiken en combinatie met MoveIt, arm zal na elke trajectory terugkeren naar deze originele pose
    def go_to_default_position(self):
        joint_states = [0, -math.pi/4.0, 0, -3 * math.pi/4.0, 0, math.pi/2.0, 0.0 ]
        #joint_states[2] -= 1.0
        #self.arm_group.set_joint_value_target(joint_states)
        self.arm_group.go(joint_states)
        

    
    def get_joint_position(self):
        return self.hand_group.get_current_joint_values()
    
    def gripper_width(self, width):
        print('Moving gripper to width ' + str(width))

        joint_states = [width/2, width/2]
        print(joint_states)
        self.hand_group.set_joint_value_target(joint_states)
        self.hand_group.go()
        currentJointValues = self.hand_group.get_current_joint_values()
        while (currentJointValues[0] < width/2 - 0.005 or currentJointValues[0] > width/2 + 0.005) and (currentJointValues[1] < width/2 - 0.005 or currentJointValues[1] > width/2 + 0.005):
            time.sleep(0.01)
            currentJointValues = self.hand_group.get_current_joint_values()
        print("Finished moving gripper")

    def gripper_release(self, width):
        print("Releasing object")
        joint_states = [width/2, width/2]
        print(joint_states)
        self.hand_group.set_joint_value_target(joint_states)
        self.hand_group.go()
        while(self.ROSInterface.gripperGrasped):
            time.sleep(0.01)
        print("Object released")

    def gripper_grasp(self, width):
        print("Grasping object")
        jointT = JointTrajectory()
        jointTP = JointTrajectoryPoint()
        jointTP.positions = [width/2-0.01, width/2-0.01]
        jointTP.effort = [10,10]
        jointTP.time_from_start.secs = 1.0
        jointT.points = [jointTP]
        jointT.joint_names = ["panda_finger_joint1", "panda_finger_joint2"]
        
        #self.gripperPublisher.publish(jointT)
        counter = 0
        while(not self.ROSInterface.gripperGrasped):
            self.gripperPublisher.publish(jointT)
            time.sleep(0.01)
            counter += 1
            '''
            if counter%100==0:
                print("moving robot tiny amount")
                pose = self.get_cartesian_pose().pose
                self.go_to_cartesian_pose([pose.position.x, pose.position.y-0.001, pose.position.z], [pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w])
            '''
        print("Object grasped")

    
    # joint_list has length 7
    # Best niet gebruiken en combinatie met MoveIt, arm zal na elke trajectory terugkeren naar deze originele pose
    def go_to_joint_position(self, joint_list):
        self.arm_group.set_joint_value_target(joint_list)
        self.arm_group.go()
    
    
    def get_cartesian_pose(self):
        return self.arm_group.get_current_pose()
    
    # position_list: list of length=3 containing x,y,z position of endeffector
    # orientation_list: list of lenght=4 containing x,y,z,w quaternions of the endeffector
    def go_to_cartesian_pose(self, position_list, orientation_list):
        print("Starting cartesian pose motion")
        wpose = geometry_msgs.msg.Pose()
        wpose.orientation.w = orientation_list[3]
        wpose.orientation.x    = orientation_list[0]
        wpose.orientation.y = orientation_list[1]
        wpose.orientation.z = orientation_list[2]
        wpose.position.x = position_list[0]
        wpose.position.y = position_list[1]
        wpose.position.z = position_list[2]
        
        self.arm_group.set_pose_target(wpose)
        
        #current_pose = self.get_cartesian_position().pose
                #Maak moveit executable van wat nu in waypoints zit
        (plan, fraction) = self.arm_group.compute_cartesian_path([wpose], 0.001,0.0)
        self.arm_group.execute(plan)
        self.arm_group.go()   
        self.arm_group.stop()
        print("Finished cartesian pose motion")
    
    # Orientation contains String either 'evenwijdig' or 'dwars'
    # needs the same length for both position and orientation listst
    def follow_trajectory(self, posistion_list_list, orientation_list):
        print("Starting cartesian trajectory motion")
        starttime = time.time()
        if not (len(posistion_list_list) == len(orientation_list)):
            raise RuntimeError
        


        w = {'evenwijdig': 0.0, 'dwars': 0.707074559689}
        x = {'evenwijdig': 0.0, 'dwars': -0.707139000522}
        y = {'evenwijdig': 1.0, 'dwars': 2.35907969965e-05}
        z = {'evenwijdig': 0.0, 'dwars': 2.05984318254e-05}

        trajectory = []
        #current_pose = self.get_cartesian_position().pose
        for i in range(len(posistion_list_list)):
            wpose = geometry_msgs.msg.Pose()

            wpose.orientation.x = x[orientation_list[i]]
            wpose.orientation.y = y[orientation_list[i]]
            wpose.orientation.z = z[orientation_list[i]]
            wpose.orientation.w = w[orientation_list[i]]
            wpose.position.x = posistion_list_list[i][0]
            wpose.position.y = posistion_list_list[i][1]
            wpose.position.z = posistion_list_list[i][2]+0.11
            trajectory.append(wpose)

        (plan, fraction) = self.arm_group.compute_cartesian_path(trajectory, 0.001,0.0)
        print("calculating path took " + str(time.time()-starttime))
        starttime = time.time()
        self.arm_group.execute(plan)
        
        self.arm_group.go()
        print("executing path took " + str(time.time()-starttime))
        print("Finished cartesian trajectory motion")




    

