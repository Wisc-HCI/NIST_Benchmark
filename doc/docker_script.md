
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
##### Usually you can just run
```bash
cd ros-docker-dev
./enterpoint.sh -r
```

##### Example 1: Build or rebuild the image with no cache, enable realtime kernel. 
```bash
cd ros-docker-dev
./enterpoint.sh -nr
```
##### Example 2: Build and run image or enter an existing container, with realtime kernel. (-n will start rebuilding)
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
sudo bash ros-docker-dev/init_scripts/NIST_Benchmark.sh

catkin build
source devel/setup.bash      # or source devel/setup.bash   if you are using bash

chmod +x ${WORKSPACE_PATH}/src/panda_benchmark/scripts/
```

Then in your [run_simulation](./run_simulation.md) and [run_robot](./run_robot.md), you are supposed to use `simulation_b.launch` and `interface_b.launch`.
