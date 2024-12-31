#!/bin/bash
set -e

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
