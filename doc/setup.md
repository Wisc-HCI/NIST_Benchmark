# Setup 

The following instructions are for setting up FCI control on the Franka Emika Robot (FER) Panda using libfranka and franka_ros. These instructions allow you to launch a container so that you don't have to face most of the pain and suffering we went through in the installation process. However, if you want to control the physical Panda (versus just simulating it), you will still nee to install a Real-Time kernel patch (required by libfranka) on your host computer because containers share the host's machines kernel.

<span style="color:red"> **Note: You only have to do steps 1-2 once, the first time you are setting up this repo to work with your Panda. Steps 3-4 you have to do EVERY time you want to work with the robot if your container has shut down.**</span>



### 1. Prequisites
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
* Some additional ROS Noetic libraries

If you have a different versions of the above robot software, reference the [compatible versions](https://frankaemika.github.io/docs/compatibility.html). WARNING: version compatibility is SUPER important.


### 2. Real Time Kernel Patch Installation
**Only install the Real-Time Kernel Patch if you want to physically control the Panda. If you just want to simulate it, you can skip this step.**

Set up realtime kernel by following [these instructions](https://frankaemika.github.io/docs/installation_linux.html#setting-up-the-real-time-kernel) (we suggest running them all in your Downloads directory).
* For the curl step, we are running Kernel 5.17.0 so we ran:
```bash
curl -SLO https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.17.1.tar.xz
curl -SLO https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.17.1.tar.sign
curl -SLO https://www.kernel.org/pub/linux/kernel/projects/rt/5.17/patch-5.17.1-rt17.patch.xz
curl -SLO https://www.kernel.org/pub/linux/kernel/projects/rt/5.17/patch-5.17.1-rt17.patch.sign
```

* In the `make menuconfig` step, if you can not see the option to enable  "Fully Preemptible Kernel (Real-Time)", you need to enable General Setup -> Embedded System, save, and then try again ([source](https://unix.stackexchange.com/questions/582075/trouble-selecting-fully-preemptible-kernel-real-time-when-configuring-compil))

* If you run into errors you can't see when compiling the kernel, run the verbose version on a single core: `make V=1 deb-pkg` (warning: this will take forever) and reference (this source)[https://gist.github.com/FrankieWOO/3d3b04ef1de1817142c8131708cf6dee] for error messages.


### 3. Setting Up Your Container
<span style="color:red"> **The previous steps, you only have to do one time. The following steps, you need to do everytime you want to work with the robot if your container has shut down.** </span>


First set up display forwarding:
```bash
xhost +local:
```
Now  build the container image and start the container. Make sure you are in this root directory (NIST_Benchmark). These commands mount on the current directory as the containers file system so any changes you make to the files on your host machine will be mirrored in the container. These commands also allow the containers display to be forwarded to your host machine so that you can see it.
```bash
sudo docker build -t panda-container .

# Start the container with real-time kernel privileges, mount onto the current directory, and allow display forwarding
sudo docker run -it --privileged --cap-add=SYS_NICE --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-container
```

Now your container should be running and you should be in it's command line. Now setup the dependencies:
```bash
source /opt/ros/noetic/setup.sh
cd src/relaxed_ik_ros1/relaxed_ik_core
cargo build

cd /workspace
catkin build
source devel/setup.sh

chmod +x /workspace/src/panda_benchmark/scripts/pick_and_place.py
chmod +x /workspace/src/panda_benchmark/scripts/move_to_position.py

```

### Optional: 3B. Seting Up Container with bash/zsh scripts
If you want to use bash script to set up your container, try the module [ros-docker-dev](../ros-docker-dev).
Features TLDR;
 * User spoofing
 * SSH forwarding
 * Option to use zsh
 * One-step building container

#### Prerequisites
To make the git submodule [ros-docker-dev](../ros-docker-dev) work and up-to-date, you should firstly
initialize the submodule.
```bash
git submodule update --init --remote
```
#### Options
We provide Options flag in this container. Please see [ros-docker-dev](../ros-docker-dev/README.md) for more details about this script and launching the containers.
 * -n: Nocache or rebuild New image
 * -b: use Bash instead of zsh
 * -r: enable Realtime kernel

#### Run Examples
##### Example 1: Rebuild or Build with no cache
If you want to rebuild the image with changed dockerfile or to build with no-cache for the latest dependencies, you could build with no cache by running the following scirpts. In this way, you could rebuild the image from scratch but spend much longer time.
```bash
./enterpoint.sh -n
```
##### Example 2: Build the image with cache, enable realtime kernel, and use bash inside container
```bash
cd ros-docker-dev
./enterpoint.sh -br
```

##### Example 3: Build or rebuild the image with no cache, enable realtime kernel and use zsh inside container. 
```bash
cd ros-docker-dev
./enterpoint.sh -nr
```
##### Example 4: Enter an existing container, with realtime kernel. (-n will raise unexpected error)
```bash
cd ros-docker-dev
./enterpoint.sh -r
```

:warning: **Note:** If the realtime kernel is not permitted as the regular user in the container, you could try `sudo -i` to activate the root user.

#### Continue Setup
Now your container should be running and you should be in it's command line. Now setup the dependencies:
```bash
source /opt/ros/noetic/setup.zsh    # or source /opt/ros/noetic/setup.bash   if you are using bash
cd src/relaxed_ik_ros1/relaxed_ik_core
cargo build

cd ${WORKSPACE_PATH}
sudo sh ros-docker-dev/init_scripts/NIST_Benchmark.sh

catkin build
source devel/setup.zsh      # or source devel/setup.bash   if you are using bash

chmod +x ${WORKSPACE_PATH}/src/panda_benchmark/scripts/
```

Then in your [run_simulation](./run_simulation.md) and [run_robot](./run_robot.md), you are supposed to use `simulation_b.launch` and `interface_b.launch`.

### 4. Set Up Franka Desktop
Before you can run anything with the FCI, make sure joints are unlocked and FCI Control is enabled in the Franka desktop (our Desktops is at [192.168.1.2](https://192.168.1.2/desk/)). Directions for doing that are [here](https://youtu.be/91wFDNHVXI4?si=4-ZArdrxOMAiCc5H&t=484). WARNING: we could not get Firefox to access the desk because of security reasons. However we could access through chrome once we clicked "Advanced" > "Proceed to 192.168.1.2 (unsafe)".

Now you are ready to run the robot or simulation by reference [run_robot.md](/doc/run_robot.md) or [run_simulation.md](/doc/run_simulation.md)



---

###  Notes

* If you make changes in any of the src C/C++ files, you'll need to run:

    ```bash
    catkin build
    source devel/setup.sh
    ```
* Opening a new docker terminal:
    ```bash
    docker ps  # This will show you running containers w/ their ID
    docker exec -it <CONTAINER_ID> bash  # This will open the container's terminal
    source devel/setup.sh  # Run this in the container's terminal
    ```

* If you ever change  /src/relaxed_ik_ros1/relaxed_ik_core (which you probably should not be doing), you will need to go into that directory and recompile it with `cargo build`

* If you make changes to libfranka (which you probably should not be doing), you'll need to run:
    ``` bash
    cd libfranka/build  # May need to use other command to get to this directory
    rm -r * # For cleaning the cache to avoid errors of builds on different machines
    cmake -DBUILD_TESTS=OFF .. 
    cmake --build .
    cpack -G DEB
    sudo dpkg -i libfranka-0.9.2-x86_64.deb
    ```
