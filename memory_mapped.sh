cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../memory_mapped.impala -emit-llvm > hls_channels.dump
mv memory_mapped.hls memory_mapped.cpp
vim -O memory_mapped.cpp hls_channels.dump

cd ..
