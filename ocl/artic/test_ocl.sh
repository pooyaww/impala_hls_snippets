#!/bin/bash
basename=$1

name="${basename%.*}"
echo $name

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
artic  ${ANYDSL_INSTALL}/runtime/platforms/artic/*.impala ../${name}.art > hls_ir_${name}.dump --emit-llvm -o ${name}
if [ $2 == "d" ]; then
    echo ${name}
    mv ${name}.cl ${name}_cl.cpp
    vim -O ${name}_cl.cpp hls_ir_${name}.dump
elif [ $2 == "h" ]; then
    vim -O ${name}.ll hls_ir_${name}.dump
else
    echo "ERROR!
        d --> Device cose
        h --> Host code"
fi
cd ..
