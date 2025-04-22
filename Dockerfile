FROM alpine:3.20
LABEL org.opencontainers.image.title="btc-client"
LABEL org.opencontainers.image.maintainer="contact@ikna.io"
LABEL org.opencontainers.image.url="https://www.ikna.io/"
LABEL org.opencontainers.image.description="Dockerized Bitcoin client"
LABEL org.opencontainers.image.source="https://github.com/graphsense/btc-client"

ARG UID=10000

RUN apk --no-cache add make bash boost boost-program_options libevent libressl shadow && \
    useradd -r -u $UID dockeruser &&  \
    mkdir -p /opt/graphsense/data && \
    chown -R dockeruser /opt/graphsense

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
        cmake \
        grep && \
    cd /tmp; make install && \
    rm -rf /tmp/src && \
    strip /usr/local/bin/*bitcoin* && \
    apk del build-dependendencies

USER dockeruser
CMD ["bitcoind", "-conf=/opt/graphsense/client.conf", "-datadir=/opt/graphsense/data", "-rest"]
