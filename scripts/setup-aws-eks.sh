#!/bin/bash

set -e

# Configuration
CLUSTER_NAME=${EKS_CLUSTER_NAME:-"devops-cluster"}
REGION=${AWS_REGION:-"us-east-1"}
NODE_COUNT=${NODE_COUNT:-3}
NODE_TYPE=${NODE_TYPE:-"t3.medium"}

echo "🚀 Setting up AWS EKS cluster: $CLUSTER_NAME"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if eksctl is installed
if ! command -v eksctl &> /dev/null; then
    echo "📦 Installing eksctl..."
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
fi

# Create EKS cluster
echo "📦 Creating EKS cluster..."
eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $REGION \
  --nodegroup-name standard-workers \
  --node-type $NODE_TYPE \
  --nodes $NODE_COUNT \
  --nodes-min 2 \
  --nodes-max 5 \
  --managed

# Update kubeconfig
echo "🔧 Updating kubeconfig..."
aws eks update-kubeconfig --name $CLUSTER_NAME --region $REGION

# Verify cluster
echo "✅ Verifying cluster..."
kubectl get nodes

echo "🎉 EKS cluster setup complete!"
echo "Cluster name: $CLUSTER_NAME"
echo "Region: $REGION"

