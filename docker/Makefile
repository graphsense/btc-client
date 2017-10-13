DB4VERSION=db-4.8.30.NC
DB4DIR=/usr/local/db4
DB4FILE=$(DB4VERSION).tar.gz
DB4URL=http://download.oracle.com/berkeley-db/$(DB4FILE)
DB4HASH=12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef

BUILDTOOLS=                    \
  build-essential              \
  wget                         \
  git                          \
  automake                     \
  autotools-dev                \
  bsdmainutils                 \

PACKAGES=                      \
  libboost-chrono-dev          \
  libboost-filesystem-dev      \
  libboost-program-options-dev \
  libboost-system-dev          \
  libboost-test-dev            \
  libboost-thread-dev          \
  libevent-dev                 \
  libminiupnpc-dev             \
  libprotobuf-dev              \
  libssl-dev                   \
  libtool                      \
  libzmq3-dev                  \
  pkg-config                   \
  protobuf-compiler            \

QTPACKAGES=                    \
  libqrencode-dev              \
  libqt5core5a                 \
  libqt5dbus5                  \
  libqt5gui5                   \
  qttools5-dev                 \
  qttools5-dev-tools           \

install-buildtools:
	apt-get -y install $(BUILDTOOLS)

install-dependencies:
	apt-get -y install $(PACKAGES)

install-qtdependencies:
	apt-get -y install $(QTPACKAGES)

all:
	if [ ! -f $(DB4FILE) ]; then \
		wget $(DB4URL); \
	fi && \
	echo $(DB4HASH) $(DB4FILE) | sha256sum -c && \
	rm -Rf $(DB4VERSION) && \
	tar -xzvf $(DB4FILE) && \
	cd $(DB4VERSION)/build_unix/ && \
	../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$(DB4DIR) && \
	mkdir -p $(DB4DIR) && \
	make install;
	if [ ! -d bitcoin ]; then \
		git clone https://github.com/bitcoin/bitcoin.git && \
		cd bitcoin && \
		CURRENT=`git tag | grep -P '^v[\d\.]+$$' | sort --version-sort | tail -1` && \
		git checkout tags/$$CURRENT -b local-$$CURRENT && \
		./autogen.sh && \
		./configure --without-gui --disable-upnp-default --disable-tests \
		LDFLAGS="-L$(DB4DIR)/lib/" CPPFLAGS="-I$(DB4DIR)/include/"; \
	fi

install: all
	cd bitcoin; \
	make install; \

clean:
	rm -Rf $(DB4DIR)
	rm -Rf bitcoin
	rm -Rf $(DB4VERSION)
	rm -f $(DB4FILE)
