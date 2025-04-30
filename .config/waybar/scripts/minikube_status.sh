#!/bin/bash

if command -v minikube &> /dev/null; then
    if minikube status &> /dev/null; then
        status=$(minikube status -o json | jq -r '.Host')
        if [ "$status" == "Running" ]; then
            echo '{"text": "Running", "tooltip": "Minikube is running", "class": "running"}'
        else
            echo '{"text": "Stopped", "tooltip": "Minikube is not running", "class": "stopped"}'
        fi
    else
        echo '{"text": "Stopped", "tooltip": "Minikube is not running", "class": "stopped"}'
    fi
else
    echo '{"text": "N/A", "tooltip": "Minikube is not installed", "class": "unavailable"}'
fi