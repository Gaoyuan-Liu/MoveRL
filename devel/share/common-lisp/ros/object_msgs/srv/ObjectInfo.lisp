; Auto-generated. Do not edit!


(cl:in-package object_msgs-srv)


;//! \htmlinclude ObjectInfo-request.msg.html

(cl:defclass <ObjectInfo-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (get_geometry
    :reader get_geometry
    :initarg :get_geometry
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ObjectInfo-request (<ObjectInfo-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectInfo-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectInfo-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name object_msgs-srv:<ObjectInfo-request> is deprecated: use object_msgs-srv:ObjectInfo-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <ObjectInfo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader object_msgs-srv:name-val is deprecated.  Use object_msgs-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'get_geometry-val :lambda-list '(m))
(cl:defmethod get_geometry-val ((m <ObjectInfo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader object_msgs-srv:get_geometry-val is deprecated.  Use object_msgs-srv:get_geometry instead.")
  (get_geometry m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectInfo-request>) ostream)
  "Serializes a message object of type '<ObjectInfo-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'get_geometry) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectInfo-request>) istream)
  "Deserializes a message object of type '<ObjectInfo-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'get_geometry) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectInfo-request>)))
  "Returns string type for a service object of type '<ObjectInfo-request>"
  "object_msgs/ObjectInfoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectInfo-request)))
  "Returns string type for a service object of type 'ObjectInfo-request"
  "object_msgs/ObjectInfoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectInfo-request>)))
  "Returns md5sum for a message object of type '<ObjectInfo-request>"
  "914392dfee158e8d82269f3dc686d92b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectInfo-request)))
  "Returns md5sum for a message object of type 'ObjectInfo-request"
  "914392dfee158e8d82269f3dc686d92b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectInfo-request>)))
  "Returns full string definition for message of type '<ObjectInfo-request>"
  (cl:format cl:nil "# name of the object whose information is requested~%string name~%~%# set to true if the Geometry should be returned~%# with the Object as well. If false, then only~%# the current object pose fields are returned~%bool get_geometry~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectInfo-request)))
  "Returns full string definition for message of type 'ObjectInfo-request"
  (cl:format cl:nil "# name of the object whose information is requested~%string name~%~%# set to true if the Geometry should be returned~%# with the Object as well. If false, then only~%# the current object pose fields are returned~%bool get_geometry~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectInfo-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectInfo-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectInfo-request
    (cl:cons ':name (name msg))
    (cl:cons ':get_geometry (get_geometry msg))
))
;//! \htmlinclude ObjectInfo-response.msg.html

(cl:defclass <ObjectInfo-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (object
    :reader object
    :initarg :object
    :type object_msgs-msg:Object
    :initform (cl:make-instance 'object_msgs-msg:Object))
   (error_code
    :reader error_code
    :initarg :error_code
    :type cl:integer
    :initform 0))
)

(cl:defclass ObjectInfo-response (<ObjectInfo-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectInfo-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectInfo-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name object_msgs-srv:<ObjectInfo-response> is deprecated: use object_msgs-srv:ObjectInfo-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ObjectInfo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader object_msgs-srv:success-val is deprecated.  Use object_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'object-val :lambda-list '(m))
(cl:defmethod object-val ((m <ObjectInfo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader object_msgs-srv:object-val is deprecated.  Use object_msgs-srv:object instead.")
  (object m))

(cl:ensure-generic-function 'error_code-val :lambda-list '(m))
(cl:defmethod error_code-val ((m <ObjectInfo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader object_msgs-srv:error_code-val is deprecated.  Use object_msgs-srv:error_code instead.")
  (error_code m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ObjectInfo-response>)))
    "Constants for message type '<ObjectInfo-response>"
  '((:NO_ERROR . 0)
    (:OBJECT_NOT_FOUND . 1)
    (:OTHER_ERROR . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ObjectInfo-response)))
    "Constants for message type 'ObjectInfo-response"
  '((:NO_ERROR . 0)
    (:OBJECT_NOT_FOUND . 1)
    (:OTHER_ERROR . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectInfo-response>) ostream)
  "Serializes a message object of type '<ObjectInfo-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'object) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error_code)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectInfo-response>) istream)
  "Deserializes a message object of type '<ObjectInfo-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'object) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error_code)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectInfo-response>)))
  "Returns string type for a service object of type '<ObjectInfo-response>"
  "object_msgs/ObjectInfoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectInfo-response)))
  "Returns string type for a service object of type 'ObjectInfo-response"
  "object_msgs/ObjectInfoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectInfo-response>)))
  "Returns md5sum for a message object of type '<ObjectInfo-response>"
  "914392dfee158e8d82269f3dc686d92b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectInfo-response)))
  "Returns md5sum for a message object of type 'ObjectInfo-response"
  "914392dfee158e8d82269f3dc686d92b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectInfo-response>)))
  "Returns full string definition for message of type '<ObjectInfo-response>"
  (cl:format cl:nil "~%# true if object exists and information is~%# stored in field 'object'. If false, the~%# error_code contains more information about the error.~%bool success~%~%# information about the object~%Object object~%~%# error code if success is false~%byte error_code~%~%byte NO_ERROR=0~%byte OBJECT_NOT_FOUND=1~%byte OTHER_ERROR=2~%~%~%================================================================================~%MSG: object_msgs/Object~%# a header, used for interpreting the poses~%Header header~%~%# the name of the object. This should usually~%# coincide with the /tf frame of the base/origin~%# of the object, though this is no mandatory~%# requirement.~%string name~%~%# If known: The object type in a database of known objects~%object_recognition_msgs/ObjectType type~%~%# If the model is made up of primitives:~%# Solid geometric primitives~%shape_msgs/SolidPrimitive[] primitives~%geometry_msgs/Pose[] primitive_poses~%~%# If the model is made up of meshes:~%# The model meshes~%shape_msgs/Mesh[] meshes~%geometry_msgs/Pose[] mesh_poses~%~%# If known: bounding plane~%shape_msgs/Plane[] planes~%geometry_msgs/Pose[] plane_poses~%~%# Index into the primitive_poses to the~%# pose which is considered to be the~%# object's root / origin. Can also be~%# set to constants ORIGIN_AVERAGE,~%# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.~%int32 primitive_origin~%~%# Index into the mesh_poses to the~%# pose which is considered to be the~%# object's root / origin. Can also be~%# set to constants ORIGIN_AVERAGE,~%# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.~%int32 mesh_origin~%~%# If 'mesh_origin' or 'primitive_origin'~%# are set to ORIGIN_CUSTOM, this field~%# contains the origin of the overall object.~%geometry_msgs/Pose origin~%~%# Information in the message, either SHAPE or POSE~%byte content~%~%# For field 'content':~%# Message contains the shape(s) of the object including poses~%byte SHAPE=0~%~%# For field 'content':~%# Message contains only the pose of the primitives,~%# i.e. only *_poses will be with values.~%byte POSE=1~%~%# For fields 'mesh_origin' and 'primitives_origin':~%# the root/origin of the object is the~%# average of all poses.~%# Because the average of several quaternions~%# can only be determined approximately when~%# the quaternions are close together, this~%# setting requires at least the orientation part~%# of the field 'origin' to be set in addition.~%int32 ORIGIN_AVERAGE=-1~%~%# For fields 'mesh_origin' and 'primitives_origin':~%# The origin of the object cannot be defined by this~%# set of poses.~%int32 ORIGIN_UNDEFINED=-2~%~%# For fields 'mesh_origin' and 'primitives_origin':~%# The origin is given in the custom field 'origin' ~%int32 ORIGIN_CUSTOM=-3~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: object_recognition_msgs/ObjectType~%################################################## OBJECT ID #########################################################~%~%# Contains information about the type of a found object. Those two sets of parameters together uniquely define an~%# object~%~%# The key of the found object: the unique identifier in the given db~%string key~%~%# The db parameters stored as a JSON/compressed YAML string. An object id does not make sense without the corresponding~%# database. E.g., in object_recognition, it can look like: \"{'type':'CouchDB', 'root':'http://localhost'}\"~%# There is no conventional format for those parameters and it's nice to keep that flexibility.~%# The object_recognition_core as a generic DB type that can read those fields~%# Current examples:~%# For CouchDB:~%#   type: 'CouchDB'~%#   root: 'http://localhost:5984'~%#   collection: 'object_recognition'~%# For SQL household database:~%#   type: 'SqlHousehold'~%#   host: 'wgs36'~%#   port: 5432~%#   user: 'willow'~%#   password: 'willow'~%#   name: 'household_objects'~%#   module: 'tabletop'~%string db~%~%================================================================================~%MSG: shape_msgs/SolidPrimitive~%# Define box, sphere, cylinder, cone ~%# All shapes are defined to have their bounding boxes centered around 0,0,0.~%~%uint8 BOX=1~%uint8 SPHERE=2~%uint8 CYLINDER=3~%uint8 CONE=4~%~%# The type of the shape~%uint8 type~%~%~%# The dimensions of the shape~%float64[] dimensions~%~%# The meaning of the shape dimensions: each constant defines the index in the 'dimensions' array~%~%# For the BOX type, the X, Y, and Z dimensions are the length of the corresponding~%# sides of the box.~%uint8 BOX_X=0~%uint8 BOX_Y=1~%uint8 BOX_Z=2~%~%~%# For the SPHERE type, only one component is used, and it gives the radius of~%# the sphere.~%uint8 SPHERE_RADIUS=0~%~%~%# For the CYLINDER and CONE types, the center line is oriented along~%# the Z axis.  Therefore the CYLINDER_HEIGHT (CONE_HEIGHT) component~%# of dimensions gives the height of the cylinder (cone).  The~%# CYLINDER_RADIUS (CONE_RADIUS) component of dimensions gives the~%# radius of the base of the cylinder (cone).  Cone and cylinder~%# primitives are defined to be circular. The tip of the cone is~%# pointing up, along +Z axis.~%~%uint8 CYLINDER_HEIGHT=0~%uint8 CYLINDER_RADIUS=1~%~%uint8 CONE_HEIGHT=0~%uint8 CONE_RADIUS=1~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: shape_msgs/Mesh~%# Definition of a mesh~%~%# list of triangles; the index values refer to positions in vertices[]~%MeshTriangle[] triangles~%~%# the actual vertices that make up the mesh~%geometry_msgs/Point[] vertices~%~%================================================================================~%MSG: shape_msgs/MeshTriangle~%# Definition of a triangle's vertices~%uint32[3] vertex_indices~%~%================================================================================~%MSG: shape_msgs/Plane~%# Representation of a plane, using the plane equation ax + by + cz + d = 0~%~%# a := coef[0]~%# b := coef[1]~%# c := coef[2]~%# d := coef[3]~%~%float64[4] coef~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectInfo-response)))
  "Returns full string definition for message of type 'ObjectInfo-response"
  (cl:format cl:nil "~%# true if object exists and information is~%# stored in field 'object'. If false, the~%# error_code contains more information about the error.~%bool success~%~%# information about the object~%Object object~%~%# error code if success is false~%byte error_code~%~%byte NO_ERROR=0~%byte OBJECT_NOT_FOUND=1~%byte OTHER_ERROR=2~%~%~%================================================================================~%MSG: object_msgs/Object~%# a header, used for interpreting the poses~%Header header~%~%# the name of the object. This should usually~%# coincide with the /tf frame of the base/origin~%# of the object, though this is no mandatory~%# requirement.~%string name~%~%# If known: The object type in a database of known objects~%object_recognition_msgs/ObjectType type~%~%# If the model is made up of primitives:~%# Solid geometric primitives~%shape_msgs/SolidPrimitive[] primitives~%geometry_msgs/Pose[] primitive_poses~%~%# If the model is made up of meshes:~%# The model meshes~%shape_msgs/Mesh[] meshes~%geometry_msgs/Pose[] mesh_poses~%~%# If known: bounding plane~%shape_msgs/Plane[] planes~%geometry_msgs/Pose[] plane_poses~%~%# Index into the primitive_poses to the~%# pose which is considered to be the~%# object's root / origin. Can also be~%# set to constants ORIGIN_AVERAGE,~%# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.~%int32 primitive_origin~%~%# Index into the mesh_poses to the~%# pose which is considered to be the~%# object's root / origin. Can also be~%# set to constants ORIGIN_AVERAGE,~%# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.~%int32 mesh_origin~%~%# If 'mesh_origin' or 'primitive_origin'~%# are set to ORIGIN_CUSTOM, this field~%# contains the origin of the overall object.~%geometry_msgs/Pose origin~%~%# Information in the message, either SHAPE or POSE~%byte content~%~%# For field 'content':~%# Message contains the shape(s) of the object including poses~%byte SHAPE=0~%~%# For field 'content':~%# Message contains only the pose of the primitives,~%# i.e. only *_poses will be with values.~%byte POSE=1~%~%# For fields 'mesh_origin' and 'primitives_origin':~%# the root/origin of the object is the~%# average of all poses.~%# Because the average of several quaternions~%# can only be determined approximately when~%# the quaternions are close together, this~%# setting requires at least the orientation part~%# of the field 'origin' to be set in addition.~%int32 ORIGIN_AVERAGE=-1~%~%# For fields 'mesh_origin' and 'primitives_origin':~%# The origin of the object cannot be defined by this~%# set of poses.~%int32 ORIGIN_UNDEFINED=-2~%~%# For fields 'mesh_origin' and 'primitives_origin':~%# The origin is given in the custom field 'origin' ~%int32 ORIGIN_CUSTOM=-3~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: object_recognition_msgs/ObjectType~%################################################## OBJECT ID #########################################################~%~%# Contains information about the type of a found object. Those two sets of parameters together uniquely define an~%# object~%~%# The key of the found object: the unique identifier in the given db~%string key~%~%# The db parameters stored as a JSON/compressed YAML string. An object id does not make sense without the corresponding~%# database. E.g., in object_recognition, it can look like: \"{'type':'CouchDB', 'root':'http://localhost'}\"~%# There is no conventional format for those parameters and it's nice to keep that flexibility.~%# The object_recognition_core as a generic DB type that can read those fields~%# Current examples:~%# For CouchDB:~%#   type: 'CouchDB'~%#   root: 'http://localhost:5984'~%#   collection: 'object_recognition'~%# For SQL household database:~%#   type: 'SqlHousehold'~%#   host: 'wgs36'~%#   port: 5432~%#   user: 'willow'~%#   password: 'willow'~%#   name: 'household_objects'~%#   module: 'tabletop'~%string db~%~%================================================================================~%MSG: shape_msgs/SolidPrimitive~%# Define box, sphere, cylinder, cone ~%# All shapes are defined to have their bounding boxes centered around 0,0,0.~%~%uint8 BOX=1~%uint8 SPHERE=2~%uint8 CYLINDER=3~%uint8 CONE=4~%~%# The type of the shape~%uint8 type~%~%~%# The dimensions of the shape~%float64[] dimensions~%~%# The meaning of the shape dimensions: each constant defines the index in the 'dimensions' array~%~%# For the BOX type, the X, Y, and Z dimensions are the length of the corresponding~%# sides of the box.~%uint8 BOX_X=0~%uint8 BOX_Y=1~%uint8 BOX_Z=2~%~%~%# For the SPHERE type, only one component is used, and it gives the radius of~%# the sphere.~%uint8 SPHERE_RADIUS=0~%~%~%# For the CYLINDER and CONE types, the center line is oriented along~%# the Z axis.  Therefore the CYLINDER_HEIGHT (CONE_HEIGHT) component~%# of dimensions gives the height of the cylinder (cone).  The~%# CYLINDER_RADIUS (CONE_RADIUS) component of dimensions gives the~%# radius of the base of the cylinder (cone).  Cone and cylinder~%# primitives are defined to be circular. The tip of the cone is~%# pointing up, along +Z axis.~%~%uint8 CYLINDER_HEIGHT=0~%uint8 CYLINDER_RADIUS=1~%~%uint8 CONE_HEIGHT=0~%uint8 CONE_RADIUS=1~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: shape_msgs/Mesh~%# Definition of a mesh~%~%# list of triangles; the index values refer to positions in vertices[]~%MeshTriangle[] triangles~%~%# the actual vertices that make up the mesh~%geometry_msgs/Point[] vertices~%~%================================================================================~%MSG: shape_msgs/MeshTriangle~%# Definition of a triangle's vertices~%uint32[3] vertex_indices~%~%================================================================================~%MSG: shape_msgs/Plane~%# Representation of a plane, using the plane equation ax + by + cz + d = 0~%~%# a := coef[0]~%# b := coef[1]~%# c := coef[2]~%# d := coef[3]~%~%float64[4] coef~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectInfo-response>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'object))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectInfo-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectInfo-response
    (cl:cons ':success (success msg))
    (cl:cons ':object (object msg))
    (cl:cons ':error_code (error_code msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ObjectInfo)))
  'ObjectInfo-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ObjectInfo)))
  'ObjectInfo-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectInfo)))
  "Returns string type for a service object of type '<ObjectInfo>"
  "object_msgs/ObjectInfo")