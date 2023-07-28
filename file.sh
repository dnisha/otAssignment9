#!/bin/bash

IS_FILE_OR_DIR=$1
OPERATION=$2
FILE_OR_DIR=$3
SOURCE=$4

if [ "${IS_FILE_OR_DIR}" == "file" ] || [ "${IS_FILE_OR_DIR}" == "directory" ]; then

    if [ "${OPERATION}" == "create" ] && [ "${IS_FILE_OR_DIR}" == "file" ]; then
        touch "${FILE_OR_DIR}"
            
    elif [ "${OPERATION}" == "delete" ] && [ "${IS_FILE_OR_DIR}" == "file" ]; then
        rm "${FILE_OR_DIR}"

    elif [ "${OPERATION}" == "create" ] && [ "${IS_FILE_OR_DIR}" == "directory" ]; then
        mkdir "${FILE_OR_DIR}"

    elif [ "${OPERATION}" == "delete" ] && [ "${IS_FILE_OR_DIR}" == "directory" ]; then
        rm -rf "${FILE_OR_DIR}"
    fi

elif [ "${IS_FILE_OR_DIR}" == "copy" ]; then

    cp "${SOURCE}" "${FILE_OR_DIR}"
fi
