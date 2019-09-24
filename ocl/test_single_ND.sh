cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_single_ND.impala -emit-llvm > module.dump
mv test_single_ND.cl test_single_ND_cl.cpp
vim -O test_single_ND_cl.cpp module.dump

cd ..
