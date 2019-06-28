install:
	git clone https://github.com/bitcoin/bitcoin.git src && \
	cd src && \
	git checkout tags/v0.18.0 -b local && \
	./autogen.sh && \
	./configure --without-gui --disable-zmq --disable-upnp-default --disable-tests --disable-wallet && \
	make install
