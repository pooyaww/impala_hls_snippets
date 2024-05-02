#!/bin/bash
basename=$1

name="${basename%.*}"
echo $name

if [[ -v INTERFACE ]]; then
    intfc="${INTERFACE}"
elif [[ -v ANYDSL_FPGA ]]; then
    intfc="${ANYDSL_FPGA}"
else
    intfc="HPC"
fi

fast_emu="fast_emu"
sim_data="use_sim_data"
iteration="iteration=15"

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
artic --log-level warn --hls-flags ${intfc},${fast_emu},${sim_data},${iteration} ../${name}.art --emit-llvm -o ${name} > hls_host_ir_${name}.dump

if [[ $2 == "cf" ]] && [[ -z "$3" ]] && [[ -z "$4" ]]; then
    vim -O ${name}.cfg
elif [[ $2 == "d" ]] && [[ -z "$3" ]] && [[ -z "$4" ]]; then
    mv ${name}.cxx ${name}.cpp
    vim -O hls_host_ir_${name}.dump ${name}.cpp
elif [[ $2 == "i" ]] && [[ -z "$3" ]] && [[ -z "$4" ]]; then
    vim hls_host_ir_${name}.dump
elif [[ $2 == "hls" ]] && [[ $3 == "cgra" ]] && [[ -z "$4" ]] ; then
    mv ${name}.cxx ${name}_cgra.cpp
    mv ${name}.hls ${name}_hls.cpp
    vim -O ${name}.ll hls_host_ir_${name}.dump ${name}_hls.cpp ${name}_cgra.cpp
elif [[ $2 == "h" ]] && [[ -z "$3" ]] && [[ -z "$4" ]]; then
    vim -O ${name}.ll hls_host_ir_${name}.dump
elif [[ $2 == "d" ]] && [[ $3 == "h" ]] && [[ -z "$4" ]]; then
    mv ${name}.cxx ${name}.cpp
    vim -O ${name}.ll hls_host_ir_${name}.dump ${name}.cpp
elif [[ $2 == "d" ]] && [[ $3 == "h" ]] && [[ $4 == "c" ]]; then
    mv ${name}.cxx ${name}.cpp
    vim -O ../${name}.art ${name}.ll hls_host_ir_${name}.dump ${name}.cpp
elif [[ -z "$2" ]] && [[ -z "$3" ]] && [[ -z "$4" ]]; then
    mv ${name}.cxx ${name}_cgra.cpp
    mv ${name}.hls ${name}_hls.cpp

    count=`ls -1 *.cl 2>/dev/null | wc -l`
    if [[ $count != 0 ]]; then
        echo "OpenCL kernel found!"
        mv ${name}.cl ${name}_cl.cpp
        vim -O ${name}.ll hls_host_ir_${name}.dump ${name}_hls.cpp ${name}.cfg ${name}_cgra.cpp ${name}_cl.cpp -c ":tabnew ../${name}.art | tabfirst"
    else
        vim -O ${name}.ll hls_host_ir_${name}.dump ${name}_hls.cpp ${name}.cfg ${name}_cgra.cpp ${name}_graph.cxx  -c ":tabedit ../${name}.art | tabfirst" 
    fi
else
    echo "ERROR!
    i --> Thorin IR
    d --> hls decvice
    h --> host
    c --> source code
    cf --> cgra config code
    hls cgra --> hls and cgra device code"
fi

cd ..
