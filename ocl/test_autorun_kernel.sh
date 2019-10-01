cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_autorun_kernel.impala -emit-llvm > hls_channels.dump
mv test_autorun_kernel.cl test_autorun_kernel_cl.cpp
vim -O test_autorun_kernel_cl.cpp hls_channels.dump

cd ..
