cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_channel_read_on_write.impala -emit-llvm > hls_channels.dump
mv test_channel_read_on_write.hls test_channel_read_on_write.cpp
vim -O test_channel_read_on_write.cpp hls_channels.dump

cd ..
