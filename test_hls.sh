#!/bin/bash
name=$1

if [ -z "$1" ]; then
    echo "No test name supplied"
    exit
fi

cd build

#clean up
if ls ./*${name}*.{dump,cpp} 1> /dev/null 2>&1; then
    echo "cleaning up..."
    rm *
fi

echo "Re-compiling and re-generating..."
impala ~/anydsl/runtime/platforms/impala/*.impala ../${name}.impala  -emit-llvm > hls_ir_${name}.dump
mv ${name}.hls ${name}_hls.cpp
vim -O ${name}_hls.cpp hls_ir_${name}.dump

cd ..
