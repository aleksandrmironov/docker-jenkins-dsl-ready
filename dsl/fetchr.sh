#!/bin/bash -e
cp tools/docker/Dockerfile app/
cd app && mvn package
docker build -t fetchr .

if [ "$(docker ps -q -f name=fetchr)" ]; then
	#stop
	docker stop fetchr
    if [ "$(docker ps -aq -f status=exited -f name=fetchr)" ]; then
        # cleanup
        docker rm fetchr
    fi
    # run your container
fi

docker run -d --name fetchr -p 8080:8080 --restart=always fetchr

fetchr_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' fetchr)

wait_for.sh -t 1800 $fetchr_ip:8080 -- echo "fetchr is app"
