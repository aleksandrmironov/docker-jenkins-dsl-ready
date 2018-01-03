#!/bin/bash -e
cp tools/docker/Dockerfile app/
cd app && mvn package
docker build -t fetchr .
docker run -d -p 8080:8080 fetchr
