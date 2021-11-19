;; Auto-generated. Do not edit!


(when (boundp 'object_msgs::ObjectInfo)
  (if (not (find-package "OBJECT_MSGS"))
    (make-package "OBJECT_MSGS"))
  (shadow 'ObjectInfo (find-package "OBJECT_MSGS")))
(unless (find-package "OBJECT_MSGS::OBJECTINFO")
  (make-package "OBJECT_MSGS::OBJECTINFO"))
(unless (find-package "OBJECT_MSGS::OBJECTINFOREQUEST")
  (make-package "OBJECT_MSGS::OBJECTINFOREQUEST"))
(unless (find-package "OBJECT_MSGS::OBJECTINFORESPONSE")
  (make-package "OBJECT_MSGS::OBJECTINFORESPONSE"))

(in-package "ROS")





(defclass object_msgs::ObjectInfoRequest
  :super ros::object
  :slots (_name _get_geometry ))

(defmethod object_msgs::ObjectInfoRequest
  (:init
   (&key
    ((:name __name) "")
    ((:get_geometry __get_geometry) nil)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _get_geometry __get_geometry)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:get_geometry
   (&optional (__get_geometry :null))
   (if (not (eq __get_geometry :null)) (setq _get_geometry __get_geometry)) _get_geometry)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; bool _get_geometry
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _get_geometry
       (if _get_geometry (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _get_geometry
     (setq _get_geometry (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(intern "*NO_ERROR*" (find-package "OBJECT_MSGS::OBJECTINFORESPONSE"))
(shadow '*NO_ERROR* (find-package "OBJECT_MSGS::OBJECTINFORESPONSE"))
(defconstant object_msgs::ObjectInfoResponse::*NO_ERROR* 0)
(intern "*OBJECT_NOT_FOUND*" (find-package "OBJECT_MSGS::OBJECTINFORESPONSE"))
(shadow '*OBJECT_NOT_FOUND* (find-package "OBJECT_MSGS::OBJECTINFORESPONSE"))
(defconstant object_msgs::ObjectInfoResponse::*OBJECT_NOT_FOUND* 1)
(intern "*OTHER_ERROR*" (find-package "OBJECT_MSGS::OBJECTINFORESPONSE"))
(shadow '*OTHER_ERROR* (find-package "OBJECT_MSGS::OBJECTINFORESPONSE"))
(defconstant object_msgs::ObjectInfoResponse::*OTHER_ERROR* 2)

(defun object_msgs::ObjectInfoResponse-to-symbol (const)
  (cond
        ((= const 0) 'object_msgs::ObjectInfoResponse::*NO_ERROR*)
        ((= const 1) 'object_msgs::ObjectInfoResponse::*OBJECT_NOT_FOUND*)
        ((= const 2) 'object_msgs::ObjectInfoResponse::*OTHER_ERROR*)
        (t nil)))

(defclass object_msgs::ObjectInfoResponse
  :super ros::object
  :slots (_success _object _error_code ))

(defmethod object_msgs::ObjectInfoResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:object __object) (instance object_msgs::Object :init))
    ((:error_code __error_code) 0)
    )
   (send-super :init)
   (setq _success __success)
   (setq _object __object)
   (setq _error_code (round __error_code))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:object
   (&rest __object)
   (if (keywordp (car __object))
       (send* _object __object)
     (progn
       (if __object (setq _object (car __object)))
       _object)))
  (:error_code
   (&optional __error_code)
   (if __error_code (setq _error_code __error_code)) _error_code)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; object_msgs/Object _object
    (send _object :serialization-length)
    ;; byte _error_code
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; object_msgs/Object _object
       (send _object :serialize s)
     ;; byte _error_code
       (write-byte _error_code s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; object_msgs/Object _object
     (send _object :deserialize buf ptr-) (incf ptr- (send _object :serialization-length))
   ;; byte _error_code
     (setq _error_code (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _error_code 127) (setq _error_code (- _error_code 256)))
   ;;
   self)
  )

(defclass object_msgs::ObjectInfo
  :super ros::object
  :slots ())

(setf (get object_msgs::ObjectInfo :md5sum-) "914392dfee158e8d82269f3dc686d92b")
(setf (get object_msgs::ObjectInfo :datatype-) "object_msgs/ObjectInfo")
(setf (get object_msgs::ObjectInfo :request) object_msgs::ObjectInfoRequest)
(setf (get object_msgs::ObjectInfo :response) object_msgs::ObjectInfoResponse)

(defmethod object_msgs::ObjectInfoRequest
  (:response () (instance object_msgs::ObjectInfoResponse :init)))

(setf (get object_msgs::ObjectInfoRequest :md5sum-) "914392dfee158e8d82269f3dc686d92b")
(setf (get object_msgs::ObjectInfoRequest :datatype-) "object_msgs/ObjectInfoRequest")
(setf (get object_msgs::ObjectInfoRequest :definition-)
      "# name of the object whose information is requested
string name

# set to true if the Geometry should be returned
# with the Object as well. If false, then only
# the current object pose fields are returned
bool get_geometry

---

# true if object exists and information is
# stored in field 'object'. If false, the
# error_code contains more information about the error.
bool success

# information about the object
Object object

# error code if success is false
byte error_code

byte NO_ERROR=0
byte OBJECT_NOT_FOUND=1
byte OTHER_ERROR=2


================================================================================
MSG: object_msgs/Object
# a header, used for interpreting the poses
Header header

# the name of the object. This should usually
# coincide with the /tf frame of the base/origin
# of the object, though this is no mandatory
# requirement.
string name

# If known: The object type in a database of known objects
object_recognition_msgs/ObjectType type

# If the model is made up of primitives:
# Solid geometric primitives
shape_msgs/SolidPrimitive[] primitives
geometry_msgs/Pose[] primitive_poses

# If the model is made up of meshes:
# The model meshes
shape_msgs/Mesh[] meshes
geometry_msgs/Pose[] mesh_poses

# If known: bounding plane
shape_msgs/Plane[] planes
geometry_msgs/Pose[] plane_poses

# Index into the primitive_poses to the
# pose which is considered to be the
# object's root / origin. Can also be
# set to constants ORIGIN_AVERAGE,
# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.
int32 primitive_origin

# Index into the mesh_poses to the
# pose which is considered to be the
# object's root / origin. Can also be
# set to constants ORIGIN_AVERAGE,
# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.
int32 mesh_origin

# If 'mesh_origin' or 'primitive_origin'
# are set to ORIGIN_CUSTOM, this field
# contains the origin of the overall object.
geometry_msgs/Pose origin

# Information in the message, either SHAPE or POSE
byte content

# For field 'content':
# Message contains the shape(s) of the object including poses
byte SHAPE=0

# For field 'content':
# Message contains only the pose of the primitives,
# i.e. only *_poses will be with values.
byte POSE=1

# For fields 'mesh_origin' and 'primitives_origin':
# the root/origin of the object is the
# average of all poses.
# Because the average of several quaternions
# can only be determined approximately when
# the quaternions are close together, this
# setting requires at least the orientation part
# of the field 'origin' to be set in addition.
int32 ORIGIN_AVERAGE=-1

# For fields 'mesh_origin' and 'primitives_origin':
# The origin of the object cannot be defined by this
# set of poses.
int32 ORIGIN_UNDEFINED=-2

# For fields 'mesh_origin' and 'primitives_origin':
# The origin is given in the custom field 'origin' 
int32 ORIGIN_CUSTOM=-3

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: object_recognition_msgs/ObjectType
################################################## OBJECT ID #########################################################

# Contains information about the type of a found object. Those two sets of parameters together uniquely define an
# object

# The key of the found object: the unique identifier in the given db
string key

# The db parameters stored as a JSON/compressed YAML string. An object id does not make sense without the corresponding
# database. E.g., in object_recognition, it can look like: \"{'type':'CouchDB', 'root':'http://localhost'}\"
# There is no conventional format for those parameters and it's nice to keep that flexibility.
# The object_recognition_core as a generic DB type that can read those fields
# Current examples:
# For CouchDB:
#   type: 'CouchDB'
#   root: 'http://localhost:5984'
#   collection: 'object_recognition'
# For SQL household database:
#   type: 'SqlHousehold'
#   host: 'wgs36'
#   port: 5432
#   user: 'willow'
#   password: 'willow'
#   name: 'household_objects'
#   module: 'tabletop'
string db

================================================================================
MSG: shape_msgs/SolidPrimitive
# Define box, sphere, cylinder, cone 
# All shapes are defined to have their bounding boxes centered around 0,0,0.

uint8 BOX=1
uint8 SPHERE=2
uint8 CYLINDER=3
uint8 CONE=4

# The type of the shape
uint8 type


# The dimensions of the shape
float64[] dimensions

# The meaning of the shape dimensions: each constant defines the index in the 'dimensions' array

# For the BOX type, the X, Y, and Z dimensions are the length of the corresponding
# sides of the box.
uint8 BOX_X=0
uint8 BOX_Y=1
uint8 BOX_Z=2


# For the SPHERE type, only one component is used, and it gives the radius of
# the sphere.
uint8 SPHERE_RADIUS=0


# For the CYLINDER and CONE types, the center line is oriented along
# the Z axis.  Therefore the CYLINDER_HEIGHT (CONE_HEIGHT) component
# of dimensions gives the height of the cylinder (cone).  The
# CYLINDER_RADIUS (CONE_RADIUS) component of dimensions gives the
# radius of the base of the cylinder (cone).  Cone and cylinder
# primitives are defined to be circular. The tip of the cone is
# pointing up, along +Z axis.

uint8 CYLINDER_HEIGHT=0
uint8 CYLINDER_RADIUS=1

uint8 CONE_HEIGHT=0
uint8 CONE_RADIUS=1

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: shape_msgs/Mesh
# Definition of a mesh

# list of triangles; the index values refer to positions in vertices[]
MeshTriangle[] triangles

# the actual vertices that make up the mesh
geometry_msgs/Point[] vertices

================================================================================
MSG: shape_msgs/MeshTriangle
# Definition of a triangle's vertices
uint32[3] vertex_indices

================================================================================
MSG: shape_msgs/Plane
# Representation of a plane, using the plane equation ax + by + cz + d = 0

# a := coef[0]
# b := coef[1]
# c := coef[2]
# d := coef[3]

float64[4] coef
")

(setf (get object_msgs::ObjectInfoResponse :md5sum-) "914392dfee158e8d82269f3dc686d92b")
(setf (get object_msgs::ObjectInfoResponse :datatype-) "object_msgs/ObjectInfoResponse")
(setf (get object_msgs::ObjectInfoResponse :definition-)
      "# name of the object whose information is requested
string name

# set to true if the Geometry should be returned
# with the Object as well. If false, then only
# the current object pose fields are returned
bool get_geometry

---

# true if object exists and information is
# stored in field 'object'. If false, the
# error_code contains more information about the error.
bool success

# information about the object
Object object

# error code if success is false
byte error_code

byte NO_ERROR=0
byte OBJECT_NOT_FOUND=1
byte OTHER_ERROR=2


================================================================================
MSG: object_msgs/Object
# a header, used for interpreting the poses
Header header

# the name of the object. This should usually
# coincide with the /tf frame of the base/origin
# of the object, though this is no mandatory
# requirement.
string name

# If known: The object type in a database of known objects
object_recognition_msgs/ObjectType type

# If the model is made up of primitives:
# Solid geometric primitives
shape_msgs/SolidPrimitive[] primitives
geometry_msgs/Pose[] primitive_poses

# If the model is made up of meshes:
# The model meshes
shape_msgs/Mesh[] meshes
geometry_msgs/Pose[] mesh_poses

# If known: bounding plane
shape_msgs/Plane[] planes
geometry_msgs/Pose[] plane_poses

# Index into the primitive_poses to the
# pose which is considered to be the
# object's root / origin. Can also be
# set to constants ORIGIN_AVERAGE,
# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.
int32 primitive_origin

# Index into the mesh_poses to the
# pose which is considered to be the
# object's root / origin. Can also be
# set to constants ORIGIN_AVERAGE,
# ORIGIN_UNDEFINED or ORIGIN_CUSTOM.
int32 mesh_origin

# If 'mesh_origin' or 'primitive_origin'
# are set to ORIGIN_CUSTOM, this field
# contains the origin of the overall object.
geometry_msgs/Pose origin

# Information in the message, either SHAPE or POSE
byte content

# For field 'content':
# Message contains the shape(s) of the object including poses
byte SHAPE=0

# For field 'content':
# Message contains only the pose of the primitives,
# i.e. only *_poses will be with values.
byte POSE=1

# For fields 'mesh_origin' and 'primitives_origin':
# the root/origin of the object is the
# average of all poses.
# Because the average of several quaternions
# can only be determined approximately when
# the quaternions are close together, this
# setting requires at least the orientation part
# of the field 'origin' to be set in addition.
int32 ORIGIN_AVERAGE=-1

# For fields 'mesh_origin' and 'primitives_origin':
# The origin of the object cannot be defined by this
# set of poses.
int32 ORIGIN_UNDEFINED=-2

# For fields 'mesh_origin' and 'primitives_origin':
# The origin is given in the custom field 'origin' 
int32 ORIGIN_CUSTOM=-3

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: object_recognition_msgs/ObjectType
################################################## OBJECT ID #########################################################

# Contains information about the type of a found object. Those two sets of parameters together uniquely define an
# object

# The key of the found object: the unique identifier in the given db
string key

# The db parameters stored as a JSON/compressed YAML string. An object id does not make sense without the corresponding
# database. E.g., in object_recognition, it can look like: \"{'type':'CouchDB', 'root':'http://localhost'}\"
# There is no conventional format for those parameters and it's nice to keep that flexibility.
# The object_recognition_core as a generic DB type that can read those fields
# Current examples:
# For CouchDB:
#   type: 'CouchDB'
#   root: 'http://localhost:5984'
#   collection: 'object_recognition'
# For SQL household database:
#   type: 'SqlHousehold'
#   host: 'wgs36'
#   port: 5432
#   user: 'willow'
#   password: 'willow'
#   name: 'household_objects'
#   module: 'tabletop'
string db

================================================================================
MSG: shape_msgs/SolidPrimitive
# Define box, sphere, cylinder, cone 
# All shapes are defined to have their bounding boxes centered around 0,0,0.

uint8 BOX=1
uint8 SPHERE=2
uint8 CYLINDER=3
uint8 CONE=4

# The type of the shape
uint8 type


# The dimensions of the shape
float64[] dimensions

# The meaning of the shape dimensions: each constant defines the index in the 'dimensions' array

# For the BOX type, the X, Y, and Z dimensions are the length of the corresponding
# sides of the box.
uint8 BOX_X=0
uint8 BOX_Y=1
uint8 BOX_Z=2


# For the SPHERE type, only one component is used, and it gives the radius of
# the sphere.
uint8 SPHERE_RADIUS=0


# For the CYLINDER and CONE types, the center line is oriented along
# the Z axis.  Therefore the CYLINDER_HEIGHT (CONE_HEIGHT) component
# of dimensions gives the height of the cylinder (cone).  The
# CYLINDER_RADIUS (CONE_RADIUS) component of dimensions gives the
# radius of the base of the cylinder (cone).  Cone and cylinder
# primitives are defined to be circular. The tip of the cone is
# pointing up, along +Z axis.

uint8 CYLINDER_HEIGHT=0
uint8 CYLINDER_RADIUS=1

uint8 CONE_HEIGHT=0
uint8 CONE_RADIUS=1

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: shape_msgs/Mesh
# Definition of a mesh

# list of triangles; the index values refer to positions in vertices[]
MeshTriangle[] triangles

# the actual vertices that make up the mesh
geometry_msgs/Point[] vertices

================================================================================
MSG: shape_msgs/MeshTriangle
# Definition of a triangle's vertices
uint32[3] vertex_indices

================================================================================
MSG: shape_msgs/Plane
# Representation of a plane, using the plane equation ax + by + cz + d = 0

# a := coef[0]
# b := coef[1]
# c := coef[2]
# d := coef[3]

float64[4] coef
")



(provide :object_msgs/ObjectInfo "914392dfee158e8d82269f3dc686d92b")


