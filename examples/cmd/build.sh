#!/bin/sh

IMAGE_NAME="cmd-demo"
CONTAINER_NAME=${IMAGE_NAME}

docker container rm ${CONTAINER_NAME}
docker rmi ${IMAGE_NAME}
docker build -t ${IMAGE_NAME} .

echo "==== docker images list ===="
docker images | grep ${IMAGE_NAME}

echo "==== run docker container ===="
# 为了配合Dockerfile中的CMD指令，这里不能用如下方式启动container
# docker run -it --name ${IMAGE_NAME} ${CONTAINER_NAME} sh

# 这样启动，就会执行Dockerfile中的CMD指令提供的命令
docker run --name ${IMAGE_NAME} ${CONTAINER_NAME}

