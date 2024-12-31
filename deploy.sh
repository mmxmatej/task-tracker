#!/bin/bash
set -e

# Ensure the target directory exists
mkdir -p /home/deployuser/task-tracker

# Set correct permissions
sudo chown -R deployuser:deployuser /home/deployuser/task-tracker

# Clone the GitHub repository
echo "Cloning the repository from Git..."
git clone https://$GitHubUsername:$GitHubToken@github.com/$GitHubUsername/task-tracker.git /home/deployuser/task-tracker

# Navigate to the task-tracker directory
cd /home/deployuser/task-tracker

# Run the application (adjust this to your app's start command)
nohup python3 app.py > app.log 2>&1 &
echo "Task tracker app deployed and running."
