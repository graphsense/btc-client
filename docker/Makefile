install:
	git clone --depth=1 -b v24.0 https://github.com/bitcoin/bitcoin.git src && \
	cd src && \
	./autogen.sh && \
	./configure --without-gui --disable-zmq --disable-upnp-default --disable-tests --disable-wallet && \
	make install
