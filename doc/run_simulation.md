# Simulating the Bot

This simulates moving the bot to pick and place an object as specified in [pick_and_place.py](src/panda_benchmark/scripts/pick_and_place.py) in gazebo.


## Setup

Please make sure you follow the directions of [setup.md](/doc/setup.md), all the way through step 4.


## Running
Note: If you get `lbGL error: MESA-LOADER: failed to retrieve device information` and Gazebo does not launch, please run `export LIBGL_ALWAYS_SOFTWARE=1` and you can try running the below commands again.
```bash
roslaunch panda_benchmark simulation.launch 

# Run the following in another  terminal to move the bot to a position
source devel/setup.sh
#rosrun panda_benchmark pick_and_place.py
rosrun panda_benchmark torque_controller.py 

```


## Resources
https://github.com/justagist/franka_ros_interface?tab=readme-ov-file

