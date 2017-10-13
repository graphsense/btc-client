FROM debian:8
LABEL maintainer="mihai.bartha@ait.ac.at"

################## BEGIN INSTALLATION ######################
RUN apt-get update && apt-get install -y build-essential \
    wget \
    git \
    automake \
    autotools-dev \
    bsdmainutils \
    libboost-chrono-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libevent-dev \
    libminiupnpc-dev \
    libprotobuf-dev \
    libssl-dev \
    libtool \
    libzmq3-dev \
    pkg-config \
    protobuf-compiler

RUN mkdir -p /root/.bitcoin
ADD docker/bitcoin.conf /root/.bitcoin/bitcoin.conf

ADD docker/Makefile /root/Makefile
RUN cd /root; make install

VOLUME ["/root/.bitcoin"]
EXPOSE 8332

CMD bitcoind -daemon -rest && bash

##################### INSTALLATION END #####################
