#!/bin/bash
set -e

# Directory where the app will be cloned
APP_DIR="/home/deployuser/task-tracker"

# Ensure the target directory exists
echo "Creating directory $APP_DIR"
mkdir -p $APP_DIR

# Set correct permissions for deployuser
echo "Setting permissions for deployuser"
sudo chown -R deployuser:deployuser $APP_DIR

# Clone the repository
echo "Cloning the repository from GitHub..."
git clone https://mmxmatej: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@github.com/mmxmatej/task-tracker.git $APP_DIR

# Navigate to the app directory
cd $APP_DIR

# Install Python 3 and Flask
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y python3 python3-pip
pip3 install flask

# Run the app on port 80
echo "Running the Python app on port 80..."
# Use sudo to run the app on port 80 (requires root access)
sudo nohup python3 app.py > app.log 2>&1 &

echo "Python app deployed and running on port 80."
