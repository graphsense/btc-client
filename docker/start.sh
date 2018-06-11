#!/bin/sh

if ! [ -n "$1" ] ; then
    echo "Please provide directory for blockchain data."
fi

docker stop bitcoin
docker rm bitcoin

chown -R dockeruser "$1"

docker run --restart=always -d --name bitcoin \
    -p 8332:8332 \
    -v "$1":/opt/graphsense/data \
    -it bitcoin
docker ps -a
