#!/bin/bash

# Updates
sudo apt update
sudo apt upgrade

# Fire wall
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
# File Scanning
read -p "Do you want to scan home directories for files? (y/n): " answer

answer=${answer,,}

if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
    read -p "Enter file extensions to search for (separated by space, or press Enter for all files): " -a extensions

    ./scan_home_files.sh "${extensions[@]}"
else
    echo "Skipping home directory scan."
fi

# Set password rules
./scan_home_files.sh
