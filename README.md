# Kubernetes Setup for Wiki Server

This repository contains a script to set up a single-node Kubernetes cluster on Fedora Linux for hosting multiple applications, including wiki servers.

## Prerequisites

- Fedora Linux 43 (or compatible)
- Root or sudo access
- Internet connection

## Setup

1. Make the setup script executable:
   ```bash
   chmod +x setup-k8s.sh
   ```

2. Run the setup script:
   ```bash
   sudo ./setup-k8s.sh
   ```

The script will:
- Update system packages
- Disable swap
- Install containerd as the container runtime
- Install kubelet, kubeadm, and kubectl
- Initialize a Kubernetes cluster
- Install Calico as the CNI plugin
- Allow pods to run on the master node (single-node setup)
- Install Helm for application management

## Post-Setup

After running the script, you can:

- Check cluster status: `kubectl get nodes`
- Check running pods: `kubectl get pods --all-namespaces`
- Deploy applications using kubectl or Helm

## Deploying a Wiki

To deploy a wiki server (e.g., MediaWiki), you can use Helm charts or create Kubernetes manifests.

Example with Helm:
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-wiki bitnami/mediawiki
```

## Troubleshooting

- If kubeadm init fails, ensure swap is disabled and containerd is running.
- For network issues, check Calico pods: `kubectl get pods -n kube-system`
- If kubectl commands fail, ensure your kubeconfig is set: `export KUBECONFIG=$HOME/.kube/config`

## Security Notes

- This is a basic single-node setup for development/testing.
- For production, consider multi-node clusters, RBAC, and security hardening.
- Expose services carefully, using LoadBalancers or Ingress controllers.