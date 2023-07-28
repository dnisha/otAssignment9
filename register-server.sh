#!/bin/bash

create_ssh_connection () {

awk -v sname=${SERVER_NAME} -v hostIP="$HOST" -v ruser="$USER" -v pfile="$PEM_FILE" '{gsub(/server_name/, sname); gsub(/host/, hostIP); gsub(/remote_user/, ruser); gsub(/pem_file/, pfile); print}' ${TEMPLATE_FILE} >> ${SSH_ALIAS_FILE}

}