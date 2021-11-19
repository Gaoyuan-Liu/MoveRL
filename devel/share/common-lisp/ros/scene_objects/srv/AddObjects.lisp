; Auto-generated. Do not edit!


(cl:in-package scene_objects-srv)


;//! \htmlinclude AddObjects-request.msg.html

(cl:defclass <AddObjects-request> (roslisp-msg-protocol:ros-message)
  ((shape
    :reader shape
    :initarg :shape
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (name
    :reader name
    :initarg :name
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped))
   (size
    :reader size
    :initarg :size
    :type std_msgs-msg:Float64MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float64MultiArray)))
)

(cl:defclass AddObjects-request (<AddObjects-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddObjects-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddObjects-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name scene_objects-srv:<AddObjects-request> is deprecated: use scene_objects-srv:AddObjects-request instead.")))

(cl:ensure-generic-function 'shape-val :lambda-list '(m))
(cl:defmethod shape-val ((m <AddObjects-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader scene_objects-srv:shape-val is deprecated.  Use scene_objects-srv:shape instead.")
  (shape m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <AddObjects-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader scene_objects-srv:name-val is deprecated.  Use scene_objects-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <AddObjects-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader scene_objects-srv:pose-val is deprecated.  Use scene_objects-srv:pose instead.")
  (pose m))

(cl:ensure-generic-function 'size-val :lambda-list '(m))
(cl:defmethod size-val ((m <AddObjects-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader scene_objects-srv:size-val is deprecated.  Use scene_objects-srv:size instead.")
  (size m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddObjects-request>) ostream)
  "Serializes a message object of type '<AddObjects-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'shape) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'name) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'size) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddObjects-request>) istream)
  "Deserializes a message object of type '<AddObjects-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'shape) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'name) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'size) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddObjects-request>)))
  "Returns string type for a service object of type '<AddObjects-request>"
  "scene_objects/AddObjectsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddObjects-request)))
  "Returns string type for a service object of type 'AddObjects-request"
  "scene_objects/AddObjectsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddObjects-request>)))
  "Returns md5sum for a message object of type '<AddObjects-request>"
  "52787aaffa634714d435fdc99358732c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddObjects-request)))
  "Returns md5sum for a message object of type 'AddObjects-request"
  "52787aaffa634714d435fdc99358732c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddObjects-request>)))
  "Returns full string definition for message of type '<AddObjects-request>"
  (cl:format cl:nil "std_msgs/String shape~%std_msgs/String name~%geometry_msgs/PoseStamped pose~%std_msgs/Float64MultiArray size~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/Float64MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float64[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddObjects-request)))
  "Returns full string definition for message of type 'AddObjects-request"
  (cl:format cl:nil "std_msgs/String shape~%std_msgs/String name~%geometry_msgs/PoseStamped pose~%std_msgs/Float64MultiArray size~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/Float64MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float64[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddObjects-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'shape))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'size))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddObjects-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AddObjects-request
    (cl:cons ':shape (shape msg))
    (cl:cons ':name (name msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':size (size msg))
))
;//! \htmlinclude AddObjects-response.msg.html

(cl:defclass <AddObjects-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type std_msgs-msg:Bool
    :initform (cl:make-instance 'std_msgs-msg:Bool)))
)

(cl:defclass AddObjects-response (<AddObjects-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddObjects-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddObjects-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name scene_objects-srv:<AddObjects-response> is deprecated: use scene_objects-srv:AddObjects-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <AddObjects-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader scene_objects-srv:success-val is deprecated.  Use scene_objects-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddObjects-response>) ostream)
  "Serializes a message object of type '<AddObjects-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'success) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddObjects-response>) istream)
  "Deserializes a message object of type '<AddObjects-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'success) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddObjects-response>)))
  "Returns string type for a service object of type '<AddObjects-response>"
  "scene_objects/AddObjectsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddObjects-response)))
  "Returns string type for a service object of type 'AddObjects-response"
  "scene_objects/AddObjectsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddObjects-response>)))
  "Returns md5sum for a message object of type '<AddObjects-response>"
  "52787aaffa634714d435fdc99358732c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddObjects-response)))
  "Returns md5sum for a message object of type 'AddObjects-response"
  "52787aaffa634714d435fdc99358732c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddObjects-response>)))
  "Returns full string definition for message of type '<AddObjects-response>"
  (cl:format cl:nil "std_msgs/Bool success~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddObjects-response)))
  "Returns full string definition for message of type 'AddObjects-response"
  (cl:format cl:nil "std_msgs/Bool success~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddObjects-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'success))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddObjects-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AddObjects-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AddObjects)))
  'AddObjects-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AddObjects)))
  'AddObjects-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddObjects)))
  "Returns string type for a service object of type '<AddObjects>"
  "scene_objects/AddObjects")