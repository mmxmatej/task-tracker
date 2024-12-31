#!/bin/bash
set -e

# Ensure task-tracker directory exists and has correct permissions
if [ ! -d "/home/deployuser/task-tracker" ]; then
  echo "Directory /home/deployuser/task-tracker does not exist. Creating it."
  mkdir -p /home/deployuser/task-tracker
else
  echo "Directory /home/deployuser/task-tracker already exists."
fi

# Set correct permissions for deployuser
echo "Setting correct permissions for deployuser on /home/deployuser/task-tracker..."
sudo chown -R deployuser:deployuser /home/deployuser/task-tracker
sudo chmod -R 755 /home/deployuser/task-tracker

# Install Python if it's not already installed
if ! command -v python3 &> /dev/null
then
    echo "Python is not installed. Installing Python..."
    sudo apt-get update
    sudo apt-get install -y python3
fi

# Clone the Git repository (if it isn't already cloned)
if [ ! -d "/home/deployuser/task-tracker/.git" ]; then
  echo "Cloning the repository from Git..."
  git clone https://$OctopusGitUsername:$OctopusGitToken@github.com/$GitHubUsername/task-tracker.git /home/deployuser/task-tracker
else
  echo "Repository already cloned."
fi

# Navigate to the deployment directory
cd /home/deployuser/task-tracker

# Checkout to the 'main' branch (in case it's not already there)
git checkout main

# Run the application in the background
nohup python3 app.py > app.log 2>&1 &
echo "Simple Python app deployed and running."

# Ensure app is listening on port 80
sleep 5
netstat -tuln | grep :80
