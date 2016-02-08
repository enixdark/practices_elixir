#!bin/bash
if [ -d "deps/cowboy" ]; then
	wget -c https://github.com/ninenines/cowboy/archive/1.0.1.zip -O cowboy-1.0.1.zip 
	unzip cowboy-1.0.1.zip
	wget -c https://github.com/ninenines/cowlib/archive/1.0.1.zip -O cowlib-1.0.1.zip 
	cd deps/cowboy && make
	cd ../../
	rm -rf deps/cowboy/Makefile deps/cowboy/src deps/cowboy/doc deps/cowboy/deps/cowlib
	cp cowboy-1.0.1/Makefile deps/cowboy
	cp -r cowboy-1.0.1/src deps/cowboy
	cp -r cowboy-1.0.1/doc deps/cowboy
	unzip cowlib-1.0.1.zip 
	cp -r cowlib-1.0.1 deps/cowboy/deps/cowlib
	MIX_ENV=tets mix do deps.get, test
	rm -rf cowboy-1.0.1.zip cowlib-1.0.1.zip
fi

