#!/bin/bash

source ./package.sh
source ./register-server.sh
source ./file.sh

INVENTORY_FILE=""
TASK_FILE=""
SYSTEM=""
FILE=""
INVENTORY_FILE_NAME=""
TASK_FILE_NAME=""
SSH_ALIAS_FILE="config"
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
    # echo "The provided argument $i is the file."
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

    echo "passed ${INVENTORY_FILE_NAME} as inventory file"
    echo "passed ${TASK_FILE_NAME} as task file"
    register_ssh_connection
    remote_system_calling_with_task

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

  #  echo "server name : ${SERVER_NAME} host : ${HOST} user : ${USER} pem : ${PEM_FILE}"

    if grep -q "${SERVER_NAME}" "config"; then
      echo "skiping server registration for ${SERVER_NAME}"
    else
      create_ssh_connection ${SERVER_NAME} ${HOST} ${USER} ${PEM_FILE} ${TEMPLATE_FILE} ${SSH_ALIAS_FILE}
    fi 
    


  done <${INVENTORY_FILE}

}

remote_system_calling_with_task () {

    while IFS= read -r line; do

    SYSTEM=$(echo $line | awk -F ',' '{print $1}')

    case ${SYSTEM} in
   "server1")
        # echo "calling server1"
        operations_on_remote ${TASK_FILE_NAME} ${SYSTEM} $line
      ;;
   "server2")
      # echo "calling server2"
      operations_on_remote ${TASK_FILE_NAME} ${SYSTEM} $line
      ;;
   "server3")
      # echo "calling server3"
      operations_on_remote ${TASK_FILE_NAME} ${SYSTEM} $line
      ;;
    "webserver1")
      # echo "calling webserver1"
      operations_on_remote ${TASK_FILE_NAME} ${SYSTEM} $line
      ;;
    "webserver2")
      # echo "calling webserver2"
      operations_on_remote ${TASK_FILE_NAME} ${SYSTEM} $line
      ;;
   "appserver2")
      # echo "calling appserver2"
      operations_on_remote ${TASK_FILE_NAME} ${SYSTEM} $line
      ;;
    "appserver1")
      # echo "calling appserver2"
      operations_on_remote ${TASK_FILE_NAME} ${SYSTEM} $line
      ;;
   *)
     Default "system doesnot exist"
     ;;
    esac

    done <${TASK_FILE}
}

handle_package_task () {
    SYSTEM=$1
    line=$2

    OPERATION=$(echo $line | awk -F ',' '{print $2}')
    BINARY=$(echo $line | awk -F ',' '{print $3}')
    ssh ${SYSTEM} "bash -s" -- ${OPERATION} ${BINARY} < package.sh  
}

handle_file_task () {
    SYSTEM=$1
    line=$2

    IS_FILE_OR_DIR=$(echo "$line" | awk -F ',' '{print $2}')
    OPERATION=$(echo "$line" | awk -F ',' '{print $3}')
    FILE_OR_DIR=$(echo "$line" | awk -F ',' '{print $4}')
    SOURCE=$(echo "$line" | awk -F ',' '{print $3}')

    if [ $IS_FILE_OR_DIR == "copy" ]; then
      scp $SOURCE $SYSTEM:$FILE_OR_DIR
    fi

    ssh ${SYSTEM} "bash -s" -- ${IS_FILE_OR_DIR} ${OPERATION} ${FILE_OR_DIR} ${SOURCE} < file.sh
}

handle_user () {
  SYSTEM=$1
  line=$2

  task=$(echo "$line" | awk -F ',' '{print $2}')
  action=$(echo "$line" | awk -F ',' '{print $3}')
  username=$(echo "$line" | awk -F ',' '{print $4}')
  attribute=$(echo "$line" | awk -F ',' '{print $4}')
  value=$(echo "$line" | awk -F ',' '{print $5}')

  ssh ${SYSTEM} "bash -s" -- ${task} ${action} ${username} ${attribute} ${value} < usertask.sh

}

handle_group () {
  SYSTEM=$1
  line=$2

  task=$(echo "$line" | awk -F ',' '{print $2}')
  action=$(echo "$line" | awk -F ',' '{print $3}')
  name=$(echo "$line" | awk -F ',' '{print $4}')
  user=$(echo "$line" | awk -F ',' '{print $5}')

  ssh ${SYSTEM} "bash -s" -- ${task} ${action} ${name} ${user} < grouptask.sh

}

handle_service_task () {
  SYSTEM=$1
  line=$2

  service_name=$(echo "$line" | awk -F ',' '{print $3}')
  operation=$(echo "$line" | awk -F ',' '{print $4}')

  # echo "got system as ${SYSTEM} and service name as $service_name for operation $operation"

  ssh ${SYSTEM} "bash -s" -- ${service_name} ${operation} < manageService.sh 
}

operations_on_remote () {
  if [ ${TASK_FILE_NAME} == "package.task" ]; then
    handle_package_task ${SYSTEM} $line
  elif [ ${TASK_FILE_NAME} == "task.file" ]; then
    handle_file_task ${SYSTEM} $line
  elif [ ${TASK_FILE_NAME} == "user.task" ]; then
    handle_user ${SYSTEM} $line
  elif [ ${TASK_FILE_NAME} == "group.task" ]; then
    handle_group ${SYSTEM} $line
  elif [ ${TASK_FILE_NAME} == "service.task" ]; then
    handle_service_task ${SYSTEM} $line
  fi
}

my_main
