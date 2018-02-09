#!/bin/bash -e
cd $WORKSPACE/docker
docker build -t webmail .

cd $WORKSPACE/ansible
ansible-playbook -i "localhost," -c local -e "imap_url=$imap_url imap_port=$imap_port" deploy.yml

webmail_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' webmail)

wait_for.sh -t 1800 $webmail_ip:80 -- echo "webmail is app"
