#!/bin/bash

# Define variables
APP_DIR="/var/www/system-info-app"
PYTHON_ENV_DIR="$APP_DIR/venv"

# Create application directory and fix permissions
sudo mkdir -p "$APP_DIR"
sudo chown -R $USER:$USER "$APP_DIR"

# Copy application files to the target directory
cp -r * "$APP_DIR"
cd "$APP_DIR"

# Set up Python virtual environment if it doesn't exist
if [ ! -d "$PYTHON_ENV_DIR" ]; then
  python3 -m venv "$PYTHON_ENV_DIR"
  echo "Created Python virtual environment"
fi

# Activate virtual environment
source "$PYTHON_ENV_DIR/bin/activate"

# Install dependencies
pip install --upgrade pip
pip install flask psutil

# Kill any app running on port 5000
fuser -k 5000/tcp || true

# Start the app with logging
nohup python app.py > app.log 2>&1 &

echo "System Info API is running on http://<your-server-ip>:5000/info"
