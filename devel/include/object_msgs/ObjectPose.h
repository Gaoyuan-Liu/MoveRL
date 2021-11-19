// Generated by gencpp from file object_msgs/ObjectPose.msg
// DO NOT EDIT!


#ifndef OBJECT_MSGS_MESSAGE_OBJECTPOSE_H
#define OBJECT_MSGS_MESSAGE_OBJECTPOSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <geometry_msgs/PoseStamped.h>

namespace object_msgs
{
template <class ContainerAllocator>
struct ObjectPose_
{
  typedef ObjectPose_<ContainerAllocator> Type;

  ObjectPose_()
    : name()
    , pose()  {
    }
  ObjectPose_(const ContainerAllocator& _alloc)
    : name(_alloc)
    , pose(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _name_type;
  _name_type name;

   typedef  ::geometry_msgs::PoseStamped_<ContainerAllocator>  _pose_type;
  _pose_type pose;





  typedef boost::shared_ptr< ::object_msgs::ObjectPose_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::object_msgs::ObjectPose_<ContainerAllocator> const> ConstPtr;

}; // struct ObjectPose_

typedef ::object_msgs::ObjectPose_<std::allocator<void> > ObjectPose;

typedef boost::shared_ptr< ::object_msgs::ObjectPose > ObjectPosePtr;
typedef boost::shared_ptr< ::object_msgs::ObjectPose const> ObjectPoseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::object_msgs::ObjectPose_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::object_msgs::ObjectPose_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::object_msgs::ObjectPose_<ContainerAllocator1> & lhs, const ::object_msgs::ObjectPose_<ContainerAllocator2> & rhs)
{
  return lhs.name == rhs.name &&
    lhs.pose == rhs.pose;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::object_msgs::ObjectPose_<ContainerAllocator1> & lhs, const ::object_msgs::ObjectPose_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace object_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::object_msgs::ObjectPose_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::object_msgs::ObjectPose_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::object_msgs::ObjectPose_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::object_msgs::ObjectPose_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::object_msgs::ObjectPose_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::object_msgs::ObjectPose_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::object_msgs::ObjectPose_<ContainerAllocator> >
{
  static const char* value()
  {
    return "8377dd3ee630b796499a6be053df1d41";
  }

  static const char* value(const ::object_msgs::ObjectPose_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x8377dd3ee630b796ULL;
  static const uint64_t static_value2 = 0x499a6be053df1d41ULL;
};

template<class ContainerAllocator>
struct DataType< ::object_msgs::ObjectPose_<ContainerAllocator> >
{
  static const char* value()
  {
    return "object_msgs/ObjectPose";
  }

  static const char* value(const ::object_msgs::ObjectPose_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::object_msgs::ObjectPose_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# the name of the object\n"
"string name\n"
"\n"
"# the pose of the object\n"
"geometry_msgs/PoseStamped pose\n"
"\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/PoseStamped\n"
"# A Pose with reference coordinate frame and timestamp\n"
"Header header\n"
"Pose pose\n"
"\n"
"================================================================================\n"
"MSG: std_msgs/Header\n"
"# Standard metadata for higher-level stamped data types.\n"
"# This is generally used to communicate timestamped data \n"
"# in a particular coordinate frame.\n"
"# \n"
"# sequence ID: consecutively increasing ID \n"
"uint32 seq\n"
"#Two-integer timestamp that is expressed as:\n"
"# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n"
"# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n"
"# time-handling sugar is provided by the client library\n"
"time stamp\n"
"#Frame this data is associated with\n"
"string frame_id\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Pose\n"
"# A representation of pose in free space, composed of position and orientation. \n"
"Point position\n"
"Quaternion orientation\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Point\n"
"# This contains the position of a point in free space\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Quaternion\n"
"# This represents an orientation in free space in quaternion form.\n"
"\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"float64 w\n"
;
  }

  static const char* value(const ::object_msgs::ObjectPose_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::object_msgs::ObjectPose_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.name);
      stream.next(m.pose);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ObjectPose_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::object_msgs::ObjectPose_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::object_msgs::ObjectPose_<ContainerAllocator>& v)
  {
    s << indent << "name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.name);
    s << indent << "pose: ";
    s << std::endl;
    Printer< ::geometry_msgs::PoseStamped_<ContainerAllocator> >::stream(s, indent + "  ", v.pose);
  }
};

} // namespace message_operations
} // namespace ros

#endif // OBJECT_MSGS_MESSAGE_OBJECTPOSE_H