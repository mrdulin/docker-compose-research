# get started v2

docker 有两种运行模式:

- 单宿主机模式

- swarm(蜂群)模式

## 步骤

### 运行你的负载均衡应用

```bash
☁  get-started-v2 [master] ⚡  docker swarm init
Swarm initialized: current node (lrc07a8b8g41sj3zvwexcy35v) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5uew1knruxnjn3mqu2rojq1lnfog4dbvq7py62i2mplpq694g0-4wgb6vrue0utl60ypt9qbk8gl 192.168.65.3:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

```bash
☁  get-started-v2 [master] ⚡  docker stack deploy -c docker-compose.yml getstartedlab
Creating network getstartedlab_webnet
Creating service getstartedlab_web
```

```bash
☁  get-started-v2 [master] ⚡  docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                        PORTS
rj4solpjeuxr        getstartedlab_web   replicated          5/5                 novaline/get-started:part2   *:4000->80/tcp
```

列出 tasks:

```bash
☁  get-started-v2 [master] ⚡  docker service ps getstartedlab_web
ID                  NAME                  IMAGE                        NODE                    DESIRED STATE       CURRENT STATE           ERROR               PORTS
kezr2uxpy6pc        getstartedlab_web.1   novaline/get-started:part2   linuxkit-025000000001   Running             Running 2 minutes ago
pho5la984pb9        getstartedlab_web.2   novaline/get-started:part2   linuxkit-025000000001   Running             Running 2 minutes ago
0gwsvjzi5rs1        getstartedlab_web.3   novaline/get-started:part2   linuxkit-025000000001   Running             Running 2 minutes ago
7a7rqkl35d4n        getstartedlab_web.4   novaline/get-started:part2   linuxkit-025000000001   Running             Running 2 minutes ago
hbmyivcg5l6f        getstartedlab_web.5   novaline/get-started:part2   linuxkit-025000000001   Running             Running 2 minutes ago
```

浏览器访问`http://localhost:4000`，每次刷新后，由于负载均衡网络，页面上显示的`Hostname`(container ID)是不一样的

### 伸缩应用

修改`docker-compose.yml`中的`replicas`字段，执行`docker stack deploy`命令:

```bash
☁  get-started-v2 [master] ⚡  docker stack deploy -c docker-compose.yml getstartedlab
Updating service getstartedlab_web (id: rj4solpjeuxrbgmqmebk5hivg)
☁  get-started-v2 [master] ⚡  docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                        PORTS
rj4solpjeuxr        getstartedlab_web   replicated          3/3                 novaline/get-started:part2   *:4000->80/tcp
```

伸缩过程，不需要停止`stack`，也不需要`kill`任何`container`

### 停止应用和 swarm

- 停止应用

```bash
☁  get-started-v2 [master] ⚡  docker stack rm getstartedlab
Removing service getstartedlab_web
Removing network getstartedlab_webnet
```

- 停止 swarm

```bash
☁  get-started-v2 [master] ⚡  docker swarm leave -f
Node left the swarm.
```

### 设置你的 swarm

执行`docker swarm init`开启`swarm`模式，并使运行该命令的宿主机成为`swarm`管理者。在其他主机（可以是物理主机，也可以是虚拟机）运行`docker swarm join`将各自作为`worker`加入到`swarm`。

接下来使用虚拟机软件创建两个主机的集群，并将它们变成`swarm`。

使用`docker-machine`创建一组虚拟机，这些虚拟机使用 VirtualBox 驱动:

创建 vm1:

```bash
☁  get-started-v2 [master] ⚡  docker-machine create --driver virtualbox myvm1
Creating CA: /Users/ldu020/.docker/machine/certs/ca.pem
Creating client certificate: /Users/ldu020/.docker/machine/certs/cert.pem
Running pre-create checks...
(myvm1) Image cache directory does not exist, creating it at /Users/ldu020/.docker/machine/cache...
(myvm1) No default Boot2Docker ISO found locally, downloading the latest release...
(myvm1) Latest release for github.com/boot2docker/boot2docker is v18.05.0-ce
(myvm1) Downloading /Users/ldu020/.docker/machine/cache/boot2docker.iso from https://github.com/boot2docker/boot2docker/releases/download/v18.05.0-ce/boot2docker.iso...
(myvm1) 0%....10%....20%....30%....40%....50%....60%....70%....80%....90%....100%
Creating machine...
(myvm1) Copying /Users/ldu020/.docker/machine/cache/boot2docker.iso to /Users/ldu020/.docker/machine/machines/myvm1/boot2docker.iso...
(myvm1) Creating VirtualBox VM...
(myvm1) Creating SSH key...
(myvm1) Starting the VM...
(myvm1) Check network to re-create if needed...
(myvm1) Waiting for an IP...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with boot2docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env myvm1
```

创建 vm2:

```bash
☁  get-started-v2 [master] ⚡  docker-machine create --driver virtualbox myvm2
Running pre-create checks...
Creating machine...
(myvm2) Copying /Users/ldu020/.docker/machine/cache/boot2docker.iso to /Users/ldu020/.docker/machine/machines/myvm2/boot2docker.iso...
(myvm2) Creating VirtualBox VM...
(myvm2) Creating SSH key...
(myvm2) Starting the VM...
(myvm2) Check network to re-create if needed...
(myvm2) Waiting for an IP...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with boot2docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env myvm2
```

列出虚拟机和它们的 IP 地址:

```bash
☁  get-started-v2 [master] ⚡  docker-machine ls
NAME    ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
myvm1   -        virtualbox   Running   tcp://192.168.99.100:2376           v18.05.0-ce
myvm2   -        virtualbox   Running   tcp://192.168.99.101:2376           v18.05.0-ce
```

初始化 swarm，添加节点:

myvm1 是 swarm 管理者，可以执行管理命令和对加入到 swarm 的 worker 进行认证，myvm2 是 worker。

可以通过`docker-machine ssh`给虚拟机发送命令。

登录到`myvm1`，设置`myvm1`为 swarm 管理者

```bash
☁  get-started-v2 [master] ⚡  docker-machine ssh myvm1
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/
 _                 _   ____     _            _
| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
Boot2Docker version 18.05.0-ce, build HEAD : b5d6989 - Thu May 10 16:35:28 UTC 2018
Docker version 18.05.0-ce, build f150324
docker@myvm1:~$ docker swarm init --advertise-addr 192.168.99.100
Swarm initialized: current node (qciplvmrh6j758hs8mi8jyqdz) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-002x9ve85tv0jpodgd0y1244itb2knyr3b6j4qn6qiepl7yjx7-4p08k808lz9eqtqu1szdki3md 192.168.99.100:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

向 swarm 中添加 myvm2 作为 worker

```bash
☁  get-started-v2 [master] ⚡  docker-machine ssh myvm2 "docker swarm join --token SWMTKN-1-002x9ve85tv0jpodgd0y1244itb2knyr3b6j4qn6qiepl7yjx7-4p08k808lz9eqtqu1szdki3md 192.168.99.100:2377"
This node joined a swarm as a worker.
```

在 swarm 管理者（myvm1）上运行`docker node ls`命令，查看所有 swarm 节点

```bash
☁  get-started-v2 [master] ⚡  docker-machine ssh myvm1 'docker node ls'
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
qciplvmrh6j758hs8mi8jyqdz *   myvm1               Ready               Active              Leader              18.05.0-ce
5xxrbayq0n0068awdctneyifg     myvm2               Ready               Active                                  18.05.0-ce
```

### 将应用部署到 swarm 集群

#### 配置本地主机 shell

使用`docker-machine ssh`在虚拟机上执行命令有些麻烦，能否在本地主机的 shell 中给 swarm manager(myvm1 虚拟机) 发送命令呢？

```bash
☁  get-started-v2 [master] ⚡  docker-machine env myvm1
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/ldu020/.docker/machine/machines/myvm1"
export DOCKER_MACHINE_NAME="myvm1"
# Run this command to configure your shell:
# eval $(docker-machine env myvm1)
```

执行`eval $(docker-machine env myvm1)`，就设置好了本地主机的 shell。

#### 将应用部署到 swarm manager 上

```bash
☁  get-started-v2 [master] ⚡  docker stack deploy -c docker-compose.yml getstartedlab
Creating network getstartedlab_webnet
Creating service getstartedlab_web
```

查看 service:

```bash
☁  get-started-v2 [master] ⚡  docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                        PORTS
pwjxzu80q1vx        getstartedlab_web   replicated          3/3                 novaline/get-started:part2   *:4000->80/tcp
```

查看`getstartedlab_web` service 中的 tasks:

```bash
☁  get-started-v2 [master] ⚡  docker service ps getstartedlab_web
ID                  NAME                  IMAGE                        NODE                DESIRED STATE       CURRENT STATE                ERROR               PORTS
32c88logpvar        getstartedlab_web.1   novaline/get-started:part2   myvm2               Running             Running about a minute ago
3lpx3gotggi8        getstartedlab_web.2   novaline/get-started:part2   myvm1               Running             Running about a minute ago
meuwm1dhxeba        getstartedlab_web.3   novaline/get-started:part2   myvm2               Running             Running about a minute ago
```

需要注意的是，在`swarm`模式下，`getstartedlab` services（相关联的 containers）被部署到了虚拟机 myvm1 和 myvm2

#### 访问集群

查看集群中虚拟机 IP 地址：

```bash
☁  get-started-v2 [master] ⚡  docker-machine ls
NAME    ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
myvm1   *        virtualbox   Running   tcp://192.168.99.100:2376           v18.05.0-ce
myvm2   -        virtualbox   Running   tcp://192.168.99.101:2376           v18.05.0-ce
```

`docker-compose.yml`中通过`networks`创建了`webnet`网络，该网络被`myvm1`和`myvm2`共享，并具备负载均衡功能。在浏览器中或使用`curl`访问`http://192.168.99.100:4000/`，每次刷新浏览器，页面上显示的`Hostname`都会不同

除了通过修改`docker-compose.yml`文件中`service`的`replicas`字段伸缩应用的容器实例，还可以使用命令来伸缩应用的容器实例:

```bash
☁  ~  docker-machine ssh myvm1 'docker service scale getstartedlab_web=5'
getstartedlab_web scaled to 5
overall progress: 0 out of 5 tasks
1/5:
2/5:
3/5:
4/5:
5/5:
overall progress: 3 out of 5 tasks
overall progress: 3 out of 5 tasks
overall progress: 3 out of 5 tasks
overall progress: 3 out of 5 tasks
overall progress: 3 out of 5 tasks
overall progress: 3 out of 5 tasks
overall progress: 5 out of 5 tasks
verify: Waiting 5 seconds to verify that tasks are stable...
verify: Waiting 5 seconds to verify that tasks are stable...
verify: Waiting 5 seconds to verify that tasks are stable...
verify: Waiting 5 seconds to verify that tasks are stable...
verify: Waiting 5 seconds to verify that tasks are stable...
verify: Waiting 4 seconds to verify that tasks are stable...
verify: Waiting 4 seconds to verify that tasks are stable...
verify: Waiting 4 seconds to verify that tasks are stable...
verify: Waiting 4 seconds to verify that tasks are stable...
verify: Waiting 4 seconds to verify that tasks are stable...
verify: Waiting 3 seconds to verify that tasks are stable...
verify: Waiting 3 seconds to verify that tasks are stable...
verify: Waiting 3 seconds to verify that tasks are stable...
verify: Waiting 3 seconds to verify that tasks are stable...
verify: Waiting 3 seconds to verify that tasks are stable...
verify: Waiting 2 seconds to verify that tasks are stable...
verify: Waiting 2 seconds to verify that tasks are stable...
verify: Waiting 2 seconds to verify that tasks are stable...
verify: Waiting 2 seconds to verify that tasks are stable...
verify: Waiting 2 seconds to verify that tasks are stable...
verify: Waiting 1 seconds to verify that tasks are stable...
verify: Waiting 1 seconds to verify that tasks are stable...
verify: Waiting 1 seconds to verify that tasks are stable...
verify: Waiting 1 seconds to verify that tasks are stable...
verify: Waiting 1 seconds to verify that tasks are stable...
verify: Service converged
```

查看伸缩后的`service`:

```bash
☁  ~  docker-machine ssh myvm1 'docker service ls'
ID                  NAME                MODE                REPLICAS            IMAGE                        PORTS
pwjxzu80q1vx        getstartedlab_web   replicated          5/5                 novaline/get-started:part2   *:4000->80/tcp
```

查看`service`中的`tasks`:

```bash
☁  ~  docker-machine ssh myvm1 'docker service ps getstartedlab_web'
ID                  NAME                  IMAGE                        NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
32c88logpvar        getstartedlab_web.1   novaline/get-started:part2   myvm2               Running             Running 2 hours ago
3lpx3gotggi8        getstartedlab_web.2   novaline/get-started:part2   myvm1               Running             Running 2 hours ago
meuwm1dhxeba        getstartedlab_web.3   novaline/get-started:part2   myvm2               Running             Running 2 hours ago
nn1rnszvjwfv        getstartedlab_web.4   novaline/get-started:part2   myvm1               Running             Running 36 seconds ago
2ldbzm9wmx1b        getstartedlab_web.5   novaline/get-started:part2   myvm1               Running             Running 36 seconds ago
```

结果显示：`myvm1`上运行了 3 个`tasks`，`myvm2`上运行了 2 个`tasks`

查看`myvm1`上运行的对应于 3 个`tasks`的容器实例:

```bash
☁  ~  docker-machine ssh myvm1 'docker ps'
CONTAINER ID        IMAGE                        COMMAND             CREATED              STATUS              PORTS               NAMES
77a29e9823ce        novaline/get-started:part2   "python app.py"     About a minute ago   Up About a minute   80/tcp              getstartedlab_web.5.2ldbzm9wmx1bc0aloghtsqf5w
5dce76f5ca9e        novaline/get-started:part2   "python app.py"     About a minute ago   Up About a minute   80/tcp              getstartedlab_web.4.nn1rnszvjwfvbqc8jji2hxwtv
955a9467ab08        novaline/get-started:part2   "python app.py"     2 hours ago          Up 2 hours          80/tcp              getstartedlab_web.2.3lpx3gotggi8i14ui4lee7t8u
```

#### 向 swarm 中再次添加一个 work node

## 错误

```bash
☁  get-started-v2 [master] ⚡  bash ./build.sh
Error: No such container: friendlyhello
Error: No such image: friendlyhello
Sending build context to Docker daemon  5.632kB
Step 1/7 : FROM python:2.7-slim
Get https://registry-1.docker.io/v2/library/python/manifests/2.7-slim: unauthorized: incorrect username or password
```

解决：

```bash
☁  get-started-v2 [master] ⚡  docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username (novaline@qq.com): novaline
Password:
Login Succeeded
```

注意，`docker login`的`Username`不是邮箱，参考https://github.com/docker/hub-feedback/issues/935

## 参考链接

https://cloud.docker.com/swarm/novaline/dashboard/onboarding/cloud-registry

https://docs.docker.com/docker-cloud/

https://hub.docker.com/
