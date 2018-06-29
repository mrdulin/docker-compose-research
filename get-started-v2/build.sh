#!/bin/bash

IMAGE_NAME="friendlyhello"

docker container stop ${IMAGE_NAME}
docker container rm ${IMAGE_NAME}
docker rmi ${IMAGE_NAME} -f
docker build -t ${IMAGE_NAME} .

echo '==== Run the app ==='
docker run -d -p 4000:80 ${IMAGE_NAME}