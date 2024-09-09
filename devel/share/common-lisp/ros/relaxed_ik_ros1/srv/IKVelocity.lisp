; Auto-generated. Do not edit!


(cl:in-package relaxed_ik_ros1-srv)


;//! \htmlinclude IKVelocity-request.msg.html

(cl:defclass <IKVelocity-request> (roslisp-msg-protocol:ros-message)
  ((ee_vels
    :reader ee_vels
    :initarg :ee_vels
    :type (cl:vector geometry_msgs-msg:Twist)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Twist :initial-element (cl:make-instance 'geometry_msgs-msg:Twist)))
   (tolerances
    :reader tolerances
    :initarg :tolerances
    :type (cl:vector geometry_msgs-msg:Twist)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Twist :initial-element (cl:make-instance 'geometry_msgs-msg:Twist))))
)

(cl:defclass IKVelocity-request (<IKVelocity-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IKVelocity-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IKVelocity-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name relaxed_ik_ros1-srv:<IKVelocity-request> is deprecated: use relaxed_ik_ros1-srv:IKVelocity-request instead.")))

(cl:ensure-generic-function 'ee_vels-val :lambda-list '(m))
(cl:defmethod ee_vels-val ((m <IKVelocity-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-srv:ee_vels-val is deprecated.  Use relaxed_ik_ros1-srv:ee_vels instead.")
  (ee_vels m))

(cl:ensure-generic-function 'tolerances-val :lambda-list '(m))
(cl:defmethod tolerances-val ((m <IKVelocity-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-srv:tolerances-val is deprecated.  Use relaxed_ik_ros1-srv:tolerances instead.")
  (tolerances m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IKVelocity-request>) ostream)
  "Serializes a message object of type '<IKVelocity-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ee_vels))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ee_vels))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tolerances))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tolerances))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IKVelocity-request>) istream)
  "Deserializes a message object of type '<IKVelocity-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ee_vels) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ee_vels)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Twist))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tolerances) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tolerances)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Twist))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IKVelocity-request>)))
  "Returns string type for a service object of type '<IKVelocity-request>"
  "relaxed_ik_ros1/IKVelocityRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IKVelocity-request)))
  "Returns string type for a service object of type 'IKVelocity-request"
  "relaxed_ik_ros1/IKVelocityRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IKVelocity-request>)))
  "Returns md5sum for a message object of type '<IKVelocity-request>"
  "1cf8f3ae381e7b061b1fe16f359a61d2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IKVelocity-request)))
  "Returns md5sum for a message object of type 'IKVelocity-request"
  "1cf8f3ae381e7b061b1fe16f359a61d2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IKVelocity-request>)))
  "Returns full string definition for message of type '<IKVelocity-request>"
  (cl:format cl:nil "geometry_msgs/Twist[] ee_vels~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IKVelocity-request)))
  "Returns full string definition for message of type 'IKVelocity-request"
  (cl:format cl:nil "geometry_msgs/Twist[] ee_vels~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IKVelocity-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ee_vels) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tolerances) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IKVelocity-request>))
  "Converts a ROS message object to a list"
  (cl:list 'IKVelocity-request
    (cl:cons ':ee_vels (ee_vels msg))
    (cl:cons ':tolerances (tolerances msg))
))
;//! \htmlinclude IKVelocity-response.msg.html

(cl:defclass <IKVelocity-response> (roslisp-msg-protocol:ros-message)
  ((joint_state
    :reader joint_state
    :initarg :joint_state
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass IKVelocity-response (<IKVelocity-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IKVelocity-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IKVelocity-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name relaxed_ik_ros1-srv:<IKVelocity-response> is deprecated: use relaxed_ik_ros1-srv:IKVelocity-response instead.")))

(cl:ensure-generic-function 'joint_state-val :lambda-list '(m))
(cl:defmethod joint_state-val ((m <IKVelocity-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-srv:joint_state-val is deprecated.  Use relaxed_ik_ros1-srv:joint_state instead.")
  (joint_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IKVelocity-response>) ostream)
  "Serializes a message object of type '<IKVelocity-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'joint_state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'joint_state))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IKVelocity-response>) istream)
  "Deserializes a message object of type '<IKVelocity-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'joint_state) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'joint_state)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IKVelocity-response>)))
  "Returns string type for a service object of type '<IKVelocity-response>"
  "relaxed_ik_ros1/IKVelocityResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IKVelocity-response)))
  "Returns string type for a service object of type 'IKVelocity-response"
  "relaxed_ik_ros1/IKVelocityResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IKVelocity-response>)))
  "Returns md5sum for a message object of type '<IKVelocity-response>"
  "1cf8f3ae381e7b061b1fe16f359a61d2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IKVelocity-response)))
  "Returns md5sum for a message object of type 'IKVelocity-response"
  "1cf8f3ae381e7b061b1fe16f359a61d2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IKVelocity-response>)))
  "Returns full string definition for message of type '<IKVelocity-response>"
  (cl:format cl:nil "float64[] joint_state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IKVelocity-response)))
  "Returns full string definition for message of type 'IKVelocity-response"
  (cl:format cl:nil "float64[] joint_state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IKVelocity-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'joint_state) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IKVelocity-response>))
  "Converts a ROS message object to a list"
  (cl:list 'IKVelocity-response
    (cl:cons ':joint_state (joint_state msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'IKVelocity)))
  'IKVelocity-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'IKVelocity)))
  'IKVelocity-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IKVelocity)))
  "Returns string type for a service object of type '<IKVelocity>"
  "relaxed_ik_ros1/IKVelocity")