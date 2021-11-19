// Auto-generated. Do not edit!

// (in-package object_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');
let shape_msgs = _finder('shape_msgs');
let std_msgs = _finder('std_msgs');
let object_recognition_msgs = _finder('object_recognition_msgs');

//-----------------------------------------------------------

class Object {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.name = null;
      this.type = null;
      this.primitives = null;
      this.primitive_poses = null;
      this.meshes = null;
      this.mesh_poses = null;
      this.planes = null;
      this.plane_poses = null;
      this.primitive_origin = null;
      this.mesh_origin = null;
      this.origin = null;
      this.content = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = new object_recognition_msgs.msg.ObjectType();
      }
      if (initObj.hasOwnProperty('primitives')) {
        this.primitives = initObj.primitives
      }
      else {
        this.primitives = [];
      }
      if (initObj.hasOwnProperty('primitive_poses')) {
        this.primitive_poses = initObj.primitive_poses
      }
      else {
        this.primitive_poses = [];
      }
      if (initObj.hasOwnProperty('meshes')) {
        this.meshes = initObj.meshes
      }
      else {
        this.meshes = [];
      }
      if (initObj.hasOwnProperty('mesh_poses')) {
        this.mesh_poses = initObj.mesh_poses
      }
      else {
        this.mesh_poses = [];
      }
      if (initObj.hasOwnProperty('planes')) {
        this.planes = initObj.planes
      }
      else {
        this.planes = [];
      }
      if (initObj.hasOwnProperty('plane_poses')) {
        this.plane_poses = initObj.plane_poses
      }
      else {
        this.plane_poses = [];
      }
      if (initObj.hasOwnProperty('primitive_origin')) {
        this.primitive_origin = initObj.primitive_origin
      }
      else {
        this.primitive_origin = 0;
      }
      if (initObj.hasOwnProperty('mesh_origin')) {
        this.mesh_origin = initObj.mesh_origin
      }
      else {
        this.mesh_origin = 0;
      }
      if (initObj.hasOwnProperty('origin')) {
        this.origin = initObj.origin
      }
      else {
        this.origin = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('content')) {
        this.content = initObj.content
      }
      else {
        this.content = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Object
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = object_recognition_msgs.msg.ObjectType.serialize(obj.type, buffer, bufferOffset);
    // Serialize message field [primitives]
    // Serialize the length for message field [primitives]
    bufferOffset = _serializer.uint32(obj.primitives.length, buffer, bufferOffset);
    obj.primitives.forEach((val) => {
      bufferOffset = shape_msgs.msg.SolidPrimitive.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [primitive_poses]
    // Serialize the length for message field [primitive_poses]
    bufferOffset = _serializer.uint32(obj.primitive_poses.length, buffer, bufferOffset);
    obj.primitive_poses.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [meshes]
    // Serialize the length for message field [meshes]
    bufferOffset = _serializer.uint32(obj.meshes.length, buffer, bufferOffset);
    obj.meshes.forEach((val) => {
      bufferOffset = shape_msgs.msg.Mesh.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [mesh_poses]
    // Serialize the length for message field [mesh_poses]
    bufferOffset = _serializer.uint32(obj.mesh_poses.length, buffer, bufferOffset);
    obj.mesh_poses.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [planes]
    // Serialize the length for message field [planes]
    bufferOffset = _serializer.uint32(obj.planes.length, buffer, bufferOffset);
    obj.planes.forEach((val) => {
      bufferOffset = shape_msgs.msg.Plane.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [plane_poses]
    // Serialize the length for message field [plane_poses]
    bufferOffset = _serializer.uint32(obj.plane_poses.length, buffer, bufferOffset);
    obj.plane_poses.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [primitive_origin]
    bufferOffset = _serializer.int32(obj.primitive_origin, buffer, bufferOffset);
    // Serialize message field [mesh_origin]
    bufferOffset = _serializer.int32(obj.mesh_origin, buffer, bufferOffset);
    // Serialize message field [origin]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.origin, buffer, bufferOffset);
    // Serialize message field [content]
    bufferOffset = _serializer.byte(obj.content, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Object
    let len;
    let data = new Object(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = object_recognition_msgs.msg.ObjectType.deserialize(buffer, bufferOffset);
    // Deserialize message field [primitives]
    // Deserialize array length for message field [primitives]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.primitives = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.primitives[i] = shape_msgs.msg.SolidPrimitive.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [primitive_poses]
    // Deserialize array length for message field [primitive_poses]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.primitive_poses = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.primitive_poses[i] = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [meshes]
    // Deserialize array length for message field [meshes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.meshes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.meshes[i] = shape_msgs.msg.Mesh.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [mesh_poses]
    // Deserialize array length for message field [mesh_poses]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.mesh_poses = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.mesh_poses[i] = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [planes]
    // Deserialize array length for message field [planes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.planes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.planes[i] = shape_msgs.msg.Plane.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [plane_poses]
    // Deserialize array length for message field [plane_poses]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.plane_poses = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.plane_poses[i] = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [primitive_origin]
    data.primitive_origin = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [mesh_origin]
    data.mesh_origin = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [origin]
    data.origin = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [content]
    data.content = _deserializer.byte(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.name);
    length += object_recognition_msgs.msg.ObjectType.getMessageSize(object.type);
    object.primitives.forEach((val) => {
      length += shape_msgs.msg.SolidPrimitive.getMessageSize(val);
    });
    length += 56 * object.primitive_poses.length;
    object.meshes.forEach((val) => {
      length += shape_msgs.msg.Mesh.getMessageSize(val);
    });
    length += 56 * object.mesh_poses.length;
    length += 32 * object.planes.length;
    length += 56 * object.plane_poses.length;
    return length + 93;
  }

  static datatype() {
    // Returns string type for a message object
    return 'object_msgs/Object';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '59a4dbed61a3869d90b7226cdd261082';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    # database. E.g., in object_recognition, it can look like: "{'type':'CouchDB', 'root':'http://localhost'}"
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Object(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.type !== undefined) {
      resolved.type = object_recognition_msgs.msg.ObjectType.Resolve(msg.type)
    }
    else {
      resolved.type = new object_recognition_msgs.msg.ObjectType()
    }

    if (msg.primitives !== undefined) {
      resolved.primitives = new Array(msg.primitives.length);
      for (let i = 0; i < resolved.primitives.length; ++i) {
        resolved.primitives[i] = shape_msgs.msg.SolidPrimitive.Resolve(msg.primitives[i]);
      }
    }
    else {
      resolved.primitives = []
    }

    if (msg.primitive_poses !== undefined) {
      resolved.primitive_poses = new Array(msg.primitive_poses.length);
      for (let i = 0; i < resolved.primitive_poses.length; ++i) {
        resolved.primitive_poses[i] = geometry_msgs.msg.Pose.Resolve(msg.primitive_poses[i]);
      }
    }
    else {
      resolved.primitive_poses = []
    }

    if (msg.meshes !== undefined) {
      resolved.meshes = new Array(msg.meshes.length);
      for (let i = 0; i < resolved.meshes.length; ++i) {
        resolved.meshes[i] = shape_msgs.msg.Mesh.Resolve(msg.meshes[i]);
      }
    }
    else {
      resolved.meshes = []
    }

    if (msg.mesh_poses !== undefined) {
      resolved.mesh_poses = new Array(msg.mesh_poses.length);
      for (let i = 0; i < resolved.mesh_poses.length; ++i) {
        resolved.mesh_poses[i] = geometry_msgs.msg.Pose.Resolve(msg.mesh_poses[i]);
      }
    }
    else {
      resolved.mesh_poses = []
    }

    if (msg.planes !== undefined) {
      resolved.planes = new Array(msg.planes.length);
      for (let i = 0; i < resolved.planes.length; ++i) {
        resolved.planes[i] = shape_msgs.msg.Plane.Resolve(msg.planes[i]);
      }
    }
    else {
      resolved.planes = []
    }

    if (msg.plane_poses !== undefined) {
      resolved.plane_poses = new Array(msg.plane_poses.length);
      for (let i = 0; i < resolved.plane_poses.length; ++i) {
        resolved.plane_poses[i] = geometry_msgs.msg.Pose.Resolve(msg.plane_poses[i]);
      }
    }
    else {
      resolved.plane_poses = []
    }

    if (msg.primitive_origin !== undefined) {
      resolved.primitive_origin = msg.primitive_origin;
    }
    else {
      resolved.primitive_origin = 0
    }

    if (msg.mesh_origin !== undefined) {
      resolved.mesh_origin = msg.mesh_origin;
    }
    else {
      resolved.mesh_origin = 0
    }

    if (msg.origin !== undefined) {
      resolved.origin = geometry_msgs.msg.Pose.Resolve(msg.origin)
    }
    else {
      resolved.origin = new geometry_msgs.msg.Pose()
    }

    if (msg.content !== undefined) {
      resolved.content = msg.content;
    }
    else {
      resolved.content = 0
    }

    return resolved;
    }
};

// Constants for message
Object.Constants = {
  SHAPE: 0,
  POSE: 1,
  ORIGIN_AVERAGE: -1,
  ORIGIN_UNDEFINED: -2,
  ORIGIN_CUSTOM: -3,
}

module.exports = Object;
