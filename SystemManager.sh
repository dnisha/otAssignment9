#!/bin/bash

source ./package.sh

INVENTORY_FILE=""
TASK_FILE=""
SYSTEM=""
FILE=""
INVENTORY_FILE_NAME=""
TASK_FILE_NAME=""

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

main () {
    get_file_names ${FILE}

    echo "inventory file name ${INVENTORY_FILE_NAME}"
    echo "inventory file name ${TASK_FILE_NAME}"
    cat $INVENTORY_FILE
    cat $TASK_FILE

}

get_file_names () {

  if [ ${FILE} == "inventory_file" ]; then
    INVENTORY_FILE_NAME=${FILE}
  else
    TASK_FILE_NAME=${FILE}
  fi
}

remote_system_calling_with_task () {

     case ${SYSTEM} in
   "server1")
      echo "calling server1"
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
    "appserver1")
      echo "calling appserver1"
      ;;
    "appserver2")
      echo "calling appserver2"
      ;;
   *)
     Default "system doesnot exist"
     ;;
esac
}

main