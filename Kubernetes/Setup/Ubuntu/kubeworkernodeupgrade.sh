#!/bin/bash

# Upgrade script for a Kubernetes worker node to version 1.28.7-1.1

echo "Starting the upgrade of the Kubernetes worker node to version 1.28.7-1.1..."

# Ensure the system package database is up to date.
echo "Updating system package database..."
sudo apt-get update

# Upgrade kubeadm to the target version.
echo "Upgrading kubeadm to version 1.28.7-1.1..."
sudo apt-get install -y --allow-change-held-packages kubeadm=1.28.7-1.1

# Confirm the upgrade
echo "kubeadm version after upgrade:"
kubeadm version

# Upgrade the kubelet configuration on the worker node.
echo "Upgrading kubelet configuration using kubeadm..."
sudo kubeadm upgrade node

# Upgrade kubelet and kubectl to the target version.
echo "Upgrading kubelet and kubectl to version 1.28.7-1.1..."
sudo apt-get install -y --allow-change-held-packages kubelet=1.28.7-1.1 kubectl=1.28.7-1.1

# Restart kubelet to apply the upgrades.
echo "Restarting kubelet..."
sudo systemctl daemon-reload
sudo systemctl restart kubelet

echo "Worker node upgrade to version 1.28.7-1.1 complete. Please verify the node and pod statuses."
