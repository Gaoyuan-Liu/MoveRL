// Auto-generated. Do not edit!

// (in-package gazebo_grasp_plugin.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class GazeboGraspEvent {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.arm = null;
      this.object = null;
      this.attached = null;
    }
    else {
      if (initObj.hasOwnProperty('arm')) {
        this.arm = initObj.arm
      }
      else {
        this.arm = '';
      }
      if (initObj.hasOwnProperty('object')) {
        this.object = initObj.object
      }
      else {
        this.object = '';
      }
      if (initObj.hasOwnProperty('attached')) {
        this.attached = initObj.attached
      }
      else {
        this.attached = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GazeboGraspEvent
    // Serialize message field [arm]
    bufferOffset = _serializer.string(obj.arm, buffer, bufferOffset);
    // Serialize message field [object]
    bufferOffset = _serializer.string(obj.object, buffer, bufferOffset);
    // Serialize message field [attached]
    bufferOffset = _serializer.bool(obj.attached, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GazeboGraspEvent
    let len;
    let data = new GazeboGraspEvent(null);
    // Deserialize message field [arm]
    data.arm = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [object]
    data.object = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [attached]
    data.attached = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.arm);
    length += _getByteLength(object.object);
    return length + 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gazebo_grasp_plugin/GazeboGraspEvent';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a5b6c6f554465c6bcbcad9409a41137a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string arm     # responsible arm
    string object  # affected object
    bool attached  # detached if false
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GazeboGraspEvent(null);
    if (msg.arm !== undefined) {
      resolved.arm = msg.arm;
    }
    else {
      resolved.arm = ''
    }

    if (msg.object !== undefined) {
      resolved.object = msg.object;
    }
    else {
      resolved.object = ''
    }

    if (msg.attached !== undefined) {
      resolved.attached = msg.attached;
    }
    else {
      resolved.attached = false
    }

    return resolved;
    }
};

module.exports = GazeboGraspEvent;
