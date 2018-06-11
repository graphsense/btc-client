FROM alpine:3.7
LABEL maintainer="rainer.stuetz@ait.ac.at"

RUN apk --no-cache add make bash boost boost-program_options libevent libressl shadow && \
    useradd -r -u 10000 dockeruser &&  \
    mkdir -p /opt/bitcoin/data && \
    chown dockeruser /opt/bitcoin

ADD docker/bitcoin.conf /opt/bitcoin/bitcoin.conf
ADD docker/Makefile /tmp/Makefile

RUN apk --no-cache --virtual build-dependendencies add \
        linux-headers \
        libressl-dev \
        g++ \
        boost-dev \
        file \
        autoconf \
        automake \
        libtool \
        libevent-dev \
        git \
        coreutils \
        binutils \
        grep && \
    cd /tmp; make install && \
    rm -rf /tmp/src && \
    strip /usr/local/bin/*bitcoin* && \
    apk del build-dependendencies

USER dockeruser
EXPOSE 8332

CMD bitcoind -conf=/opt/bitcoin/bitcoin.conf -datadir=/opt/bitcoin/data -daemon -rest && bash
