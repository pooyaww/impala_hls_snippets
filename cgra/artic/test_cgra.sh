#!/bin/bash
basename=$1

name="${basename%.*}"
echo $name

if [[ -z ${ANYDSL_INSTALL} ]]; then
    echo "Please export or set ANYDSL_INSTALL"
    exit
fi

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
artic --hls-flags ${intfc} ${ANYDSL_INSTALL}/runtime/platforms/artic/*.impala ../${name}.art --emit-llvm -o ${name} > cgra_host_ir_${name}.dump
if [ $2 == "d" ] && [ -z "$3" ] && [ -z "$4" ]; then
    mv ${name}_graph.cxx ${name}.cpp
    vim -O cgra_host_ir_${name}.dump ${name}.cpp
elif [ $2 == "h" ] && [ -z "$3" ] && [ -z "$4" ]; then
    vim -O ${name}.ll cgra_host_ir_${name}.dump
elif [ $2 == "d" ] && [ $3 == "h" ] && [ -z "$4" ]; then
    mv ${name}.cgra ${name}.cpp
    vim -O ${name}.ll cgra_host_ir_${name}.dump ${name}.cpp
elif [ $2 == "d" ] && [ $3 == "h" ] && [ $4 == "c" ]; then
    mv ${name}.cgra ${name}.cpp
    vim -O ../${name}.art ${name}.ll cgra_host_ir_${name}.dump ${name}.cpp
else
    echo "ERROR!
    d --> decvice
    h --> host
    c --> source code"
fi

cd ..
