
cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_kernel_order.impala -emit-llvm > hls_kernel_order.dump
mv test_kernel_order.hls test_kernel_order.cpp
vim -O test_kernel_order.cpp hls_kernel_order.dump

cd ..
