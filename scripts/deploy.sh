#!/usr/bin/env bash

set -e

docker-compose up -d redis

docker rm -f $(docker ps -a | grep user-service | awk '{print $1}') || echo 'Not existed'
docker run -d --name user-service -p 8081:8081 -v $(pwd)/build/libs/:/app/build/libs -w /app java:8 /bin/bash -c "java -jar /app/build/libs/ols-core-server-0.0.1-SNAPSHOT.jar"

