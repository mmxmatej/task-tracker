#!/bin/bash
set -e

# Check if the task-tracker directory exists, and create it if not
if [ ! -d "/home/deployuser/task-tracker" ]; then
  echo "Directory /home/deployuser/task-tracker does not exist. Creating it."
  mkdir -p /home/deployuser/task-tracker
else
  echo "Directory /home/deployuser/task-tracker already exists."
fi

# Set correct permissions for deployuser (assuming deployuser is the user running the script)
echo "Setting correct permissions for deployuser on /home/deployuser/task-tracker..."
sudo chown -R deployuser:deployuser /home/deployuser/task-tracker
sudo chmod -R 755 /home/deployuser/task-tracker

# Update and install Python
sudo apt-get update
sudo apt-get install -y python3 python3-pip

# Navigate to the deployment directory
cd /home/deployuser/task-tracker

# Run the application in the background
nohup python3 app.py > app.log 2>&1 &
echo "Task tracker app deployed and running on port 5000."
