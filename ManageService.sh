#!/bin/bash

service_name=$1
operation=$2

echo "from service manager $service_name $operation"

if [ "$service_name" == "daemon-reload" ]
then 

systemctl daemon-reload
echo "System daemon reloaded."

else

case $operation in
     'start' )
         sudo systemctl start $service_name
         echo "Service '$service_name' started."   
         ;;

     "restart" )
         sudo systemctl restart $service_name
         echo "Service '$service_name' restarted."
        ;;  

     "stop" )
         sudo systemctl stop $service_name
         echo "Service '$service_name' stopped."    
        ;;   
  esac
   
fi 
