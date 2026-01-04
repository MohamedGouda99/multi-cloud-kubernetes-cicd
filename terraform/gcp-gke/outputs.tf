output "cluster_id" {
  description = "GKE cluster ID"
  value       = google_container_cluster.main.id
}

output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.main.name
}

output "cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = google_container_cluster.main.endpoint
}

output "cluster_location" {
  description = "GKE cluster location"
  value       = google_container_cluster.main.location
}

output "network_name" {
  description = "VPC network name"
  value       = google_compute_network.gke_network.name
}

output "subnet_name" {
  description = "Subnet name"
  value       = google_compute_subnetwork.gke_subnet.name
}

