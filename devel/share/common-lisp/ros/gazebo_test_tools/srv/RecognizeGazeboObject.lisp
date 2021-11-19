; Auto-generated. Do not edit!


(cl:in-package gazebo_test_tools-srv)


;//! \htmlinclude RecognizeGazeboObject-request.msg.html

(cl:defclass <RecognizeGazeboObject-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (republish
    :reader republish
    :initarg :republish
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass RecognizeGazeboObject-request (<RecognizeGazeboObject-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RecognizeGazeboObject-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RecognizeGazeboObject-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gazebo_test_tools-srv:<RecognizeGazeboObject-request> is deprecated: use gazebo_test_tools-srv:RecognizeGazeboObject-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <RecognizeGazeboObject-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_test_tools-srv:name-val is deprecated.  Use gazebo_test_tools-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'republish-val :lambda-list '(m))
(cl:defmethod republish-val ((m <RecognizeGazeboObject-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_test_tools-srv:republish-val is deprecated.  Use gazebo_test_tools-srv:republish instead.")
  (republish m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RecognizeGazeboObject-request>) ostream)
  "Serializes a message object of type '<RecognizeGazeboObject-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'republish) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RecognizeGazeboObject-request>) istream)
  "Deserializes a message object of type '<RecognizeGazeboObject-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'republish) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RecognizeGazeboObject-request>)))
  "Returns string type for a service object of type '<RecognizeGazeboObject-request>"
  "gazebo_test_tools/RecognizeGazeboObjectRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RecognizeGazeboObject-request)))
  "Returns string type for a service object of type 'RecognizeGazeboObject-request"
  "gazebo_test_tools/RecognizeGazeboObjectRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RecognizeGazeboObject-request>)))
  "Returns md5sum for a message object of type '<RecognizeGazeboObject-request>"
  "c151db741a1313b78299ced3566a6a06")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RecognizeGazeboObject-request)))
  "Returns md5sum for a message object of type 'RecognizeGazeboObject-request"
  "c151db741a1313b78299ced3566a6a06")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RecognizeGazeboObject-request>)))
  "Returns full string definition for message of type '<RecognizeGazeboObject-request>"
  (cl:format cl:nil "# name of the object in Gazebo which is to be detected~%# and published as object_msgs/Object.msg~%string name~%~%# If true, continuously re-publish the current~%# state of the object (continuously \"re-recognize\").~%# If false, and the object was previously set to~%# republish, this will stop the re-publishing.~%bool republish~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RecognizeGazeboObject-request)))
  "Returns full string definition for message of type 'RecognizeGazeboObject-request"
  (cl:format cl:nil "# name of the object in Gazebo which is to be detected~%# and published as object_msgs/Object.msg~%string name~%~%# If true, continuously re-publish the current~%# state of the object (continuously \"re-recognize\").~%# If false, and the object was previously set to~%# republish, this will stop the re-publishing.~%bool republish~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RecognizeGazeboObject-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RecognizeGazeboObject-request>))
  "Converts a ROS message object to a list"
  (cl:list 'RecognizeGazeboObject-request
    (cl:cons ':name (name msg))
    (cl:cons ':republish (republish msg))
))
;//! \htmlinclude RecognizeGazeboObject-response.msg.html

(cl:defclass <RecognizeGazeboObject-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass RecognizeGazeboObject-response (<RecognizeGazeboObject-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RecognizeGazeboObject-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RecognizeGazeboObject-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gazebo_test_tools-srv:<RecognizeGazeboObject-response> is deprecated: use gazebo_test_tools-srv:RecognizeGazeboObject-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <RecognizeGazeboObject-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_test_tools-srv:success-val is deprecated.  Use gazebo_test_tools-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RecognizeGazeboObject-response>) ostream)
  "Serializes a message object of type '<RecognizeGazeboObject-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RecognizeGazeboObject-response>) istream)
  "Deserializes a message object of type '<RecognizeGazeboObject-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RecognizeGazeboObject-response>)))
  "Returns string type for a service object of type '<RecognizeGazeboObject-response>"
  "gazebo_test_tools/RecognizeGazeboObjectResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RecognizeGazeboObject-response)))
  "Returns string type for a service object of type 'RecognizeGazeboObject-response"
  "gazebo_test_tools/RecognizeGazeboObjectResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RecognizeGazeboObject-response>)))
  "Returns md5sum for a message object of type '<RecognizeGazeboObject-response>"
  "c151db741a1313b78299ced3566a6a06")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RecognizeGazeboObject-response)))
  "Returns md5sum for a message object of type 'RecognizeGazeboObject-response"
  "c151db741a1313b78299ced3566a6a06")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RecognizeGazeboObject-response>)))
  "Returns full string definition for message of type '<RecognizeGazeboObject-response>"
  (cl:format cl:nil "~%# If true, found the object in Gazebo and published the message.~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RecognizeGazeboObject-response)))
  "Returns full string definition for message of type 'RecognizeGazeboObject-response"
  (cl:format cl:nil "~%# If true, found the object in Gazebo and published the message.~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RecognizeGazeboObject-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RecognizeGazeboObject-response>))
  "Converts a ROS message object to a list"
  (cl:list 'RecognizeGazeboObject-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'RecognizeGazeboObject)))
  'RecognizeGazeboObject-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'RecognizeGazeboObject)))
  'RecognizeGazeboObject-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RecognizeGazeboObject)))
  "Returns string type for a service object of type '<RecognizeGazeboObject>"
  "gazebo_test_tools/RecognizeGazeboObject")