#!/bin/bash

# Function to retrieve system information
get_system_information() {
    echo "System Information:"
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "CPU: $(lscpu | grep "Model name" | cut -d':' -f2 | sed 's/^[ \t]*//')"
    echo "Memory Total: $(grep MemTotal /proc/meminfo | awk '{print $2/1024}') MB"
    echo "Memory Free: $(grep MemFree /proc/meminfo | awk '{print $2/1024}') MB"
    echo "Disk Total: $(df -h / | awk 'NR==2 {print $2}')" # For the primary disk only
    echo "Disk Free: $(df -h / | awk 'NR==2 {print $4}')"  # For the primary disk only
    echo "Uptime: $(uptime -p)"
    if [ -f /etc/os-release ]; then
        VERSION_NAME=$(grep -E '^VERSION=' /etc/os-release | awk -F '"' '{print $2}')
        echo "Version Name: $VERSION_NAME"
    fi
}


# Function to display menu with system information
display_menu() {
    # Retrieve system 
    clear 
    
    get_system_information

    # It would be better if its called CSAScript
    
    echo -e "\e[1m\e[32m"  # greenish color
    
    echo " _________   _________   _____    _________             __        __   "
    echo " \_   ___ \ /   _____/  /  _  \  /   _____/ ___________|__|______/  |__"
    echo " /    \  \/ \_____  \  /  /_\  \ \_____  \_/ ___\_  __ \  \____ \   __/"
    echo ' \     \____/        \/    |    \/        \  \___|  | \/  |  |_> >  |     By InfoSecMastermind '
    echo '  \______  /_______  /\____|__  /_______  /\___  >__|  |__|   __/|__|  '
    echo "         \/        \/         \/        \/     \/         |__|         "

    echo
    echo -e "\e[2m\e[33mCore System Administration Script: User Management, Backups, System Monitoring, and more\e[0m"  # Dim yellow color
    echo "-----------------------------------------------------------------------------------------"
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
    echo "3. Make Current User a Sudoer"
    echo "4. Make User a Sudoer"
    echo "5. Remove User from Sudoers"
    echo "6. Delete User Account"
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
           read -p "Do you want to make $new_username a sudoer? (y/n): " sudo_choice
           if [[ $sudo_choice == "y" || $sudo_choice == "Y" ]]; then
               sudo usermod -aG sudo $new_username
               sudo sh -c "echo '$new_username ALL=(ALL) ALL' >> /etc/sudoers"
           fi
           ;;
        3) echo "Making current user sudoer..."
           echo
           sudo sh -c "echo '$USER ALL=(ALL) ALL' >> /etc/sudoers"
           echo "User $USER is now a sudoer."
           ;;
        4) echo "Making user sudoer..."
           echo
           read -p "Enter the username of the user to make sudoer: " sudoer_username
           sudo usermod -aG sudo $sudoer_username
           sudo sh -c "echo '$sudoer_username ALL=(ALL) ALL' >> /etc/sudoers"
           ;;
        5) echo "Removing user from sudoers..."
           echo
           read -p "Enter the username of the user to remove from sudoers: " remove_sudoer_username
           sudo sed -i "/$remove_sudoer_username/d" /etc/sudoers
           echo "User $remove_sudoer_username removed from sudoers."
           ;;
        6) echo "Deleting user account..."
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
    echo "2. View Kernel Messages"
    echo "3. Search Log Entries"
    read -p "Enter your choice: " choice
    case $choice in
        1) echo "Viewing system logs..."
           # Add command to view system logs
           cat /var/log/syslog
           ;;
        2) echo "Viewing kernel messages..."
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
