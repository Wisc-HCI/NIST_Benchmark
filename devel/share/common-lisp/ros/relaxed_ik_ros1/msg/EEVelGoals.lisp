; Auto-generated. Do not edit!


(cl:in-package relaxed_ik_ros1-msg)


;//! \htmlinclude EEVelGoals.msg.html

(cl:defclass <EEVelGoals> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (ee_vels
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

(cl:defclass EEVelGoals (<EEVelGoals>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EEVelGoals>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EEVelGoals)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name relaxed_ik_ros1-msg:<EEVelGoals> is deprecated: use relaxed_ik_ros1-msg:EEVelGoals instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EEVelGoals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-msg:header-val is deprecated.  Use relaxed_ik_ros1-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'ee_vels-val :lambda-list '(m))
(cl:defmethod ee_vels-val ((m <EEVelGoals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-msg:ee_vels-val is deprecated.  Use relaxed_ik_ros1-msg:ee_vels instead.")
  (ee_vels m))

(cl:ensure-generic-function 'tolerances-val :lambda-list '(m))
(cl:defmethod tolerances-val ((m <EEVelGoals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-msg:tolerances-val is deprecated.  Use relaxed_ik_ros1-msg:tolerances instead.")
  (tolerances m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EEVelGoals>) ostream)
  "Serializes a message object of type '<EEVelGoals>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EEVelGoals>) istream)
  "Deserializes a message object of type '<EEVelGoals>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EEVelGoals>)))
  "Returns string type for a message object of type '<EEVelGoals>"
  "relaxed_ik_ros1/EEVelGoals")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EEVelGoals)))
  "Returns string type for a message object of type 'EEVelGoals"
  "relaxed_ik_ros1/EEVelGoals")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EEVelGoals>)))
  "Returns md5sum for a message object of type '<EEVelGoals>"
  "73a8278b72bc91801a6231533cba27f3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EEVelGoals)))
  "Returns md5sum for a message object of type 'EEVelGoals"
  "73a8278b72bc91801a6231533cba27f3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EEVelGoals>)))
  "Returns full string definition for message of type '<EEVelGoals>"
  (cl:format cl:nil "std_msgs/Header header~%geometry_msgs/Twist[] ee_vels~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EEVelGoals)))
  "Returns full string definition for message of type 'EEVelGoals"
  (cl:format cl:nil "std_msgs/Header header~%geometry_msgs/Twist[] ee_vels~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EEVelGoals>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ee_vels) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tolerances) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EEVelGoals>))
  "Converts a ROS message object to a list"
  (cl:list 'EEVelGoals
    (cl:cons ':header (header msg))
    (cl:cons ':ee_vels (ee_vels msg))
    (cl:cons ':tolerances (tolerances msg))
))
