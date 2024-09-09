; Auto-generated. Do not edit!


(cl:in-package relaxed_ik_ros1-srv)


;//! \htmlinclude IKPose-request.msg.html

(cl:defclass <IKPose-request> (roslisp-msg-protocol:ros-message)
  ((ee_poses
    :reader ee_poses
    :initarg :ee_poses
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose)))
   (tolerances
    :reader tolerances
    :initarg :tolerances
    :type (cl:vector geometry_msgs-msg:Twist)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Twist :initial-element (cl:make-instance 'geometry_msgs-msg:Twist))))
)

(cl:defclass IKPose-request (<IKPose-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IKPose-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IKPose-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name relaxed_ik_ros1-srv:<IKPose-request> is deprecated: use relaxed_ik_ros1-srv:IKPose-request instead.")))

(cl:ensure-generic-function 'ee_poses-val :lambda-list '(m))
(cl:defmethod ee_poses-val ((m <IKPose-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-srv:ee_poses-val is deprecated.  Use relaxed_ik_ros1-srv:ee_poses instead.")
  (ee_poses m))

(cl:ensure-generic-function 'tolerances-val :lambda-list '(m))
(cl:defmethod tolerances-val ((m <IKPose-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-srv:tolerances-val is deprecated.  Use relaxed_ik_ros1-srv:tolerances instead.")
  (tolerances m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IKPose-request>) ostream)
  "Serializes a message object of type '<IKPose-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ee_poses))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ee_poses))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tolerances))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tolerances))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IKPose-request>) istream)
  "Deserializes a message object of type '<IKPose-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ee_poses) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ee_poses)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Pose))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IKPose-request>)))
  "Returns string type for a service object of type '<IKPose-request>"
  "relaxed_ik_ros1/IKPoseRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IKPose-request)))
  "Returns string type for a service object of type 'IKPose-request"
  "relaxed_ik_ros1/IKPoseRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IKPose-request>)))
  "Returns md5sum for a message object of type '<IKPose-request>"
  "87c66b5bf696f783971b87b3f0518ef4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IKPose-request)))
  "Returns md5sum for a message object of type 'IKPose-request"
  "87c66b5bf696f783971b87b3f0518ef4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IKPose-request>)))
  "Returns full string definition for message of type '<IKPose-request>"
  (cl:format cl:nil "geometry_msgs/Pose[] ee_poses~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IKPose-request)))
  "Returns full string definition for message of type 'IKPose-request"
  (cl:format cl:nil "geometry_msgs/Pose[] ee_poses~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IKPose-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ee_poses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tolerances) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IKPose-request>))
  "Converts a ROS message object to a list"
  (cl:list 'IKPose-request
    (cl:cons ':ee_poses (ee_poses msg))
    (cl:cons ':tolerances (tolerances msg))
))
;//! \htmlinclude IKPose-response.msg.html

(cl:defclass <IKPose-response> (roslisp-msg-protocol:ros-message)
  ((joint_state
    :reader joint_state
    :initarg :joint_state
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass IKPose-response (<IKPose-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IKPose-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IKPose-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name relaxed_ik_ros1-srv:<IKPose-response> is deprecated: use relaxed_ik_ros1-srv:IKPose-response instead.")))

(cl:ensure-generic-function 'joint_state-val :lambda-list '(m))
(cl:defmethod joint_state-val ((m <IKPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-srv:joint_state-val is deprecated.  Use relaxed_ik_ros1-srv:joint_state instead.")
  (joint_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IKPose-response>) ostream)
  "Serializes a message object of type '<IKPose-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IKPose-response>) istream)
  "Deserializes a message object of type '<IKPose-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IKPose-response>)))
  "Returns string type for a service object of type '<IKPose-response>"
  "relaxed_ik_ros1/IKPoseResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IKPose-response)))
  "Returns string type for a service object of type 'IKPose-response"
  "relaxed_ik_ros1/IKPoseResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IKPose-response>)))
  "Returns md5sum for a message object of type '<IKPose-response>"
  "87c66b5bf696f783971b87b3f0518ef4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IKPose-response)))
  "Returns md5sum for a message object of type 'IKPose-response"
  "87c66b5bf696f783971b87b3f0518ef4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IKPose-response>)))
  "Returns full string definition for message of type '<IKPose-response>"
  (cl:format cl:nil "float64[] joint_state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IKPose-response)))
  "Returns full string definition for message of type 'IKPose-response"
  (cl:format cl:nil "float64[] joint_state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IKPose-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'joint_state) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IKPose-response>))
  "Converts a ROS message object to a list"
  (cl:list 'IKPose-response
    (cl:cons ':joint_state (joint_state msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'IKPose)))
  'IKPose-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'IKPose)))
  'IKPose-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IKPose)))
  "Returns string type for a service object of type '<IKPose>"
  "relaxed_ik_ros1/IKPose")