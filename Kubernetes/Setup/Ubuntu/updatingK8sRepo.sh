#!/bin/bash

# This script sets up the Kubernetes package repository.

# Create the directory for keyrings if it doesn't already exist
sudo mkdir -p /etc/apt/keyrings

# Download the GPG key and save it as a keyring file
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the Kubernetes repository with the keyring
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update the package list
sudo apt update



#This script will create the necessary keyrings directory, download the Kubernetes GPG key, save it in the specified location, 
#add the Kubernetes repository to your APT sources, and update the package list. 
#Remember, this script uses sudo, so it may prompt you for your password.
