#!/bin/sh

docker container prune -f
docker rmi copy-demo-1
docker build -t copy-demo-1 .

echo "==== docker images list ===="
docker images | grep copy-demo-1

docker run -it --name copy-demo-1 copy-demo-1 sh 

