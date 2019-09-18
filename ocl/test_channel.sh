cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_channel.impala -emit-llvm > hls_channels.dump
mv test_channel.cl test_channel_cl.cpp
vim -O test_channel_cl.cpp hls_channels.dump

cd ..
