#!/bin/bash

MINIKUBE_STATUS=$(minikube status -f '{{.Host}}' 2>/dev/null)

if [ "$MINIKUBE_STATUS" != "Running" ]; then
    notify-send "Minikube" "Starting Minikube cluster..." -i kubernetes
    
    # Check if on battery or AC
    on_battery=$(cat /sys/class/power_supply/AC/online)
    
    if [ "$on_battery" -eq "0" ]; then
        # On battery, use minimal resources
        minikube start \
            --cpus=2 \
            --memory=4096 \
            --disk-size=20g \
            --driver=docker \
            --addons=dashboard \
            --addons=metrics-server
    else
        # On AC, use more resources for ML workloads
        minikube start \
            --cpus=4 \
            --memory=8192 \
            --disk-size=40g \
            --driver=docker \
            --addons=dashboard \
            --addons=metrics-server \
            --addons=registry \
            --addons=ingress
    fi
    
    # Update Waybar module
    pkill -SIGRTMIN+8 waybar
    
    # Deploy ML development resources
    kubectl apply -f ~/.config/k8s/ml-resources.yaml &>/dev/null
    
    notify-send "Minikube" "Minikube started successfully" -i kubernetes
else
    notify-send "Minikube" "Minikube is already running" -i kubernetes
fi