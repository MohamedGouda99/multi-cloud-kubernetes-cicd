# Multi-Cloud Kubernetes CI/CD Pipeline

## 🚀 Project Overview

This project demonstrates a production-ready CI/CD pipeline for deploying containerized applications to Kubernetes clusters across multiple cloud providers (AWS EKS and GCP GKE). It includes automated testing, building, security scanning, and deployment with Helm charts.

## 📋 Features

- **Multi-Cloud Support**: Deploy to AWS EKS and/or GCP GKE
- **Automated CI/CD**: GitHub Actions pipeline with automated testing and deployment
- **Container Security**: Docker image scanning with Trivy
- **Helm Charts**: Kubernetes application deployment using Helm
- **Monitoring Integration**: Prometheus and Grafana setup
- **GitOps Ready**: Infrastructure and application code in Git

## 🏗️ Architecture

```
┌─────────────┐
│   GitHub    │
│  Repository │
└──────┬──────┘
       │
       ▼
┌─────────────────┐
│  GitHub Actions │
│   CI/CD Pipeline│
└──────┬──────────┘
       │
       ├──► Build Docker Image
       ├──► Security Scan (Trivy)
       ├──► Push to Container Registry
       └──► Deploy to Kubernetes
              │
              ├──► AWS EKS
              └──► GCP GKE
```

## 📁 Project Structure

```
.
├── .github/
│   └── workflows/
│       ├── ci-cd.yml          # Main CI/CD pipeline
│       └── security-scan.yml  # Security scanning workflow
├── helm/
│   └── sample-app/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           └── ingress.yaml
├── k8s/
│   ├── aws-eks/
│   │   ├── namespace.yaml
│   │   └── configmap.yaml
│   └── gcp-gke/
│       ├── namespace.yaml
│       └── configmap.yaml
├── app/
│   ├── Dockerfile
│   ├── app.py                 # Sample Python application
│   └── requirements.txt
├── terraform/
│   ├── aws-eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── gcp-gke/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── scripts/
│   ├── setup-aws-eks.sh
│   ├── setup-gcp-gke.sh
│   └── deploy.sh
└── README.md
```

## 🛠️ Prerequisites

- AWS Account with appropriate permissions
- GCP Account with appropriate permissions
- kubectl installed
- Helm 3.x installed
- Docker installed
- Terraform installed (optional, for infrastructure)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd 1-multi-cloud-kubernetes-cicd
```

### 2. Set Up AWS EKS Cluster

```bash
cd terraform/aws-eks
terraform init
terraform plan
terraform apply
```

Or use the setup script:

```bash
chmod +x scripts/setup-aws-eks.sh
./scripts/setup-aws-eks.sh
```

### 3. Set Up GCP GKE Cluster

```bash
cd terraform/gcp-gke
terraform init
terraform plan
terraform apply
```

Or use the setup script:

```bash
chmod +x scripts/setup-gcp-gke.sh
./scripts/setup-gcp-gke.sh
```

### 4. Configure GitHub Secrets

Add the following secrets to your GitHub repository:

- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key
- `AWS_REGION`: AWS region (e.g., us-east-1)
- `EKS_CLUSTER_NAME`: Name of your EKS cluster
- `GCP_PROJECT_ID`: GCP project ID
- `GCP_SA_KEY`: GCP service account key (JSON)
- `GKE_CLUSTER_NAME`: Name of your GKE cluster
- `GKE_ZONE`: GKE cluster zone
- `DOCKER_USERNAME`: Docker Hub username
- `DOCKER_PASSWORD`: Docker Hub password

### 5. Deploy Application

The CI/CD pipeline will automatically:
1. Build Docker image on push to main branch
2. Run security scans
3. Push to container registry
4. Deploy to Kubernetes clusters

Or deploy manually:

```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

## 📝 Configuration

### Helm Values

Edit `helm/sample-app/values.yaml` to customize:
- Replica count
- Resource limits
- Environment variables
- Service type and ports

### CI/CD Pipeline

The pipeline in `.github/workflows/ci-cd.yml` includes:
- Code linting
- Unit tests
- Docker build
- Security scanning
- Multi-stage deployment

## 🔒 Security Features

- **Image Scanning**: Trivy scans Docker images for vulnerabilities
- **Secrets Management**: Uses Kubernetes secrets and GitHub secrets
- **RBAC**: Role-based access control configured
- **Network Policies**: Kubernetes network policies for pod isolation

## 📊 Monitoring

The project includes Prometheus and Grafana configurations for:
- Pod metrics
- Application performance
- Resource utilization
- Custom business metrics

## 🧪 Testing

Run tests locally:

```bash
cd app
python -m pytest tests/
```

## 📚 Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [GCP GKE Documentation](https://cloud.google.com/kubernetes-engine/docs)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

MIT License

## 👤 Author

Your Name - DevOps Engineer

