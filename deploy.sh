#!/bin/bash

# Define variables
APP_DIR="/var/www/system-info-app"
PYTHON_ENV_DIR="$APP_DIR/venv"

# Create application directory if it doesn't exist
if [ ! -d "$APP_DIR" ]; then
  sudo mkdir -p "$APP_DIR"
  echo "Created application directory at $APP_DIR"
fi

# Copy application files to the target directory
sudo cp -r * "$APP_DIR"
cd "$APP_DIR"

# Set up Python virtual environment if it doesn't exist
if [ ! -d "$PYTHON_ENV_DIR" ]; then
  python3 -m venv "$PYTHON_ENV_DIR"
  echo "Created Python virtual environment"
fi

# Activate virtual environment
source "$PYTHON_ENV_DIR/bin/activate"

# Install necessary dependencies
pip install --upgrade pip
pip install flask psutil

# Kill any app running on port 80
sudo fuser -k 80/tcp || true

# Start the app with elevated permissions for port 80
sudo nohup python app.py > app.log 2>&1 &

echo "System Info API is running on http://<your-server-ip>/info"
