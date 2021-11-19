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


class Scene_Handle:
    
    def __init__(self):
        #self.move_group = moveit_commander.MoveGroupCommander("panda_arm")
        self.scene = moveit_commander.PlanningSceneInterface()
        rospy.sleep(1.0)
        self.model_properties_client = rospy.ServiceProxy('/gazebo/get_model_properties', GetModelProperties)
        self.obs_size_cylinder = np.array([0.5, 0.08]) # [0.4, 0.05] [length, radius]
        self.obs_size_box = np.array([0.1, 0.1, 0.1])
        # URI of Mesh file should be changed if scene_handle is not running in current folder. 
        self.obs_mesh_human = '../../panda_gazebo/models/human/meshes/body.stl'
        self.obs_mesh_basket = '../../panda_gazebo/models/basket/meshes/real_case.stl'

        self.obs_pose = PoseStamped()
        self.obs_pose.header.frame_id = 'world'

        self.data_ob_client = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
        self.obs_list_client = rospy.ServiceProxy('/gazebo/get_world_properties', GetWorldProperties)
        
        # Get the name list of obs
        self.obs_list = []
        for i in self.obs_list_client().model_names:
            if "obstacle" in i:
                self.obs_list.append(i)
        self.obs_num = len(self.obs_list)
        self.obs_state_num = 7 * self.obs_num

        # Get the type list of obs
        self.obs_type = []
        for i in self.obs_list:
            single_type = self.model_properties_client(i).body_names[0]
            self.obs_type.append(single_type)

        # print(self.obs_list)
        # print(self.obs_type)

    def obstacle_update(self, obs_shape, obs_name, obs_state):
        obs_pose = PoseStamped()
        obs_pose.header.frame_id = 'world'
        obs_pose.pose.position.x = obs_state[0]
        obs_pose.pose.position.y = obs_state[1]
        obs_pose.pose.position.z = obs_state[2] - 1.0
        obs_pose.pose.orientation.x = obs_state[3]
        obs_pose.pose.orientation.y = obs_state[4]
        obs_pose.pose.orientation.z = obs_state[5]
        obs_pose.pose.orientation.w = obs_state[6]
        success = self.obs_cmd(obs_shape, obs_name, obs_pose)
        return success

    def obs_cmd(self, shape, name, pose):
        success = False
        if shape == 'cylinder':
            self.scene.add_cylinder(name, pose, self.obs_size_cylinder[0], self.obs_size_cylinder[1])
            success = name in self.scene.get_known_object_names()
        if shape == 'box':
            self.scene.add_box(name, pose, size=(self.obs_size_box[0], self.obs_size_box[1], self.obs_size_box[2]))
            success = name in self.scene.get_known_object_names()
        if shape == 'human':
            #print(os.getcwd())
            try:
                self.scene.add_mesh(name, pose, self.obs_mesh_human)
            except:
                rospy.logwarn("Cannot find mesh file.")
            success = name in self.scene.get_known_object_names()
        if shape == 'basket':
            #print(os.getcwd())
            try:
                self.scene.add_mesh(name, pose, self.obs_mesh_basket)
            except:
                rospy.logwarn("Cannot find mesh file.")
            success = name in self.scene.get_known_object_names()
        return success

    def observe_obstacles(self):
        observed_data = np.array([])
        attempt = 0
        data_obs = []
        # print("obs_list = " + str(self.obs_list))
        while (len(observed_data) ==0) and (len(self.obs_list) >= 1):
            try:
                for i in self.obs_list:
                    data_obs_ = self.data_ob_client(i, 'world').pose
                    data_obs += [data_obs_.position.x, data_obs_.position.y, data_obs_.position.z, data_obs_.orientation.x, data_obs_.orientation.y, data_obs_.orientation.z, data_obs_.orientation.w]
                    observed_data = np.array(data_obs)

            except:
                rospy.loginfo("There is no obstacles!")
                attempt += 1
                if attempt >= 10:
                    exit()
        
        # print("observed_data = " + str(observed_data))
        # print()
        # if (observed_data == None) and (len(self.obs_list) == 0):
        #     observed_data = np.array([])
        # print("Get here~")
        return observed_data

    def update(self):
        observed_data = self.observe_obstacles()
        for i in self.obs_list:
            id = self.obs_list.index(i)
            obs_shape = self.obs_type[id]
            obs_name = i
            obs_pose = observed_data[id*7:id*7+7]
            self.obstacle_update(obs_shape, obs_name, obs_pose)

if __name__ == "__main__":
    # Locate local working directory on where this file is
    outdir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(outdir)
    rospy.init_node("text")
    scene_object = Scene_Handle()

    r = rospy.Rate(10)

    # while not rospy.is_shutdown():
    scene_object.update()
    #     r.sleep()
    
    # human_pose = geometry_msgs.msg.PoseStamped()
    # human_pose.header.frame_id = "world"
    # qua = tf.transformations.quaternion_from_euler(-1.57, 0, 0, 'rxyz')
    # human_pose.pose.orientation.w = qua[0]
    # human_pose.pose.orientation.x = qua[1]
    # human_pose.pose.orientation.y = qua[2]
    # human_pose.pose.orientation.z = qua[3]

    # human_pose.pose.position.x = 0.8
    # human_pose.pose.position.y = 0.0
    # human_pose.pose.position.z = 0.0
    # human_name = "human"
    # scene_object.scene.add_mesh(human_name, human_pose, '/home/liu/panda_rl_2/src/panda_gazebo/models/human/meshes/body.stl')
    






    




        
        
    