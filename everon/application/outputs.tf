output "application_endpoint" {
    description = "The public endpoint to access the Kubernetes service in the GKE Cluster."
    value = data.kubernetes_service.hello.status.0.load_balancer.0.ingress.0.ip
}

output "application_url" {
    description = "The URL to access the Kubernetes service in the GKE Cluster."
    value = var.dns_zone
}