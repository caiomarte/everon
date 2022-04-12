output "endpoint" {
  description = "The IP address of the GKE cluster's Kubernetes master."
  value       = module.cluster.endpoint
}

output "link" {
  description = "The server-defined URL for the GKE cluster."
  value       = module.cluster.link
}