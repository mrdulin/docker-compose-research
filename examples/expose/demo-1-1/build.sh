#!/bin/sh

IMAGE_NAME="expose-demo-1-1"

docker container stop ${IMAGE_NAME}
docker container rm ${IMAGE_NAME}
docker rmi ${IMAGE_NAME}
docker build -t ${IMAGE_NAME} .

echo "==== docker images list ===="
docker images | grep ${IMAGE_NAME}

docker run -d -p 3001:3000 --name ${IMAGE_NAME} ${IMAGE_NAME}

