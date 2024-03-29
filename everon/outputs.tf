output "application_endpoint" {
    description = "The public endpoint to access the Kubernetes service in the GKE Cluster."
    value = module.application.application_endpoint
}

output "application_url" {
    description = "The URL to access the Kubernetes service in the GKE Cluster."
    value = module.application.application_url
}