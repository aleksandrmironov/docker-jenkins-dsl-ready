#!/bin/bash -e
cd app/docker
docker build -t webmail .

if [ "$(docker ps -q -f name=webmail)" ]; then
	#stop
	docker stop webmail
    if [ "$(docker ps -aq -f status=exited -f name=webmail)" ]; then
        # cleanup
        docker rm webmail
    fi
    # run your container
fi

docker run -d --name webmail -e ROUNDCUBEMAIL_DEFAULT_HOST=$imap_url -e ROUNDCUBEMAIL_DEFAULT_PORT=$imap_port -p 8080:8080 --restart=always webmail

webmail_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' webmail)

wait_for.sh -t 1800 $webmail_ip:8080 -- echo "webmail is app"
