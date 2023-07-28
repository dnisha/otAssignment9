### Create a utility which will take inventory file and Task file as an input and perform tasks mentioned in Task file

Inventory file Example
inventory_file 
```
server1,ubuntu,10.0.0.1,~/server1.pem
server2,ubuntu,10.0.0.6,~/server2.pem
server3,ubuntu,10.0.0.7,~/server2.pem
webserver1,ubuntu,10.0.0.2,~/web.pem
webserver2,ubuntu,10.0.0.3,~/web.pem
appserver1,ubuntu,10.0.0.4,~/app.pem
appserver2,ubuntu,10.0.0.5,~/app.pem
 ```
### this script required following arguuments
```
./SystemManager.sh -i <inventory_file> -t <task_file>
```
## create a  utility to manage users. It should cover below functionalities:-
- User creation
- User deletion
- User modification

user.task    
```
server1,user,create,neha  
server1,user,create,nitish 
server1,user,modify,group,devops,nitish
server1,user,modify,shell,/bin/bash,nitish
server1,user,delete,neha
```
    

### Update the utility to manage groups. It should cover below functionalities:-
- Group creation
- Group deletion
- Group modification

group.task
```
server1,group,create,qa
server1,group,create,devops    
server1,group,user,nitish,qa 
server1,group,user,nitish,devops
server1,group,delete,qa
```
### Update the utility to manage files. It should cover below functionalities:-
- File creation, modification, deletion
- Directory creation, modification, deletion
- Copy file from one location to another

task.file
```
server2,file,create,/opt/file.txt
server2,file,delete,/opt/file.txt 
server2,directory,create,/opt/dir1 
server2,directory,delete,/opt/dir1
server2,copy,/tmp/file.txt,/opt/
```

### Update the utility to manage packages. It should cover below functionalities:-
- Package installation,uninstallation
- Repository update
- It should support RedHat and Debian family OS.


package.task   
```
server1,install,nginx
server1,install,tree
server2,install,nginx
server2,uninstall,nginx
server3,update
```

### Update the utility to manage services. It should cover below functionalities:-
- Service start, restart, stop
- Systemd daemon reload
```
appserver1,service,tomcat,start  
appserver1,service,tomcat,stop
appserver1,service,daemon-reload
appserver2,service,tomcat,restart
appserver2,service,nginx,start  
appserver2,service,nginx,stop
appserver2,service,daemon-reload
appserver2,service,nginx,restart

```
Good To Do:

NginxTaskfile example
```
    webserver1,install,nginx
    webserver2,install,nginx
    webserver1,copy,/tmp/opstree.conf,/etc/nginx/site-available/opstree.conf
    webserver2,copy,/tmp/opstree.com,/etc/nginx/site-available/opstree.conf
    webserver1,service,nginx,restart
    webserver2,service,nginx,restart
```
TomcatTaskfile example
```
    appserver1,download,https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/bin/apache-tomcat-6.0.53.tar.gz,/tmp/
    appserver1,directory,create,/opt/tomcat/
    appserver1,extract,/tmp/apache-tomcat-8.5.51.tar.gz,/opt/tomcat/
    appserver1,user,create,tomcat
    appserver1,group,create,tomcat
    appserver1,copy,/tmp/tomcat.service,/etc/systemd/system/tomcat.service
    appserver1,service,daemon-reload
    appserver1,service,tomcat,start
    appserver1,deploy,sorucepath/*.war,/opt/tomcat/webapps/
    appserver1,service,tomcat,restart
    appserver2,download,https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz,/tmp/
    appserver1,directory,create,/opt/tomcat/
    appserver2,extract,apache-tom  cat-8.5.51.tar.gz,/opt/tomcat/
    appserver2,user,create,tomcat
    appserver2,group,create,tomcat
    appserver2,copy,/tmp/tomcat.service,/etc/systemd/system/tomcat.service
    appserver2,service,daemon-reload
    appserver2,service,tomcat,start
    appserver2,deploy,sorucepath/*.war,/opt/tomcat/webapps/
    appserver2,service,tomcat,restart
```


ssh user@remote_host 'bash -s' < your_script.sh
