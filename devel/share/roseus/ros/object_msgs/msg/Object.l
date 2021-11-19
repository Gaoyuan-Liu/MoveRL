;; Auto-generated. Do not edit!


(when (boundp 'object_msgs::Object)
  (if (not (find-package "OBJECT_MSGS"))
    (make-package "OBJECT_MSGS"))
  (shadow 'Object (find-package "OBJECT_MSGS")))
(unless (find-package "OBJECT_MSGS::OBJECT")
  (make-package "OBJECT_MSGS::OBJECT"))

(in-package "ROS")
;;//! \htmlinclude Object.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "OBJECT_RECOGNITION_MSGS"))
  (ros::roseus-add-msgs "object_recognition_msgs"))
(if (not (find-package "SHAPE_MSGS"))
  (ros::roseus-add-msgs "shape_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*SHAPE*" (find-package "OBJECT_MSGS::OBJECT"))
(shadow '*SHAPE* (find-package "OBJECT_MSGS::OBJECT"))
(defconstant object_msgs::Object::*SHAPE* 0)
(intern "*POSE*" (find-package "OBJECT_MSGS::OBJECT"))
(shadow '*POSE* (find-package "OBJECT_MSGS::OBJECT"))
(defconstant object_msgs::Object::*POSE* 1)
(intern "*ORIGIN_AVERAGE*" (find-package "OBJECT_MSGS::OBJECT"))
(shadow '*ORIGIN_AVERAGE* (find-package "OBJECT_MSGS::OBJECT"))
(defconstant object_msgs::Object::*ORIGIN_AVERAGE* -1)
(intern "*ORIGIN_UNDEFINED*" (find-package "OBJECT_MSGS::OBJECT"))
(shadow '*ORIGIN_UNDEFINED* (find-package "OBJECT_MSGS::OBJECT"))
(defconstant object_msgs::Object::*ORIGIN_UNDEFINED* -2)
(intern "*ORIGIN_CUSTOM*" (find-package "OBJECT_MSGS::OBJECT"))
(shadow '*ORIGIN_CUSTOM* (find-package "OBJECT_MSGS::OBJECT"))
(defconstant object_msgs::Object::*ORIGIN_CUSTOM* -3)

(defun object_msgs::Object-to-symbol (const)
  (cond
        ((= const 0) 'object_msgs::Object::*SHAPE*)
        ((= const 1) 'object_msgs::Object::*POSE*)
        ((= const -1) 'object_msgs::Object::*ORIGIN_AVERAGE*)
        ((= const -2) 'object_msgs::Object::*ORIGIN_UNDEFINED*)
        ((= const -3) 'object_msgs::Object::*ORIGIN_CUSTOM*)
        (t nil)))

(defclass object_msgs::Object
  :super ros::object
  :slots (_header _name _type _primitives _primitive_poses _meshes _mesh_poses _planes _plane_poses _primitive_origin _mesh_origin _origin _content ))

(defmethod object_msgs::Object
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:name __name) "")
    ((:type __type) (instance object_recognition_msgs::ObjectType :init))
    ((:primitives __primitives) ())
    ((:primitive_poses __primitive_poses) ())
    ((:meshes __meshes) ())
    ((:mesh_poses __mesh_poses) ())
    ((:planes __planes) ())
    ((:plane_poses __plane_poses) ())
    ((:primitive_origin __primitive_origin) 0)
    ((:mesh_origin __mesh_origin) 0)
    ((:origin __origin) (instance geometry_msgs::Pose :init))
    ((:content __content) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _name (string __name))
   (setq _type __type)
   (setq _primitives __primitives)
   (setq _primitive_poses __primitive_poses)
   (setq _meshes __meshes)
   (setq _mesh_poses __mesh_poses)
   (setq _planes __planes)
   (setq _plane_poses __plane_poses)
   (setq _primitive_origin (round __primitive_origin))
   (setq _mesh_origin (round __mesh_origin))
   (setq _origin __origin)
   (setq _content (round __content))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:type
   (&rest __type)
   (if (keywordp (car __type))
       (send* _type __type)
     (progn
       (if __type (setq _type (car __type)))
       _type)))
  (:primitives
   (&rest __primitives)
   (if (keywordp (car __primitives))
       (send* _primitives __primitives)
     (progn
       (if __primitives (setq _primitives (car __primitives)))
       _primitives)))
  (:primitive_poses
   (&rest __primitive_poses)
   (if (keywordp (car __primitive_poses))
       (send* _primitive_poses __primitive_poses)
     (progn
       (if __primitive_poses (setq _primitive_poses (car __primitive_poses)))
       _primitive_poses)))
  (:meshes
   (&rest __meshes)
   (if (keywordp (car __meshes))
       (send* _meshes __meshes)
     (progn
       (if __meshes (setq _meshes (car __meshes)))
       _meshes)))
  (:mesh_poses
   (&rest __mesh_poses)
   (if (keywordp (car __mesh_poses))
       (send* _mesh_poses __mesh_poses)
     (progn
       (if __mesh_poses (setq _mesh_poses (car __mesh_poses)))
       _mesh_poses)))
  (:planes
   (&rest __planes)
   (if (keywordp (car __planes))
       (send* _planes __planes)
     (progn
       (if __planes (setq _planes (car __planes)))
       _planes)))
  (:plane_poses
   (&rest __plane_poses)
   (if (keywordp (car __plane_poses))
       (send* _plane_poses __plane_poses)
     (progn
       (if __plane_poses (setq _plane_poses (car __plane_poses)))
       _plane_poses)))
  (:primitive_origin
   (&optional __primitive_origin)
   (if __primitive_origin (setq _primitive_origin __primitive_origin)) _primitive_origin)
  (:mesh_origin
   (&optional __mesh_origin)
   (if __mesh_origin (setq _mesh_origin __mesh_origin)) _mesh_origin)
  (:origin
   (&rest __origin)
   (if (keywordp (car __origin))
       (send* _origin __origin)
     (progn
       (if __origin (setq _origin (car __origin)))
       _origin)))
  (:content
   (&optional __content)
   (if __content (setq _content __content)) _content)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _name
    4 (length _name)
    ;; object_recognition_msgs/ObjectType _type
    (send _type :serialization-length)
    ;; shape_msgs/SolidPrimitive[] _primitives
    (apply #'+ (send-all _primitives :serialization-length)) 4
    ;; geometry_msgs/Pose[] _primitive_poses
    (apply #'+ (send-all _primitive_poses :serialization-length)) 4
    ;; shape_msgs/Mesh[] _meshes
    (apply #'+ (send-all _meshes :serialization-length)) 4
    ;; geometry_msgs/Pose[] _mesh_poses
    (apply #'+ (send-all _mesh_poses :serialization-length)) 4
    ;; shape_msgs/Plane[] _planes
    (apply #'+ (send-all _planes :serialization-length)) 4
    ;; geometry_msgs/Pose[] _plane_poses
    (apply #'+ (send-all _plane_poses :serialization-length)) 4
    ;; int32 _primitive_origin
    4
    ;; int32 _mesh_origin
    4
    ;; geometry_msgs/Pose _origin
    (send _origin :serialization-length)
    ;; byte _content
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; object_recognition_msgs/ObjectType _type
       (send _type :serialize s)
     ;; shape_msgs/SolidPrimitive[] _primitives
     (write-long (length _primitives) s)
     (dolist (elem _primitives)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Pose[] _primitive_poses
     (write-long (length _primitive_poses) s)
     (dolist (elem _primitive_poses)
       (send elem :serialize s)
       )
     ;; shape_msgs/Mesh[] _meshes
     (write-long (length _meshes) s)
     (dolist (elem _meshes)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Pose[] _mesh_poses
     (write-long (length _mesh_poses) s)
     (dolist (elem _mesh_poses)
       (send elem :serialize s)
       )
     ;; shape_msgs/Plane[] _planes
     (write-long (length _planes) s)
     (dolist (elem _planes)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Pose[] _plane_poses
     (write-long (length _plane_poses) s)
     (dolist (elem _plane_poses)
       (send elem :serialize s)
       )
     ;; int32 _primitive_origin
       (write-long _primitive_origin s)
     ;; int32 _mesh_origin
       (write-long _mesh_origin s)
     ;; geometry_msgs/Pose _origin
       (send _origin :serialize s)
     ;; byte _content
       (write-byte _content s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; object_recognition_msgs/ObjectType _type
     (send _type :deserialize buf ptr-) (incf ptr- (send _type :serialization-length))
   ;; shape_msgs/SolidPrimitive[] _primitives
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _primitives (let (r) (dotimes (i n) (push (instance shape_msgs::SolidPrimitive :init) r)) r))
     (dolist (elem- _primitives)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Pose[] _primitive_poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _primitive_poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _primitive_poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; shape_msgs/Mesh[] _meshes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _meshes (let (r) (dotimes (i n) (push (instance shape_msgs::Mesh :init) r)) r))
     (dolist (elem- _meshes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Pose[] _mesh_poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _mesh_poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _mesh_poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; shape_msgs/Plane[] _planes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _planes (let (r) (dotimes (i n) (push (instance shape_msgs::Plane :init) r)) r))
     (dolist (elem- _planes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Pose[] _plane_poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _plane_poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _plane_poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int32 _primitive_origin
     (setq _primitive_origin (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _mesh_origin
     (setq _mesh_origin (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Pose _origin
     (send _origin :deserialize buf ptr-) (incf ptr- (send _origin :serialization-length))
   ;; byte _content
     (setq _content (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _content 127) (setq _content (- _content 256)))
   ;;
   self)
  )

(setf (get object_msgs::Object :md5sum-) "59a4dbed61a3869d90b7226cdd261082")
(setf (get object_msgs::Object :datatype-) "object_msgs/Object")
(setf (get object_msgs::Object :definition-)
      "# a header, used for interpreting the poses
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



(provide :object_msgs/Object "59a4dbed61a3869d90b7226cdd261082")


