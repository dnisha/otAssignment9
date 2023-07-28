#!/bin/bash

package_operation () {

    while IFS= read -r line; do
    OPERATION=$(echo "$line" | awk -F ',' '{print $2}')
    BINARY=$(echo "$line" | awk -F ',' '{print $3}')

        echo "performing ${OPERATION} on ${BINARY}"

        if [${OPERATION} == "install" ]; then
            sudo apt install ${BINARY} -y

        elif [ ${OPERATION} == "uninstall" ]; then
            sudo apt remove ${BINARY} -y
        
        else
            sudo apt update;
        fi
  
    done <${TASK_FILE}
    # echo "$USER"
}
