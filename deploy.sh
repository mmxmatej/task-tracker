#!/bin/bash
set -e

# Check if the task-tracker directory exists, and create it if not
if [ ! -d "/home/deployuser/task-tracker" ]; then
  echo "Directory /home/deployuser/task-tracker does not exist. Creating it."
  mkdir -p /home/deployuser/task-tracker
else
  echo "Directory /home/deployuser/task-tracker already exists."
fi

# Update and install Python
sudo apt-get update
sudo apt-get install -y python3 python3-pip

# Navigate to the deployment directory
cd /home/deployuser/task-tracker

# Install dependencies
pip3 install -r requirements.txt

# Run the application in the background
nohup python3 app.py > app.log 2>&1 &
echo "Task tracker app deployed and running on port 5000."
