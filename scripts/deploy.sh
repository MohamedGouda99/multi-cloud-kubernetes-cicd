#!/bin/bash

set -e

# Configuration
NAMESPACE=${NAMESPACE:-"production"}
IMAGE_TAG=${IMAGE_TAG:-"latest"}
IMAGE_REPO=${IMAGE_REPO:-"docker.io/yourusername/sample-app"}

echo "🚀 Deploying application to Kubernetes..."

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl is not installed. Please install it first."
    exit 1
fi

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo "❌ Helm is not installed. Please install it first."
    exit 1
fi

# Create namespace if it doesn't exist
echo "📦 Creating namespace: $NAMESPACE"
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Deploy with Helm
echo "📦 Deploying application with Helm..."
helm upgrade --install sample-app ./helm/sample-app \
  --namespace $NAMESPACE \
  --set image.tag=$IMAGE_TAG \
  --set image.repository=$IMAGE_REPO \
  --wait

# Wait for deployment to be ready
echo "⏳ Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/sample-app -n $NAMESPACE

# Get deployment status
echo "✅ Deployment status:"
kubectl get pods -n $NAMESPACE
kubectl get svc -n $NAMESPACE
kubectl get ingress -n $NAMESPACE

echo "🎉 Deployment complete!"

