FROM alpine:3.12
LABEL maintainer="contact@graphsense.info"

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
        grep && \
    cd /tmp; make install && \
    rm -rf /tmp/src && \
    strip /usr/local/bin/*bitcoin* && \
    apk del build-dependendencies

ADD docker/bitcoin.conf /opt/graphsense/bitcoin.conf

USER dockeruser
CMD ["bitcoind", "-conf=/opt/graphsense/bitcoin.conf", "-datadir=/opt/graphsense/data", "-rest"]
