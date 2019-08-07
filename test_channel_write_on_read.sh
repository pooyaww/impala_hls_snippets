cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_channel_write_on_read.impala -emit-llvm > hls_channels.dump
mv test_channel_write_on_read.hls test_channel_write_on_read.cpp
vim -O test_channel_write_on_read.cpp hls_channels.dump

cd ..
