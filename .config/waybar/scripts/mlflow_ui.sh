#!/bin/bash

# Check if MLFlow is installed
if ! command -v mlflow &> /dev/null; then
    notify-send "MLFlow" "MLFlow is not installed. Installing..." -i python
    pip install mlflow
fi

# Directory for MLFlow data
MLFLOW_DIR="$HOME/ml/mlflow"
mkdir -p "$MLFLOW_DIR"

# Check if MLFlow is already running
if pgrep -f "mlflow ui" > /dev/null; then
    notify-send "MLFlow" "MLFlow UI is already running" -i python
    # Open MLFlow in browser
    xdg-open http://localhost:5000 &
else
    notify-send "MLFlow" "Starting MLFlow UI..." -i python
    
    # Start MLFlow server in background
    nohup mlflow ui --backend-store-uri "$MLFLOW_DIR" --host 0.0.0.0 --port 5000 > "$MLFLOW_DIR/mlflow.log" 2>&1 &
    
    # Wait for server to start
    sleep 2
    
    # Open MLFlow in browser with title that can be detected by Hyprland
    sleep 1 && chromium --new-window --app=http://localhost:5000 --class=chromium --title=MLFlow &
    
    notify-send "MLFlow" "MLFlow UI started at http://localhost:5000" -i python
fi