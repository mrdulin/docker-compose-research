#!/bin/sh

IMAGE_NAME="entrypoint-demo-1-2"

docker container stop ${IMAGE_NAME}
docker container rm ${IMAGE_NAME}
docker rmi ${IMAGE_NAME}
docker build -t ${IMAGE_NAME} .

echo "==== docker images list ===="
docker images | grep ${IMAGE_NAME}


