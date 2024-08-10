#!/bin/bash

set -e

# Get the master IP address from the inventory
MASTER_IP=$(grep -A1 '\[masters\]' inventory.ini | tail -n1 | awk '{split($2,a,"="); print a[2]}')

# Path to the new RKE2 config
RKE2_CONFIG="$HOME/Workspace/ansible-home/tmp/rke2_created.yaml"

# Path to the existing kubeconfig
KUBE_CONFIG="$HOME/.kube/config"

# Backup the existing config
cp "$KUBE_CONFIG" "$KUBE_CONFIG.bak"

# Replace the server address in the downloaded config
sed -i '' "s|server: https://127.0.0.1:6443|server: https://${MASTER_IP}:6443|" "$RKE2_CONFIG"

# Merge the configs
KUBECONFIG="$KUBE_CONFIG:$RKE2_CONFIG" kubectl config view --flatten > "$KUBE_CONFIG.merged"

# Replace the existing config with the merged one
mv "$KUBE_CONFIG.merged" "$KUBE_CONFIG"

echo "RKE2 config has been merged with your existing kubeconfig."
echo "A backup of your original config is at $KUBE_CONFIG.bak"