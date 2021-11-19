; Auto-generated. Do not edit!


(cl:in-package object_msgs-srv)


;//! \htmlinclude RegisterObject-request.msg.html

(cl:defclass <RegisterObject-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass RegisterObject-request (<RegisterObject-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RegisterObject-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RegisterObject-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name object_msgs-srv:<RegisterObject-request> is deprecated: use object_msgs-srv:RegisterObject-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <RegisterObject-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader object_msgs-srv:name-val is deprecated.  Use object_msgs-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RegisterObject-request>) ostream)
  "Serializes a message object of type '<RegisterObject-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RegisterObject-request>) istream)
  "Deserializes a message object of type '<RegisterObject-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RegisterObject-request>)))
  "Returns string type for a service object of type '<RegisterObject-request>"
  "object_msgs/RegisterObjectRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RegisterObject-request)))
  "Returns string type for a service object of type 'RegisterObject-request"
  "object_msgs/RegisterObjectRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RegisterObject-request>)))
  "Returns md5sum for a message object of type '<RegisterObject-request>"
  "325b0c2df13037cc771f5f0cd7f14976")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RegisterObject-request)))
  "Returns md5sum for a message object of type 'RegisterObject-request"
  "325b0c2df13037cc771f5f0cd7f14976")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RegisterObject-request>)))
  "Returns full string definition for message of type '<RegisterObject-request>"
  (cl:format cl:nil "# object name to be registered~%string name~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RegisterObject-request)))
  "Returns full string definition for message of type 'RegisterObject-request"
  (cl:format cl:nil "# object name to be registered~%string name~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RegisterObject-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RegisterObject-request>))
  "Converts a ROS message object to a list"
  (cl:list 'RegisterObject-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude RegisterObject-response.msg.html

(cl:defclass <RegisterObject-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:integer
    :initform 0))
)

(cl:defclass RegisterObject-response (<RegisterObject-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RegisterObject-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RegisterObject-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name object_msgs-srv:<RegisterObject-response> is deprecated: use object_msgs-srv:RegisterObject-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <RegisterObject-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader object_msgs-srv:success-val is deprecated.  Use object_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<RegisterObject-response>)))
    "Constants for message type '<RegisterObject-response>"
  '((:SUCCESS . 0)
    (:EXISTS . 1)
    (:ERROR_INFO . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'RegisterObject-response)))
    "Constants for message type 'RegisterObject-response"
  '((:SUCCESS . 0)
    (:EXISTS . 1)
    (:ERROR_INFO . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RegisterObject-response>) ostream)
  "Serializes a message object of type '<RegisterObject-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'success)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RegisterObject-response>) istream)
  "Deserializes a message object of type '<RegisterObject-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'success)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RegisterObject-response>)))
  "Returns string type for a service object of type '<RegisterObject-response>"
  "object_msgs/RegisterObjectResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RegisterObject-response)))
  "Returns string type for a service object of type 'RegisterObject-response"
  "object_msgs/RegisterObjectResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RegisterObject-response>)))
  "Returns md5sum for a message object of type '<RegisterObject-response>"
  "325b0c2df13037cc771f5f0cd7f14976")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RegisterObject-response)))
  "Returns md5sum for a message object of type 'RegisterObject-response"
  "325b0c2df13037cc771f5f0cd7f14976")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RegisterObject-response>)))
  "Returns full string definition for message of type '<RegisterObject-response>"
  (cl:format cl:nil "~%# succes flag~%byte success~%~%# successfully registered~%byte SUCCESS=0~%~%# object already registered~%byte EXISTS=1~%~%# could not query required information for this object~%byte ERROR_INFO=2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RegisterObject-response)))
  "Returns full string definition for message of type 'RegisterObject-response"
  (cl:format cl:nil "~%# succes flag~%byte success~%~%# successfully registered~%byte SUCCESS=0~%~%# object already registered~%byte EXISTS=1~%~%# could not query required information for this object~%byte ERROR_INFO=2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RegisterObject-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RegisterObject-response>))
  "Converts a ROS message object to a list"
  (cl:list 'RegisterObject-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'RegisterObject)))
  'RegisterObject-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'RegisterObject)))
  'RegisterObject-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RegisterObject)))
  "Returns string type for a service object of type '<RegisterObject>"
  "object_msgs/RegisterObject")