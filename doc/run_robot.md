# Moving the Physical the Bot

This moves the bot to pick and place an object as specified in [pick_and_place.py](src/panda_benchmark/scripts/pick_and_place.py)

This uses franka_ros_interface as a controller. For compatibility with franka_ros, we are using the kinetic-devel branch of panda_moveit_config. 

## Setup
Please make sure you follow the directions of [setup.md](/doc/setup.md), all the way through step 4.


Change the "FRANKA_ROBOT_IP" and "your_ip"  values in [franka.sh](/franka.sh) (specified in that file). Your robot IP can be found on the Franka Desktop (ours is 192.168.1.2). You can find your internal ip using `ifconfig` (ours should be 192.168.1.___). 

## Running

```bash
# Start the driver
./franka.sh master
roslaunch panda_benchmark interface.launch 


# In another terminal do the following:
source devel/setup.sh
./franka.sh master
# rosrun panda_benchmark pick_and_place.py # WARNING: THIS WILL MOVE THE BOT!

rosrun panda_benchmark torque_controller.py # WARNING: THIS WILL MOVE THE BOT!
```


## Resources
https://github.com/justagist/franka_ros_interface?tab=readme-ov-file
https://github.com/frankaemika/franka_ros/issues/23