; Auto-generated. Do not edit!


(cl:in-package gazebo_grasp_plugin-msg)


;//! \htmlinclude GazeboGraspEvent.msg.html

(cl:defclass <GazeboGraspEvent> (roslisp-msg-protocol:ros-message)
  ((arm
    :reader arm
    :initarg :arm
    :type cl:string
    :initform "")
   (object
    :reader object
    :initarg :object
    :type cl:string
    :initform "")
   (attached
    :reader attached
    :initarg :attached
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GazeboGraspEvent (<GazeboGraspEvent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GazeboGraspEvent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GazeboGraspEvent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gazebo_grasp_plugin-msg:<GazeboGraspEvent> is deprecated: use gazebo_grasp_plugin-msg:GazeboGraspEvent instead.")))

(cl:ensure-generic-function 'arm-val :lambda-list '(m))
(cl:defmethod arm-val ((m <GazeboGraspEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_grasp_plugin-msg:arm-val is deprecated.  Use gazebo_grasp_plugin-msg:arm instead.")
  (arm m))

(cl:ensure-generic-function 'object-val :lambda-list '(m))
(cl:defmethod object-val ((m <GazeboGraspEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_grasp_plugin-msg:object-val is deprecated.  Use gazebo_grasp_plugin-msg:object instead.")
  (object m))

(cl:ensure-generic-function 'attached-val :lambda-list '(m))
(cl:defmethod attached-val ((m <GazeboGraspEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_grasp_plugin-msg:attached-val is deprecated.  Use gazebo_grasp_plugin-msg:attached instead.")
  (attached m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GazeboGraspEvent>) ostream)
  "Serializes a message object of type '<GazeboGraspEvent>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'arm))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'arm))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'attached) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GazeboGraspEvent>) istream)
  "Deserializes a message object of type '<GazeboGraspEvent>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'arm) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'arm) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'object) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'attached) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GazeboGraspEvent>)))
  "Returns string type for a message object of type '<GazeboGraspEvent>"
  "gazebo_grasp_plugin/GazeboGraspEvent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GazeboGraspEvent)))
  "Returns string type for a message object of type 'GazeboGraspEvent"
  "gazebo_grasp_plugin/GazeboGraspEvent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GazeboGraspEvent>)))
  "Returns md5sum for a message object of type '<GazeboGraspEvent>"
  "a5b6c6f554465c6bcbcad9409a41137a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GazeboGraspEvent)))
  "Returns md5sum for a message object of type 'GazeboGraspEvent"
  "a5b6c6f554465c6bcbcad9409a41137a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GazeboGraspEvent>)))
  "Returns full string definition for message of type '<GazeboGraspEvent>"
  (cl:format cl:nil "string arm     # responsible arm~%string object  # affected object~%bool attached  # detached if false~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GazeboGraspEvent)))
  "Returns full string definition for message of type 'GazeboGraspEvent"
  (cl:format cl:nil "string arm     # responsible arm~%string object  # affected object~%bool attached  # detached if false~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GazeboGraspEvent>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'arm))
     4 (cl:length (cl:slot-value msg 'object))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GazeboGraspEvent>))
  "Converts a ROS message object to a list"
  (cl:list 'GazeboGraspEvent
    (cl:cons ':arm (arm msg))
    (cl:cons ':object (object msg))
    (cl:cons ':attached (attached msg))
))
