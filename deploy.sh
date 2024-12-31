#!/bin/bash
set -e

# Ensure the target directory exists
mkdir -p /home/deployuser/task-tracker

# Set correct permissions
sudo chown -R deployuser:deployuser /home/deployuser/task-tracker

# Clone the repository
echo "Cloning the repository from GitHub..."
git clone https://$GitHubUsername:$GitHubToken@github.com/$GitHubUsername/task-tracker.git /home/deployuser/task-tracker

# Navigate to the cloned directory
cd /home/deployuser/task-tracker

# List the files in the cloned repository to ensure they are there
echo "Listing files in the repository:"
ls -alh

# Check if app.py and requirements.txt are present
if [ -f "app.py" ] && [ -f "requirements.txt" ]; then
    echo "Files found: app.py and requirements.txt"
else
    echo "Files not found. Exiting..."
    exit 1
fi

# Run the application (adjust this to your app's start command)
nohup python3 app.py > app.log 2>&1 &
echo "Task tracker app deployed and running."
