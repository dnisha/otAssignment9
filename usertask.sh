#!/bin/bash

create_user() {
    username=$1
    sudo adduser $username
    echo "$username"
    echo "User $username created successfully."
}

delete_user() {
    username=$1
    sudo userdel -r $username  
    echo "User '$username' deleted successfully."
}

modify_user() {
    username=$1
    attribute=$2
    value=$3

    case $attribute in
        "group")
            sudo usermod -g $value $username
            echo "User '$username' group modified to '$value'."
            ;;
        "shell")
            sudo usermod -s $value $username
            echo "User '$username' shell modified to '$value'."
            ;;
        *)
            echo "Invalid attribute. Supported attributes are 'group' and 'shell'."
            ;;
    esac
}

task=$1
action=$2
username=$3
attribute=$4
value=$5
case $task in
        "user")
            case $action in
                "create")
                    echo "$username"
		    create_user $username
                    ;;
                "delete")
                    delete_user $username
                    ;;
                "modify")
                    if [ -z "$attribute" ] || [ -z "$value" ]; then
                        echo "For 'modify' task, both 'attribute' and 'value' are required."
                        exit 1
                    fi
                    modify_user $username $attribute $value
                    ;;
                *)
                    echo "Invalid action. Supported actions are 'create', 'delete', and 'modify'."
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo "Invalid task. Supported tasks are 'user'."
            exit 1
            ;;
    esac
#done 







