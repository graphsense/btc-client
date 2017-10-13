if ! [ -n $1 ] ; then
        echo "Please provide directory for blockchain data files."
fi

docker stop bitcoin
docker rm bitcoin
cp docker/bitcoin.conf $1
docker run --restart=always -d --name bitcoin \
	-p 8332:8332 \
	-v $1:/root/.bitcoin \
	-it bitcoin
docker ps -a
