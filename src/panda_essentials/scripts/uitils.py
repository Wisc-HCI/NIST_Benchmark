import rospy as ros

from functools import wraps

from geometry_msgs.msg import TransformStamped, Pose
from control_msgs.msg import FollowJointTrajectoryAction, \
                             FollowJointTrajectoryGoal, FollowJointTrajectoryResult
from franka_gripper.msg import GraspGoal                             



def time_consumption(enabled=False):
    """
    A decorator to measure the time consumption of a function.
    Includes the class name if used within a class.
    If `enabled` is False, the timer is disabled.
    """
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if not enabled:  # Check if the timer is disabled
                return func(*args, **kwargs)  # Call the function without timing

            # Get the class name if it's a bound method
            class_name = None
            if args and hasattr(args[0], '__class__'):
                class_name = args[0].__class__.__name__

            start_time = ros.Time.now()  # Record the start time
            result = func(*args, **kwargs)  # Call the original function
            end_time = ros.Time.now()  # Record the end time
            duration: ros.Duration = end_time - start_time

            # Include class name in the output if available
            if class_name:
                ros.loginfo(f"{class_name}.{func.__name__}: {duration.to_sec()+duration.to_nsec()/1000} seconds")
            else:
                ros.loginfo(f"{func.__name__}: {duration.to_sec()+duration.to_nsec()/1000} seconds")
            return result

        return wrapper

    return decorator


def validate_params(obj):
    # Get public attributes and their values using vars()
    invalid_list = []
    for attr, value in vars(obj).items():
        if not attr.startswith('_'):
            if value is None:
                invalid_list.append(attr)
    
    if invalid_list:
        ros.logerror(f"Invalid ROS parameters: {', '.join(invalid_list)}")
        return False
    else:
        return True
    
def transformstamped_to_pose(transform):
    pose = Pose()
    pose.position.x = transform.transform.translation.x
    pose.position.y = transform.transform.translation.y
    pose.position.z = transform.transform.translation.z
    pose.orientation.x = transform.transform.rotation.x
    pose.orientation.y = transform.transform.rotation.y
    pose.orientation.z = transform.transform.rotation.z
    pose.orientation.w = transform.transform.rotation.w
    return pose

def dict_to_pose(pose_dict):
    pose = Pose()
    pose.position.x = pose_dict['position']['x']
    pose.position.y = pose_dict['position']['y']
    pose.position.z = pose_dict['position']['z']
    pose.orientation.x = pose_dict['orientation']['x']
    pose.orientation.y = pose_dict['orientation']['y']
    pose.orientation.z = pose_dict['orientation']['z']
    pose.orientation.w = pose_dict['orientation']['w']
    return pose

def dict_to_grasp(grasp_dict):
    grasp = GraspGoal()
    grasp.width = grasp_dict['width']
    grasp.speed = grasp_dict['speed']
    grasp.force = grasp_dict['force']
    # grasp.epsilon.inner = grasp_dict['epsilon']['inner']
    # grasp.epsilon.outer = grasp_dict['epsilon']['outer']
    return grasp


def check_follow_joint_traj_result(self, result, node_name):
    if result.error_code != FollowJointTrajectoryResult.SUCCESSFUL:
        ros.logerr(f'{node_name}: Movement was not successful: ' + {
            FollowJointTrajectoryResult.INVALID_GOAL:
            """
            The joint pose you want to move to is invalid (e.g. unreachable, singularity...).
            Is the 'joint_pose' reachable?
            """,

            FollowJointTrajectoryResult.INVALID_JOINTS:
            """
            The joint pose you specified is for different joints than the joint trajectory controller
            is claiming. Does you 'joint_pose' include all 7 joints of the robot?
            """,

            FollowJointTrajectoryResult.PATH_TOLERANCE_VIOLATED:
            """
            During the motion the robot deviated from the planned path too much. Is something blocking
            the robot?
            """,

            FollowJointTrajectoryResult.GOAL_TOLERANCE_VIOLATED:
            """
            After the motion the robot deviated from the desired goal pose too much. Probably the robot
            didn't reach the joint_pose properly
            """,
        }[result.error_code])

    else:
        ros.loginfo(f'{node_name}: Successfully moved arm into specified pose')
