// Auto-generated. Do not edit!

// (in-package relaxed_ik_ros1.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class IKVelocityRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ee_vels = null;
      this.tolerances = null;
    }
    else {
      if (initObj.hasOwnProperty('ee_vels')) {
        this.ee_vels = initObj.ee_vels
      }
      else {
        this.ee_vels = [];
      }
      if (initObj.hasOwnProperty('tolerances')) {
        this.tolerances = initObj.tolerances
      }
      else {
        this.tolerances = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type IKVelocityRequest
    // Serialize message field [ee_vels]
    // Serialize the length for message field [ee_vels]
    bufferOffset = _serializer.uint32(obj.ee_vels.length, buffer, bufferOffset);
    obj.ee_vels.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Twist.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [tolerances]
    // Serialize the length for message field [tolerances]
    bufferOffset = _serializer.uint32(obj.tolerances.length, buffer, bufferOffset);
    obj.tolerances.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Twist.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type IKVelocityRequest
    let len;
    let data = new IKVelocityRequest(null);
    // Deserialize message field [ee_vels]
    // Deserialize array length for message field [ee_vels]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.ee_vels = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.ee_vels[i] = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [tolerances]
    // Deserialize array length for message field [tolerances]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.tolerances = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.tolerances[i] = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 48 * object.ee_vels.length;
    length += 48 * object.tolerances.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'relaxed_ik_ros1/IKVelocityRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6a8ee2d00e444eb31e9002a3034078af';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Twist[] ee_vels
    geometry_msgs/Twist[] tolerances
    
    ================================================================================
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new IKVelocityRequest(null);
    if (msg.ee_vels !== undefined) {
      resolved.ee_vels = new Array(msg.ee_vels.length);
      for (let i = 0; i < resolved.ee_vels.length; ++i) {
        resolved.ee_vels[i] = geometry_msgs.msg.Twist.Resolve(msg.ee_vels[i]);
      }
    }
    else {
      resolved.ee_vels = []
    }

    if (msg.tolerances !== undefined) {
      resolved.tolerances = new Array(msg.tolerances.length);
      for (let i = 0; i < resolved.tolerances.length; ++i) {
        resolved.tolerances[i] = geometry_msgs.msg.Twist.Resolve(msg.tolerances[i]);
      }
    }
    else {
      resolved.tolerances = []
    }

    return resolved;
    }
};

class IKVelocityResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.joint_state = null;
    }
    else {
      if (initObj.hasOwnProperty('joint_state')) {
        this.joint_state = initObj.joint_state
      }
      else {
        this.joint_state = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type IKVelocityResponse
    // Serialize message field [joint_state]
    bufferOffset = _arraySerializer.float64(obj.joint_state, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type IKVelocityResponse
    let len;
    let data = new IKVelocityResponse(null);
    // Deserialize message field [joint_state]
    data.joint_state = _arrayDeserializer.float64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.joint_state.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'relaxed_ik_ros1/IKVelocityResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b66d62d17824da488405b2423b7ccb24';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[] joint_state
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new IKVelocityResponse(null);
    if (msg.joint_state !== undefined) {
      resolved.joint_state = msg.joint_state;
    }
    else {
      resolved.joint_state = []
    }

    return resolved;
    }
};

module.exports = {
  Request: IKVelocityRequest,
  Response: IKVelocityResponse,
  md5sum() { return '1cf8f3ae381e7b061b1fe16f359a61d2'; },
  datatype() { return 'relaxed_ik_ros1/IKVelocity'; }
};
