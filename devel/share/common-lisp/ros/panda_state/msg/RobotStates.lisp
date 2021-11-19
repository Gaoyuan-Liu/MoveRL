; Auto-generated. Do not edit!


(cl:in-package panda_state-msg)


;//! \htmlinclude RobotStates.msg.html

(cl:defclass <RobotStates> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (xe
    :reader xe
    :initarg :xe
    :type (cl:vector std_msgs-msg:Float64)
   :initform (cl:make-array 3 :element-type 'std_msgs-msg:Float64 :initial-element (cl:make-instance 'std_msgs-msg:Float64))))
)

(cl:defclass RobotStates (<RobotStates>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RobotStates>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RobotStates)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name panda_state-msg:<RobotStates> is deprecated: use panda_state-msg:RobotStates instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <RobotStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_state-msg:header-val is deprecated.  Use panda_state-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'xe-val :lambda-list '(m))
(cl:defmethod xe-val ((m <RobotStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader panda_state-msg:xe-val is deprecated.  Use panda_state-msg:xe instead.")
  (xe m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RobotStates>) ostream)
  "Serializes a message object of type '<RobotStates>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'xe))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RobotStates>) istream)
  "Deserializes a message object of type '<RobotStates>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:setf (cl:slot-value msg 'xe) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'xe)))
    (cl:dotimes (i 3)
    (cl:setf (cl:aref vals i) (cl:make-instance 'std_msgs-msg:Float64))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RobotStates>)))
  "Returns string type for a message object of type '<RobotStates>"
  "panda_state/RobotStates")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RobotStates)))
  "Returns string type for a message object of type 'RobotStates"
  "panda_state/RobotStates")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RobotStates>)))
  "Returns md5sum for a message object of type '<RobotStates>"
  "79c455d062acdbc2bbc3010df721a4d4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RobotStates)))
  "Returns md5sum for a message object of type 'RobotStates"
  "79c455d062acdbc2bbc3010df721a4d4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RobotStates>)))
  "Returns full string definition for message of type '<RobotStates>"
  (cl:format cl:nil "Header header~%~%std_msgs/Float64[3] xe ~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: std_msgs/Float64~%float64 data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RobotStates)))
  "Returns full string definition for message of type 'RobotStates"
  (cl:format cl:nil "Header header~%~%std_msgs/Float64[3] xe ~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: std_msgs/Float64~%float64 data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RobotStates>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'xe) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RobotStates>))
  "Converts a ROS message object to a list"
  (cl:list 'RobotStates
    (cl:cons ':header (header msg))
    (cl:cons ':xe (xe msg))
))
