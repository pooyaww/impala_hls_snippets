cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_wo_channel.impala -emit-llvm > hls_channels.dump
mv test_wo_channel.hls test_wo_channel.cpp
vim -O test_wo_channel.cpp hls_channels.dump

cd ..