#!/bin/bash

# Upgrade script for Kubernetes cluster to version 1.28.7-1.1

echo "Starting the upgrade of the Kubernetes control plane node..."

# Drain the control plane node to prepare for the upgrade.
kubectl drain k8s-control --ignore-daemonsets --delete-local-data

# Upgrade kubeadm to the target version.
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.28.7-1.1

# Confirm kubeadm is upgraded.
kubeadm version

# Plan the upgrade to see components that will be upgraded.
sudo kubeadm upgrade plan v1.28.7

# Apply the upgrade.
sudo kubeadm upgrade apply v1.28.7 -y

# Upgrade kubelet and kubectl on the control plane node.
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.28.7-1.1 kubectl=1.28.7-1.1

# Restart kubelet to complete the upgrade.
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Uncordon the control plane node to make it schedulable again.
kubectl uncordon k8s-control

# Verify the upgrade.
echo "Verifying the upgrade..."
kubectl get nodes

# Instructions for upgrading worker nodes. 
# This part should be executed for each worker node one at a time to maintain cluster availability.

echo "To upgrade worker nodes, follow the instructions commented out in the script."

# For each worker node (replace k8s-workerN with the actual node name):
# kubectl drain k8s-workerN --ignore-daemonsets --delete-local-data
# SSH into each worker node and run:
# sudo apt-get update && \
# sudo apt-get install -y --allow-change-held-packages kubelet=1.28.7-1.1 kubectl=1.28.7-1.1
# sudo systemctl daemon-reload
# sudo systemctl restart kubelet
# Back on the control plane node, uncordon each worker node:
# kubectl uncordon k8s-workerN

echo "Upgrade process complete. Please manually upgrade worker nodes as described in the script."
