install:
	git clone --depth=1 -b v0.21.1 https://github.com/bitcoin/bitcoin.git src && \
	cd src && \
	./autogen.sh && \
	./configure --without-gui --disable-zmq --disable-upnp-default --disable-tests --disable-wallet && \
	make install
