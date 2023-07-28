#!/bin/bash

# Function to create a new group
create_group() {
    groupname=$1
   sudo groupadd $groupname
    echo "Group '$groupname' created successfully."
}

# Function to delete an existing group
delete_group() {
    groupname=$1
    sudo groupdel $groupname
    echo "Group '$groupname' deleted successfully."
}

# Function to add a user to a group
add_user_to_group() {
    username=$2
    groupname=$1
    sudo usermod -a -G $groupname $username
    echo "User '$username' added to group '$groupname'."
}

# Main script
#while IFS=',' read -r server task action name group; do
task=$1
action=$2
name=$3
user=$4

case $task in
        "group")
            case $action in
                "create")
                    create_group $name
                    ;;
                "delete")
                    delete_group $name
                    ;;
                "usertogroup" )
                    add_user_to_group $name $user
                    ;;
                *)
                    echo "Invalid action. Supported actions are 'create', 'delete', and 'user'."
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo "Invalid task. Supported tasks are 'group'."
            exit 1
            ;;
    esac
#done < group.task






