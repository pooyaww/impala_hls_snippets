cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_single_kernel.impala -emit-llvm > hls_channels.dump
mv test_single_kernel.hls test_single_kernel.cpp
vim -O test_single_kernel.cpp hls_channels.dump

cd ..
