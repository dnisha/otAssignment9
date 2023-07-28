#!/bin/bash
OPERATION=$1
BINARY=$2

echo "performing ${OPERATION} on ${BINARY}"

if [ "${OPERATION}" == "install" ]; then
    sudo apt install "${BINARY}" -y
elif [ "${OPERATION}" == "uninstall" ]; then
    sudo apt remove "${BINARY1}" -y
elif [ "${OPERATION}" == "update" ]; then
    sudo apt update -y 2>/dev/null
fi
