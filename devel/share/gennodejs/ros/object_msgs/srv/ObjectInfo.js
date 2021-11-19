// Auto-generated. Do not edit!

// (in-package object_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let Object = require('../msg/Object.js');

//-----------------------------------------------------------

class ObjectInfoRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.get_geometry = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('get_geometry')) {
        this.get_geometry = initObj.get_geometry
      }
      else {
        this.get_geometry = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ObjectInfoRequest
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [get_geometry]
    bufferOffset = _serializer.bool(obj.get_geometry, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ObjectInfoRequest
    let len;
    let data = new ObjectInfoRequest(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [get_geometry]
    data.get_geometry = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'object_msgs/ObjectInfoRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1e9343217518c31b3fdbfdafad9f786b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # name of the object whose information is requested
    string name
    
    # set to true if the Geometry should be returned
    # with the Object as well. If false, then only
    # the current object pose fields are returned
    bool get_geometry
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ObjectInfoRequest(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.get_geometry !== undefined) {
      resolved.get_geometry = msg.get_geometry;
    }
    else {
      resolved.get_geometry = false
    }

    return resolved;
    }
};

class ObjectInfoResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.object = null;
      this.error_code = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('object')) {
        this.object = initObj.object
      }
      else {
        this.object = new Object();
      }
      if (initObj.hasOwnProperty('error_code')) {
        this.error_code = initObj.error_code
      }
      else {
        this.error_code = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ObjectInfoResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [object]
    bufferOffset = Object.serialize(obj.object, buffer, bufferOffset);
    // Serialize message field [error_code]
    bufferOffset = _serializer.byte(obj.error_code, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ObjectInfoResponse
    let len;
    let data = new ObjectInfoResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [object]
    data.object = Object.deserialize(buffer, bufferOffset);
    // Deserialize message field [error_code]
    data.error_code = _deserializer.byte(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += Object.getMessageSize(object.object);
    return length + 2;
  }

  static datatype() {
    // Returns string type for a service object
    return 'object_msgs/ObjectInfoResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a9fe6ed8f44295e2c52c2814c09b1b79';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
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
    const resolved = new ObjectInfoResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.object !== undefined) {
      resolved.object = Object.Resolve(msg.object)
    }
    else {
      resolved.object = new Object()
    }

    if (msg.error_code !== undefined) {
      resolved.error_code = msg.error_code;
    }
    else {
      resolved.error_code = 0
    }

    return resolved;
    }
};

// Constants for message
ObjectInfoResponse.Constants = {
  NO_ERROR: 0,
  OBJECT_NOT_FOUND: 1,
  OTHER_ERROR: 2,
}

module.exports = {
  Request: ObjectInfoRequest,
  Response: ObjectInfoResponse,
  md5sum() { return '914392dfee158e8d82269f3dc686d92b'; },
  datatype() { return 'object_msgs/ObjectInfo'; }
};
