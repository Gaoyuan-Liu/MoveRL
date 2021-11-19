; Auto-generated. Do not edit!


(cl:in-package rl_interface-srv)


;//! \htmlinclude PandaCmd-request.msg.html

(cl:defclass <PandaCmd-request> (roslisp-msg-protocol:ros-message)
  ((cmd
    :reader cmd
    :initarg :cmd
    :type std_msgs-msg:Float64MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float64MultiArray)))
)

(cl:defclass PandaCmd-request (<PandaCmd-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PandaCmd-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PandaCmd-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rl_interface-srv:<PandaCmd-request> is deprecated: use rl_interface-srv:PandaCmd-request instead.")))

(cl:ensure-generic-function 'cmd-val :lambda-list '(m))
(cl:defmethod cmd-val ((m <PandaCmd-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rl_interface-srv:cmd-val is deprecated.  Use rl_interface-srv:cmd instead.")
  (cmd m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PandaCmd-request>) ostream)
  "Serializes a message object of type '<PandaCmd-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cmd) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PandaCmd-request>) istream)
  "Deserializes a message object of type '<PandaCmd-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cmd) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PandaCmd-request>)))
  "Returns string type for a service object of type '<PandaCmd-request>"
  "rl_interface/PandaCmdRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PandaCmd-request)))
  "Returns string type for a service object of type 'PandaCmd-request"
  "rl_interface/PandaCmdRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PandaCmd-request>)))
  "Returns md5sum for a message object of type '<PandaCmd-request>"
  "c1a7b32be5be6c0f024512355d194266")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PandaCmd-request)))
  "Returns md5sum for a message object of type 'PandaCmd-request"
  "c1a7b32be5be6c0f024512355d194266")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PandaCmd-request>)))
  "Returns full string definition for message of type '<PandaCmd-request>"
  (cl:format cl:nil "std_msgs/Float64MultiArray cmd~%~%================================================================================~%MSG: std_msgs/Float64MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float64[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PandaCmd-request)))
  "Returns full string definition for message of type 'PandaCmd-request"
  (cl:format cl:nil "std_msgs/Float64MultiArray cmd~%~%================================================================================~%MSG: std_msgs/Float64MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float64[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PandaCmd-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cmd))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PandaCmd-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PandaCmd-request
    (cl:cons ':cmd (cmd msg))
))
;//! \htmlinclude PandaCmd-response.msg.html

(cl:defclass <PandaCmd-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type std_msgs-msg:Bool
    :initform (cl:make-instance 'std_msgs-msg:Bool)))
)

(cl:defclass PandaCmd-response (<PandaCmd-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PandaCmd-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PandaCmd-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rl_interface-srv:<PandaCmd-response> is deprecated: use rl_interface-srv:PandaCmd-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <PandaCmd-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rl_interface-srv:success-val is deprecated.  Use rl_interface-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PandaCmd-response>) ostream)
  "Serializes a message object of type '<PandaCmd-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'success) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PandaCmd-response>) istream)
  "Deserializes a message object of type '<PandaCmd-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'success) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PandaCmd-response>)))
  "Returns string type for a service object of type '<PandaCmd-response>"
  "rl_interface/PandaCmdResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PandaCmd-response)))
  "Returns string type for a service object of type 'PandaCmd-response"
  "rl_interface/PandaCmdResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PandaCmd-response>)))
  "Returns md5sum for a message object of type '<PandaCmd-response>"
  "c1a7b32be5be6c0f024512355d194266")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PandaCmd-response)))
  "Returns md5sum for a message object of type 'PandaCmd-response"
  "c1a7b32be5be6c0f024512355d194266")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PandaCmd-response>)))
  "Returns full string definition for message of type '<PandaCmd-response>"
  (cl:format cl:nil "std_msgs/Bool success~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PandaCmd-response)))
  "Returns full string definition for message of type 'PandaCmd-response"
  (cl:format cl:nil "std_msgs/Bool success~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PandaCmd-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'success))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PandaCmd-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PandaCmd-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PandaCmd)))
  'PandaCmd-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PandaCmd)))
  'PandaCmd-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PandaCmd)))
  "Returns string type for a service object of type '<PandaCmd>"
  "rl_interface/PandaCmd")