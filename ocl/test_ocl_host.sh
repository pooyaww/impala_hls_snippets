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
impala ~/anydsl/runtime/platforms/*.impala ~/anydsl/runtime/src/*.impala ../${name}.impala -emit-llvm > hls_host_ir_${name}.dump

if [ $? -eq 0 ]; then
    vim -O ${name}.ll hls_host_ir_${name}.dump
    cd ..
else
    cd ..
    echo "🤔"
fi
