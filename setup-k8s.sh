#!/bin/bash

# Kubernetes Setup Script for Fedora Linux
# This script sets up a single-node Kubernetes cluster using kubeadm

set -e

echo "Starting Kubernetes setup on Fedora Linux..."

# Update the system
echo "Updating system packages..."
sudo dnf update -y

# Disable swap
echo "Disabling swap..."
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab

# Install container runtime (containerd)
echo "Installing containerd..."
sudo dnf install -y containerd
sudo systemctl enable --now containerd

# Configure containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
sudo systemctl restart containerd

# Install Kubernetes components
echo "Installing kubelet, kubeadm, and kubectl..."
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/repodata/repomd.xml.key
EOF

sudo dnf install -y kubelet kubeadm kubectl
sudo systemctl enable --now kubelet

# Initialize the cluster
echo "Initializing Kubernetes cluster..."
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Set up kubeconfig for the current user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install CNI plugin (Calico)
echo "Installing Calico CNI plugin..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# For single-node cluster, allow scheduling on master
echo "Allowing pods to run on master node..."
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# Install Helm (optional, for managing applications)
echo "Installing Helm..."
curl https://get.helm.sh/helm-v3.16.3-linux-amd64.tar.gz -o helm.tar.gz
tar -zxvf helm.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64 helm.tar.gz

echo "Kubernetes setup complete!"
echo "You can now deploy applications to your cluster."
echo "To check cluster status: kubectl get nodes"
echo "To check pods: kubectl get pods --all-namespaces"