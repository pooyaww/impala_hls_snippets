cd build

#clean up
if [ -f ./*.dump -a -f ./*.cpp ]; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../test_pipeline.impala -emit-llvm > test_pipeline.dump
mv test_pipeline.cl test_pipeline_cl.cpp
vim -O test_pipeline_cl.cpp test_pipeline.dump

cd ..
