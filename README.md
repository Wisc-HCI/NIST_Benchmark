# NIST_Benchmark
 [NIST Benchmark](https://www.nist.gov/el/intelligent-systems-division-73500/robotic-grasping-and-manipulation-assembly/assembly) testing with the Franka Emika Panda.

In order to just visualize the robot, follow the `Visualization` section instructions. To physically control the robot, you will need to follow the `Controlling Panda with FCI` instructions.

## Base Environment

For all the steps in this readme, we recommend using Ubuntu 22.04 since that is the only OS that these instructions are tested on.

You will need to install docker so you can run our container. If you are using Ubuntu, you can install docker with [these instructions](https://docs.docker.com/engine/install/ubuntu/#installation-methods): 


## Visualization

We're using RVIZ for visualizations. To run it we've made a container for all the dependencies. Note: The following `Controlling Panda with FCI` section says you need to install a Real-Time Kernel patch but ou do not need that for running visualizations in this section.


First set up display forwarding:
```bash
xhost +local:
```

Now  build the container image and start the container. Make sure you are in this directories root directory (NIST_Benchmark). These commands use the current directory as the containers file system so any changes you make to the files on your host machine will be mirrored in the container. TJese commands also allow the containers display to be forwarded to your host machine so that you can see it.
```bash
sudo docker build -t panda-container .
sudo docker run -it --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-container
```

Now your container should be running and you should be in it's command line. So in the container's terminal, setup the visualization:
```bash
source /opt/ros/noetic/setup.sh
rm -f src/CMakeLists.txt 
catkin_init_workspace src
catkin_make clean
source devel/setup.sh
```

And run the visualization:
```bash
roslaunch relaxed_ik_ros1 demo.launch setting_file_path:=/workspace/src/panda.yaml
```

## Controlling Panda with FCI
The following instructions are for setting up FCI control on the Franka Emika Robot (FER) Panda using libfranka and franka_ros. These instructions allow you to launch a container so that you don't have to face most of the pain and suffering we went through in the installation process. However, you will still nee to install a Real-Time kernel patch (required by libfranka) on your host computer because containers share the host's machines kernel.

### Setup
These are instructions for software setup for interfacing with the Franka Emika Robot (FER) Panda. The instructions assume you have set up the robot and can interface with it using the Franka Desktop. If that is not the case, reference your user manual or follow the start of [this viedo](https://youtu.be/91wFDNHVXI4?si=_RWVrXJ0wC-qe6NI).

Here is what you need to start with:
* Robot system version: 4.2.2 (FER pandas)
* Robot / Gripper Server version: 5/3
* Ubuntu version: 20.04.06 Focal Fossil (any 20.04 version should work fine)
* Docker Containers. [Here](https://docs.docker.com/engine/install/ubuntu/) are the instructions to install Docker on Ubuntu if you need to.


Here is what you are going to run on a Docker Container:
* ROS 1 version: Noetic
* libfranka version: 0.9.2
* franka_ros version: 0.9.1

If you have a different versions of the above robot software, reference the [compatible versions](https://frankaemika.github.io/docs/compatibility.html). WARNING: version compatibility is SUPER important.


**Real time Kernel** <br>
Set up realtime kernel by following [these instructions](https://frankaemika.github.io/docs/installation_linux.html#setting-up-the-real-time-kernel) (I would run them all in your Downloads directory).
* For the curl step, we am running Kernel 5.17.0 so we ran:
```bash
curl -SLO https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.17.1.tar.xz
curl -SLO https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.17.1.tar.sign
curl -SLO https://www.kernel.org/pub/linux/kernel/projects/rt/5.17/patch-5.17.1-rt17.patch.xz
curl -SLO https://www.kernel.org/pub/linux/kernel/projects/rt/5.17/patch-5.17.1-rt17.patch.sign
```

* In the `make menuconfig` step, if you can not see the option to enable  "Fully Preemptible Kernel (Real-Time)", you need to enable General Setup -> Embedded System, save, and then try again ([source](https://unix.stackexchange.com/questions/582075/trouble-selecting-fully-preemptible-kernel-real-time-when-configuring-compil))

* If you run into errors you can't see when compiling the kernel, run the verbose version on a single core: `make V=1 deb-pkg` (warning: this will take forever) and reference (this source)[https://gist.github.com/FrankieWOO/3d3b04ef1de1817142c8131708cf6dee] for error messages.


**Building and Starting the container** <br>
``` bash
# Allow Display forwarding
xhost +local:

# Compile Kernel
sudo docker build -t panda-container .

# Start the container with real-time kernel privileges, mount onto the current directory, and allow display forwarding
sudo docker run -it --privileged --cap-add=SYS_NICE --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-container


# Now the container should be running and you should be in the container's terminal
# Prepare the ROS workspace
rm -f src/CMakeLists.txt  # Remove if it exists from other machine
catkin_init_workspace src
source /opt/ros/noetic/setup.sh
catkin_make clean  # Make sure this is in the base directory (NIST_Benchmark)
source devel/setup.sh
```
TODO: See if can move some of the above to the  docker file

### Running
Before you can run anything with code, make sure joints are unlocked and FCI Control is enabled in the Franka desktop ( our robot is [192.168.1.2](https://192.168.1.2/desk/)). Directions for doing that are [here](https://youtu.be/91wFDNHVXI4?si=4-ZArdrxOMAiCc5H&t=484). WARNING: we could not get Firefox to access the desk because of security reasons. However we could access through chrome once we clicked "Advanced" > "Proceed to 192.168.1.2 (unsafe)".

You should still be in the container's terminal to run the following commands. Make sure to subsitute 192.168.1.2 with your robot's IP.
```bash
sudo echo_robot_state 192.168.1.2  # TODO: Check this
sudo communication_test 192.168.1.2  # Tests realtime kernel and robot by moving bot  # TODO: REPLACE THIS
```

###  Notes

Every time you open a new terminal, you'll need to run:
```bash
source /opt/ros/noetic/setup.sh
source devel/setup.sh
```

If you make changes, in src, you'll need to run:

```bash
catkin_make  # Make sure you're in root directory
source devel/setup.sh
```

If you make changes to libfranka (which you probably should not be doing), you'll need to run:
``` bash
cd libfranka/build  # May need to use other command to get to this directory
rm -r * # For cleaning the cache to avoid errors of builds on different machines
cmake -DBUILD_TESTS=OFF .. 
cmake --build .
cpack -G DEB
sudo dpkg -i libfranka-0.9.2-x86_64.deb

```

## Troubleshooting + Tips
Check the "Panda Notes" section at the bottom of [setup.md](setup.md) for tips you should know about Panda.

## Resources
Source of RelaxedIK (Panda URDF has been midly modified):
https://github.com/uwgraphics/relaxed_ik_ros1

More detailed instructions that help with installing RelaxedIK ROS1:
https://github.com/uwgraphics/relaxed_ik_ros2 


Source of franka_description:
https://github.com/frankaemika/franka_ros/tree/develop/franka_description



## Notes:

If you ever change  /src/relaxed_ik_ros1/relaxed_ik_core, you will need to go into that directory and recompile it with `cargo build`

