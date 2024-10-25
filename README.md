# NIST_Benchmark
This repo is for passing the [NIST Benchmark](https://www.nist.gov/el/intelligent-systems-division-73500/robotic-grasping-and-manipulation-assembly/assembly) tests with the Franka Emika Panda Robot. 


## Running
1. Follow the instruction in [doc/setup.md](/doc/setup.md) to setup everything.

2. To run this repo...
    - In simulation, follow the instructions in [doc/run_simulation.md](/doc/run_simulation.md).
    - On the bot, follow the instructions in [doc/run_robot.md](/doc/run_robot.md).


## Making Changes
Our code is in the src/panda_benchmark package. Please only put any additional scripts there.


## Troubleshooting + Tips
* Note: If you get an error about `libGL error: MESA-LOADER: failed to retrieve device information`, please run `export LIBGL_ALWAYS_SOFTWARE=1` and your issue should be fixed.

* Panda limits for motion are located [here](https://frankaemika.github.io/docs/control_parameters.html#limits-for-panda).
If you go beyond them, you will get the error `libfranka: Move command aborted: motion aborted by reflex! ["cartesian_reflex"]`.
After that any other command will throw the error `libfranka: Set Joint Impedance command rejected: command not possible in the current mode ("Reflex")!` **UNTIL  the joints are locked and unlocked**.

* If you ever see the error `libfranka: Set Joint Impedance command rejected: command not possible in the current mode ("Reflex")!` along with the error on Franka Desktop of `Configured Force Thresholds Reached.` and they keep on popping up even when moving very little/slowly and pop up when moving to the "pack" position in Settings > System > Move Robot to Transport Pose (even after you reboot), you will need to **factory reset** the bot by using the button under Settings > System > Factory Reset. 



## Resources
Source of RelaxedIK (Panda URDF has been midly modified):
https://github.com/uwgraphics/relaxed_ik_ros1

More detailed instructions that help with installing RelaxedIK ROS1:
https://github.com/uwgraphics/relaxed_ik_ros2 


Source of franka_description:
https://github.com/frankaemika/franka_ros/tree/develop/franka_description





