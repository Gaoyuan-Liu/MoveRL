// Auto-generated. Do not edit!

// (in-package panda_state.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class RobotStates {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.xe = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('xe')) {
        this.xe = initObj.xe
      }
      else {
        this.xe = new Array(3).fill(new std_msgs.msg.Float64());
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RobotStates
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Check that the constant length array field [xe] has the right length
    if (obj.xe.length !== 3) {
      throw new Error('Unable to serialize array field xe - length must be 3')
    }
    // Serialize message field [xe]
    obj.xe.forEach((val) => {
      bufferOffset = std_msgs.msg.Float64.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RobotStates
    let len;
    let data = new RobotStates(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [xe]
    len = 3;
    data.xe = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.xe[i] = std_msgs.msg.Float64.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'panda_state/RobotStates';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '79c455d062acdbc2bbc3010df721a4d4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    std_msgs/Float64[3] xe 
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
    MSG: std_msgs/Float64
    float64 data
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RobotStates(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.xe !== undefined) {
      resolved.xe = new Array(3)
      for (let i = 0; i < resolved.xe.length; ++i) {
        if (msg.xe.length > i) {
          resolved.xe[i] = std_msgs.msg.Float64.Resolve(msg.xe[i]);
        }
        else {
          resolved.xe[i] = new std_msgs.msg.Float64();
        }
      }
    }
    else {
      resolved.xe = new Array(3).fill(new std_msgs.msg.Float64())
    }

    return resolved;
    }
};

module.exports = RobotStates;
