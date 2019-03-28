#!/bin/sh

IMAGE_NAME="copy-demo"

docker container prune -f
docker rmi ${IMAGE_NAME}
docker build -t ${IMAGE_NAME} .

echo "==== docker images list ===="
docker images | grep ${IMAGE_NAME}

echo "==== run docker container ===="
docker run -it --name ${IMAGE_NAME} ${IMAGE_NAME} sh

