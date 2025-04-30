#!/bin/bash

if command -v kubectl &> /dev/null; then
    if kubectl cluster-info &> /dev/null; then
        context=$(kubectl config current-context 2>/dev/null)
        namespace=$(kubectl config view --minify -o jsonpath='{..namespace}' 2>/dev/null)
        
        if [[ -z "$namespace" ]]; then
            namespace="default"
        fi
        
        nodes_count=$(kubectl get nodes -o name 2>/dev/null | wc -l)
        pods_count=$(kubectl get pods --all-namespaces 2>/dev/null | grep -v "STATUS" | wc -l)
        
        tooltip="Context: $context\nNamespace: $namespace\nNodes: $nodes_count\nPods: $pods_count"
        
        if [[ $context == *"minikube"* ]]; then
            echo '{"text": "minikube", "tooltip": "'"$tooltip"'", "class": "connected"}'
        else
            echo '{"text": "'"$context"'", "tooltip": "'"$tooltip"'", "class": "connected"}'
        fi
    else
        echo '{"text": "Disconnected", "tooltip": "Not connected to any Kubernetes cluster", "class": "disconnected"}'
    fi
else
    echo '{"text": "N/A", "tooltip": "kubectl not installed", "class": "unavailable"}'
fi