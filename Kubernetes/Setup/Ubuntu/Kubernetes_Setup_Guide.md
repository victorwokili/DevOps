
# Kubernetes Setup on Linux

This guide details the steps to set up Kubernetes on a Linux system, including the preparation of the system environment and the installation of Kubernetes components.

## Load Necessary Kernel Modules

1. **Create a Configuration File for Kernel Modules**:
   This step ensures that the `overlay` and `br_netfilter` modules are loaded at boot.

   ```bash
   cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
   overlay
   br_netfilter
   EOF
   ```

2. **Manually Load Kernel Modules**:
   Immediately load the `overlay` and `br_netfilter` modules.

   ```bash
   sudo modprobe overlay
   sudo modprobe br_netfilter
   ```

## Configure Sysctl

1. **Set Sysctl Parameters for Kubernetes**:
   These settings are necessary for network traffic management by Kubernetes.

   ```bash
   cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
   net.bridge.bridge-nf-call-iptables  = 1
   net.bridge.bridge-nf-call-ip6tables = 1
   net.ipv4.ip_forward                 = 1
   EOF
   ```

2. **Reload Sysctl Configuration**:
   Apply the new sysctl settings.

   ```bash
   sudo sysctl --system
   ```

## Install Container Runtime

1. **Update Packages and Install Prerequisites**:
   Update the package index and install required packages.

   ```bash
   sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https
   ```

2. **Install Containerd**:
   Install `containerd` as the container runtime.

   ```bash
   sudo apt-get update && sudo apt-get install -y containerd
   ```

3. **Configure Containerd and Restart**:
   Generate the default containerd configuration and restart the service.

   ```bash
   sudo mkdir -p /etc/containerd
   sudo containerd config default | sudo tee /etc/containerd/config.toml
   sudo systemctl restart containerd
   ```

## Disable Swap

Disabling swap is required for Kubernetes.

   ```bash
   sudo swapoff -a
   ```

## Set Up Kubernetes Repository

1. **Install Transport HTTPS and Curl**:
   Ensure that the system can communicate over HTTPS.

   ```bash
   sudo apt-get update && sudo apt-get install -y apt-transport-https curl
   ```

2. **Add Kubernetes GPG Key**:
   Import the GPG key for the Kubernetes repository.

   ```bash
   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
   ```

3. **Add Kubernetes Repository**:
   Add the Kubernetes apt repository.

   ```bash
   cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
   deb https://apt.kubernetes.io/ kubernetes-xenial main
   EOF
   ```

## Install Kubernetes Components

1. **Update Package Index**:
   Refresh the package index after adding the Kubernetes repository.

   ```bash
   sudo apt-get update
   ```

2. **Install Specific Versions of Kubernetes Components**:
   Install `kubelet`, `kubeadm`, and `kubectl` of specific versions.

   ```bash
   sudo apt-get update && sudo apt-get install -y kubelet=1.27.0-00 kubeadm=1.27.0-00 kubectl=1.27.0-00
   ```

3. **Mark Packages to Hold**:
   Prevent automatic updates of Kubernetes components.

   ```bash
   sudo apt-mark hold kubelet kubeadm kubectl
   ```

After completing these steps, your system will be ready to initialize a Kubernetes cluster.
