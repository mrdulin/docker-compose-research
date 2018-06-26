#!/bin/sh

IMAGE_NAME="add-demo"

docker container prune -f
docker rmi ${IMAGE_NAME}
docker build -t ${IMAGE_NAME} .

echo "==== docker images list ===="
docker images | grep ${IMAGE_NAME}

docker run -it --name ${IMAGE_NAME} ${IMAGE_NAME} sh 

