#!/bin/bash

INVENTORY_FILE=""
TASK_FILE=""
SYSTEM=""

while getopts "i:t:" opt; do
  case $opt in
    i)
      INVENTORY_FILE=$OPTARG
      ;;
    t)
      TASK_FILE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

main () {

    cat $INVENTORY_FILE
    cat $TASK_FILE
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