#!/bin/bash

# Function to retrieve system information
get_system_information() {
    # Command to retrieve system information
    # You can replace this with any command or script that retrieves system information
    echo "System Information:"
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "CPU: $(lscpu | grep "Model name" | cut -d':' -f2 | sed 's/^[ \t]*//')"
    echo "Memory: $(grep MemTotal /proc/meminfo | awk '{print $2}') kB"
    echo "Disk Usage: $(df -h | awk '$NF == "/" { print $3 }')"
    echo "Uptime: $(uptime -p)"
}

# Function to display menu with system information
display_menu() {
    # Retrieve system information
    get_system_information

    # Clear the screen and display menu options
    # It would be better if its called CSAScript
    clear
    echo -e "\e[1m\e[96m"  # Bold cyan color
    echo
    echo "     _________                    __________               _____        ___       __         _________             __        __  "
    echo "    / ________\ __ _______  ____ /    _____/__.__. _____  /  _  \    __| _/_____ |__| ____  /   _____/ ___________|__|______/  |_ "
    echo "   /    \     /  _ \_  __ \/ __ \ \_____  <   |  |/  ___//  /_\  \  / __ |/     \|  |/    \ \_____  \_/ ___\_  __ \  \____ \   __\\"
    echo "   \     \___(  <_> )  | \|  ___/ /        \___  |\___ \/    |    \/ /_/ |  Y Y  \  |   |  \/        \  \___|  | \/  |  |_> >  |       By InfoSecMastermind "
    echo "    \______  /\____/|__|   \___  >_______  / ____/____  >____|__  /\____ |__|_|  /__|___|  /_______  /\___  >__|  |__|   __/|__|  "
    echo "           \/                  \/        \/\/         \/        \/      \/     \/        \/        \/     \/         |__|         "


    echo
    echo -e "\e[2m\e[33mLinux Management Tool: User Management, System Monitoring, and more\e[0m"  # Dim yellow color
    echo "----------------------------------------------------------------------------------"
    echo
    echo -e " \e[1;33m1.\e[0m User Management"
    echo -e " \e[1;33m2.\e[0m System Monitoring"
    echo -e " \e[1;33m3.\e[0m Log Analysis"
    echo -e " \e[1;33m4.\e[0m Backup and Recovery"
    echo -e " \e[1;33m5.\e[0m Exit"
    echo
}

# Function for user management
user_management() {
    echo "User Management"
    echo "---------------"
    echo "1. View User Accounts"
    echo "2. Add New User"
    echo "3. Modify User Account"
    echo "4. Delete User Account"
    read -p "Enter your choice: " choice
    case $choice in
        1) echo "Viewing user accounts..."
           echo
           cat /etc/passwd | cut -d: -f1
           ;;
        2) echo "Adding new user..."
           echo
           read -p "Enter the username of the new user: " new_username
           sudo adduser $new_username
           ;;
        3) echo "Modifying user account..."
           echo
           read -p "Enter the username of the user to modify: " modify_username
           read -p "Enter the new group for the user: " new_group
           sudo usermod -aG $new_group $modify_username
           ;;
        4) echo "Deleting user account..."
           echo
           read -p "Enter the username of the user to delete: " delete_username
           sudo deluser $delete_username
           ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    read -p "Press Enter to continue"
}


# Function for system monitoring
system_monitoring() {
    echo "System Monitoring"
    echo "-----------------"
    echo "1. View System Resources"
    echo "2. View Running Processes"
    echo "3. Check Disk Space Usage"
    read -p "Enter your choice: " choice
    case $choice in
        1) echo "Viewing system resources..."
           # Add command to view system resources
           echo "Hostname: $(hostname)"
           echo "Kernel: $(uname -r)"
           echo "CPU: $(lscpu | grep "Model name" | cut -d':' -f2 | sed 's/^[ \t]*//')"
           echo "Memory: $(grep MemTotal /proc/meminfo | awk '{print $2}') kB"
           echo "Uptime: $(uptime -p)"
           ;;
        2) echo "Viewing running processes..."
           # Add command to view running processes
           ps aux
           ;;
        3) echo "Checking disk space usage..."
           # Add command to check disk space usage
           df -h
           ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    read -p "Press Enter to continue"
}

# Function for log analysis
log_analysis() {
    echo "Log Analysis"
    echo "------------"
    echo "1. View System Logs"
    echo "2. View Kernel Messages (dmesg)"
    echo "3. Search Log Entries"
    read -p "Enter your choice: " choice
    case $choice in
        1) echo "Viewing system logs..."
           # Add command to view system logs
           cat /var/log/syslog
           ;;
        2) echo "Viewing kernel messages (dmesg)..."
           # Add command to view kernel messages
           dmesg
           ;;
        3) echo "Searching log entries..."
           # Add command to search log entries
           read -p "Enter search keyword: " keyword
           grep $keyword /var/log/syslog
           ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    read -p "Press Enter to continue"
}


# Function for backup and recovery
backup_recovery() {
    echo "Backup and Recovery"
    echo "-------------------"
    echo "1. Perform Backup"
    echo "2. Restore from Backup"
    read -p "Enter your choice: " choice
    case $choice in
        1) echo "Performing backup..."
           # Prompt user for source directory/file to backup
           read -p "Enter the source directory or file to backup: " source
           # Prompt user for destination path to store the backup
           read -p "Enter the destination path for the backup: " destination
           # Perform backup
           tar -czvf $destination/backup.tar.gz $source
           ;;
        2) echo "Restoring from backup..."
           # Prompt user for the location of the backup file
           read -p "Enter the path to the backup file: " backup_file
           # Prompt user for destination directory to restore to
           read -p "Enter the destination directory for restoring: " restore_location
           # Restore from backup
           tar -xzvf $backup_file -C $restore_location
           ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    read -p "Press Enter to continue"
}


# Main script
while true; do
    display_menu
    read -p "Enter your choice number: " choice
    case $choice in
        1) user_management ;;
        2) system_monitoring ;;
        3) log_analysis ;;
        4) backup_recovery ;;
        5) echo "Exiting..."; exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
