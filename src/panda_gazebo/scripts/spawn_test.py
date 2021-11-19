from gazebo_msgs.srv import SpawnModel
from gazebo_msgs.srv import DeleteModel
import rospy
from geometry_msgs.msg import Pose

if __name__ == "__main__":
    spawn_model_client = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
    delet_model_client = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
    """spawn_model_client(
        model_name='drone',
        model_xml=open('/home/liu/.gazebo/models/quadrotor/model.sdf', 'r').read(),
        robot_namespace='/foo',
        initial_pose=Pose(),
        reference_frame='world'
    )"""
    delet_model_client(model_name='panda')
