
(cl:in-package :asdf)

(defsystem "relaxed_ik_ros1-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "IKPose" :depends-on ("_package_IKPose"))
    (:file "_package_IKPose" :depends-on ("_package"))
    (:file "IKVelocity" :depends-on ("_package_IKVelocity"))
    (:file "_package_IKVelocity" :depends-on ("_package"))
  ))