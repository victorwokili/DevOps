#!/bin/bash
set -e  # Exit on error

# Update package lists
sudo apt-get update

# Load Kernel Modules
echo -e "overlay\nbr_netfilter" | sudo tee /etc/modules-load.d/k8s.conf
sudo modprobe overlay
sudo modprobe br_netfilter

# Configure Sysctl for Kubernetes Networking
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

# Install prerequisites
sudo apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https

# Install and configure Containerd
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

# Disable swap (required for Kubernetes)
sudo swapoff -a

# Add Kubernetes GPG key and repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update package lists again after adding new repository
sudo apt-get update

# Install specific versions of Kubernetes components
sudo apt-get install -y kubelet=1.27.0-00 kubeadm=1.27.0-00 kubectl=1.27.0-00

# Hold these packages at their current version
sudo apt-mark hold kubelet kubeadm kubectl

# Final validation or status check (optional)
echo "Kubernetes components installed:"
kubectl version --client
