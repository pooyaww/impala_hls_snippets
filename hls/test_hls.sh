#!/bin/bash

name=$1

if [[ -v INTERFACE ]]; then
    intfc="${INTERFACE}"
elif [[ -v ANYDSL_FPGA ]]; then
    intfc="${ANYDSL_FPGA}"
else
    intfc="HPC"
fi

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
impala --hls-flags ${intfc}  ~/Projects/anydsl/runtime/platforms/impala/*.impala ../${name}.impala --emit-llvm > hls_host_ir_${name}.dump 
if [ $2 == "d" ] && [ -z "$3" ] && [ -z "$4" ]; then
    mv ${name}.hls ${name}.cpp
    vim -O hls_host_ir_${name}.dump ${name}.cpp
elif [ $2 == "h" ] && [ -z "$3" ] && [ -z "$4" ]; then
    vim -O ${name}.ll hls_host_ir_${name}.dump
elif [ $2 == "d" ] && [ $3 == "h" ] && [ -z "$4" ]; then
    mv ${name}.hls ${name}.cpp
    vim -O ${name}.ll hls_host_ir_${name}.dump ${name}.cpp
elif [ $2 == "d" ] && [ $3 == "h" ] && [ $4 == "c" ]; then
    mv ${name}.hls ${name}.cpp
    vim -O ../${name}.impala ${name}.ll hls_host_ir_${name}.dump ${name}.cpp
else
    echo "ERROR!
    d --> decvice
    h --> host
    c --> source code"
fi

cd ..
