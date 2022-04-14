output "endpoint" {
  description = "The IP address of the GKE cluster's Kubernetes master."
  value       = google_container_cluster.cluster.endpoint
}

output "services_cidr" {
  description = "The IP address CIDR block for Kubernetes services in the GKE cluster."
  value       = google_container_cluster.cluster.services_ipv4_cidr
}

output "link" {
  description = "The server-defined URL for the GKE cluster."
  value       = google_container_cluster.cluster.self_link
}

output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the GKE cluster endpoint."
  value       = google_container_cluster.cluster.master_auth.0.client_certificate
}

output "client_key" {
  description = "Base64 encoded private key used by clients to authenticate to the GKE cluster endpoint."
  value       = google_container_cluster.cluster.master_auth.0.client_key
  sensitive   = true
}

output "ca_certificate" {
  description = "Base64 encoded public certificate that is the root of trust for the GKE cluster."
  value       = google_container_cluster.cluster.master_auth.0.cluster_ca_certificate
}
