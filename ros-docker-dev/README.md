# Editable ROS Docker Development

You could also check the latest [main branch README.md](https://github.com/AlfredMoore/ros-docker-dev/blob/main/README.md)

## Panda Noetic
To Create Image, Run Container or Open another section in Container, please use
```bash
./enterpoint.sh
```

If you want to build with no-cache for latest dependencies, which keeps docker content up to date but takes much longer time, use
```bash
export NOCACHE=true
./enterpoint.sh
```

You should firstly install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/) on your Ubuntu. Then [manage docker as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user), to enable `docker` instead of `sudo docker`.

NOTE: Do not install Docker Desktop. It is different from the Docker Engine and not so friendly to docker development.

## Features:
 * Volumed: Container volumed the parent folder(../ros-docker-dev) as the workspace in container. If you don't need it, please comment in the [enterpoint.sh](./enterpoint.sh)
 ```bash
 --volume="$(dirname ${ENTERPOINT_DIR}):${WORKSPACE_PATH}"   # Volume the parent of this docker repo to workspace
 ``` 
 * User spoofing: Container has the same username and password as the host.
 * SSH forwarding: Container fetches the same ssh agent as the host (if you have set the ssh-agent in host). No need to add any additional SSH key pair. In the container you could directly use `git` via SSH.
 * Oh-my-zsh: Container has an configured oh-my-zsh. It is editable in the [configs/oh-my-zsh.zshrc](./configs/oh-my-zsh.zshrc).
 * Editable and Readable: [Dockerfile](./panda-noetic.Dockerfile), [Building Config](./panda-bake.hcl) and [Running Config](./enterpoint.sh). You can also build from the [raw dockerfile](./raw.Dockerfile).

## Contribution
### [NIST_Benchmark](https://github.com/Wisc-HCI/NIST_Benchmark)
:warning: **Note: In the container, you will use zsh intead of bash. `zsh` is pretty and more powerful with oh-my-zsh theme and auto-completion. But remember to `source /devel/setup.zsh` instead of `.bash`**

 * Some computers support directly `sudo apt install libfranka`, but some do not. So uncomment `RUN apt-get ...` in [panda-noetic.Dockerfile](./panda-noetic.Dockerfile) if it is possible, or you should build from source following [this](https://frankaemika.github.io/docs/installation_linux.html#building-from-source).
   ```Dockerfile
   # Install libfranka and franka-ros
   USER root
   ## Uncomment the following lines if you can apt install libfranka
   RUN apt-get update && apt-get install --yes \
       ros-noetic-libfranka ros-noetic-franka-ros
   ```
 * Change your docker image name and container name in [env.sh](./env.sh)
   ```bash
   # Image Tag and Container Name
   export IMAGE_TAG="WiscHCI/panda-ros:${GIT_LABEL}"
   export CONTAINER_NAME="ros-panda-noetic"
   ```



## TODO ~~(TBD: lazy man)~~
Update to docker compose run and build (docker compose documents are unclear).