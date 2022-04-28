#!/bin/bash

# Configiration
STANDALONE=./standalone
INVALID=./invalid
FRONTEND=impala

# prints colored text
print_style () {

    if [ "$3" == "info" ] ; then
        COLOR="96m";
    elif [ "$3" == "success" ] ; then
        COLOR="92m";
    elif [ "$3" == "warning" ] ; then
        COLOR="93m";
    elif [ "$3" == "danger" ] ; then
        COLOR="91m";
    else #default color
        COLOR="0m";
    fi

    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "%s ..... $STARTCOLOR%b$ENDCOLOR" "$1" "$2\n";
}

if [[ -z ${ANYDSL_INSTALL} ]]; then
    echo "Please export or set ANYDSL_INSTALL"
    exit
fi

mkdir -p -v build

if [ ${FRONTEND} == "artic" ]; then
    EXTENSION=art
    CONFIG="--max-error 1"
else
    EXTENSION=impala
fi

declare -A Name2Result
TestArray=( *.${EXTENSION} )
sa_test_array_addr=(./standalone/*.${EXTENSION})
invalid_test_array_addr=(./invalid/*.${EXTENSION})
for TEST in "${sa_test_array_addr[@]}"; do
    test_no_ext=${TEST%.${EXTENSION}};
    test_no_ext_no_addr=${test_no_ext##*/};
    sa_test_array+=(${test_no_ext_no_addr});
done

for TEST in "${invalid_test_array_addr[@]}"; do
    invalid_test_no_ext=${TEST%.${EXTENSION}};
    invalid_test_no_ext_no_addr=${invalid_test_no_ext##*/};
    invalid_test_array+=(${invalid_test_no_ext_no_addr});
done

if [[ -v INTERFACE ]]; then
    intfc="${INTERFACE}"
elif [[ -v ANYDSL_FPGA ]]; then
    intfc="${ANYDSL_FPGA}"
else
    intfc="HPC"
fi

cd build

#clean up
if ls ./*${name}*.{dump,cpp} 1> /dev/null 2>&1; then
    echo "cleaning up..."
    rm *
fi

echo "Compiling all test cases ..."

for TEST in "${TestArray[@]}"
do
    NAME=${TEST%.${EXTENSION}}
    ${FRONTEND} --hls-flags ${intfc} ${ANYDSL_INSTALL}/runtime/platforms/${FRONTEND}/*.impala ../${NAME}.${EXTENSION} ${config} --emit-llvm -o ${NAME} > hls_host_ir_${name}.dump
    RESULT=$?
    Name2Result+=([${NAME}]=${RESULT})
done

for TEST in "${sa_test_array[@]}"
do
    NAME=${TEST%.${EXTENSION}}
    ${FRONTEND} --hls-flags ${intfc} ../${STANDALONE}/${NAME}.${EXTENSION} ${config} --emit-llvm -o ${NAME} > hls_host_ir_${name}.dump
    RESULT=$?
    Name2Result+=([${NAME}]=${RESULT})
done


for TEST in "${invalid_test_array[@]}"
do
    NAME=${TEST%.${EXTENSION}}
    ${FRONTEND} --hls-flags ${intfc} ${ANYDSL_INSTALL}/runtime/platforms/${FRONTEND}/*.impala ../${INVALID}/${NAME}.${EXTENSION} ${config} --emit-llvm -o ${NAME} > hls_host_ir_${name}.dump
    RESULT=!$?
    Name2Result+=([${NAME}]=${RESULT})
done

for NAME in "${!Name2Result[@]}"
do
    #echo -n "${NAME}, "
    if [[ ${Name2Result[$NAME]} -eq 0 ]]; then
        print_style "${NAME}" "Successful!" "success";
    else
        print_style "${NAME}" "Failed!🤬" "danger";
    fi
    #echo -n "Name  : $KEY, "
    #echo "Result: ${Name2Result[$KEY]}"
done | column -t

cd ..
