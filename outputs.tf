output "cluster_endpoint" {
  description = "GKE cluster's endpoint."
  value       = google_container_cluster.cluster.endpoint
}
