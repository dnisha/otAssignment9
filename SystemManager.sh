#!/bin/bash

source ./package.sh
source ./register-server.sh

INVENTORY_FILE=""
TASK_FILE=""
SYSTEM=""
FILE=""
INVENTORY_FILE_NAME=""
TASK_FILE_NAME=""
SSH_ALIAS_FILE="ssh-file"
TEMPLATE_FILE="ssh-alias-template"

while getopts "i:t:" opt; do
  case $opt in
    i)
      INVENTORY_FILE=$OPTARG
      file=$2
      ;;
    t)
      TASK_FILE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

for i in "$@"
do
  if [ -f $i ]; then
    echo "The provided argument $i is the file."
    FILE=$i

      if [ $i == "inventory_file" ]; then
        INVENTORY_FILE_NAME=${FILE}
      else
        TASK_FILE_NAME=${FILE}
      fi
  fi
done

my_main () {
    get_file_names ${FILE}

    echo "inventory file name ${INVENTORY_FILE_NAME}"
    echo "task file name ${TASK_FILE_NAME}"
    remote_system_calling_with_task
    #cat $INVENTORY_FILE
    #cat $TASK_FILE
}

get_file_names () {

  if [ ${FILE} == "inventory_file" ]; then
    INVENTORY_FILE_NAME=${FILE}
  else
    TASK_FILE_NAME=${FILE}
  fi
}

register_ssh_connection () {

while IFS= read -r line; do
    SERVER_NAME=$(echo "$line" | awk -F ',' '{print $1}')
    HOST=$(echo "$line" | awk -F ',' '{print $3}')
    USER=$(echo "$line" | awk -F ',' '{print $2}')
    PEM_FILE=$(echo "$line" | awk -F ',' '{print $4}')

    echo "server name ${SERVER_NAME} host ${HOST} user ${USER} pem: ${PEM_FILE}"
    create_ssh_connection ${SERVER_NAME} ${HOST} ${USER} ${PEM_FILE} ${TEMPLATE_FILE} ${SSH_ALIAS_FILE}


  done <${INVENTORY_FILE}

}

remote_system_calling_with_task () {

    while IFS= read -r line; do

    SYSTEM=$(echo $line | awk -F ',' '{print $1}')
    echo "found system for operation as : ${SYSTEM}"
     case ${SYSTEM} in
   "server1")
      echo "calling server1"
    #   ssh user@remote_host "bash -s" -- < package_operation.sh arg1 arg2 arg3
      ;;
   "server2")
      echo "calling server2"
      ;;
   "server3")
      echo "calling server3"
      ;;
    "webserver1")
      echo "calling webserver1"
      ;;
    "webserver2")
      echo "calling webserver2"
      ;;
   "appserver2")
      echo "calling appserver2"
      ;;
    "appserver1")
      echo "calling appserver2"
      ;;
   *)
     Default "system doesnot exist"
     ;;
    esac

    done <${INVENTORY_FILE}
}

handle_task () {

    case ${TASK_FILE_NAME} in
    "package.task  ")
      
        package_operation ${TASK_FILE}

      ;;
    esac
}

my_main
