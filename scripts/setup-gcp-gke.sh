#!/bin/bash

set -e

# Configuration
CLUSTER_NAME=${GKE_CLUSTER_NAME:-"devops-cluster"}
PROJECT_ID=${GCP_PROJECT_ID:-""}
ZONE=${GKE_ZONE:-"us-central1-a"}
NODE_COUNT=${NODE_COUNT:-3}
MACHINE_TYPE=${MACHINE_TYPE:-"e2-medium"}

if [ -z "$PROJECT_ID" ]; then
    echo "❌ GCP_PROJECT_ID is not set. Please set it first."
    exit 1
fi

echo "🚀 Setting up GCP GKE cluster: $CLUSTER_NAME"

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud CLI is not installed. Please install it first."
    exit 1
fi

# Set project
echo "🔧 Setting GCP project..."
gcloud config set project $PROJECT_ID

# Enable required APIs
echo "📦 Enabling required APIs..."
gcloud services enable container.googleapis.com
gcloud services enable compute.googleapis.com

# Create GKE cluster
echo "📦 Creating GKE cluster..."
gcloud container clusters create $CLUSTER_NAME \
  --zone $ZONE \
  --num-nodes $NODE_COUNT \
  --machine-type $MACHINE_TYPE \
  --enable-autorepair \
  --enable-autoupgrade \
  --enable-autoscaling \
  --min-nodes 2 \
  --max-nodes 5 \
  --enable-network-policy

# Get credentials
echo "🔧 Getting cluster credentials..."
gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE

# Verify cluster
echo "✅ Verifying cluster..."
kubectl get nodes

echo "🎉 GKE cluster setup complete!"
echo "Cluster name: $CLUSTER_NAME"
echo "Zone: $ZONE"
echo "Project: $PROJECT_ID"

