#!/bin/bash
service_name=$2
operation=$3

if [ "$2" == "daemon-reload" ]
then 

systemctl daemon-reload
echo "System daemon reloaded."

else

case $3 in
     'start' )
         systemctl start $service_name
         echo "Service '$service_name' started."   
         ;;

     "restart" )
         systemctl restart $service_name
         echo "Service '$service_name' restarted."
        ;;  

     "stop" )
         systemctl stop $service_name
         echo "Service '$service_name' stopped."    
        ;;   
  esac
   
fi 
