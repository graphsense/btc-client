install:
	git clone --depth=1 -b v30.2 https://github.com/bitcoin/bitcoin.git src && \
	cd src && \
	cmake -B build -DENABLE_WALLET=OFF -DBUILD_UTIL=OFF -DTEST_UTIL=OFF -DBUILD_GUI=OFF -DENABLE_IPC=OFF && \
	cmake --build build && \
	cp build/bin/* /usr/local/bin/ && \
	ls -al /usr/local/bin/