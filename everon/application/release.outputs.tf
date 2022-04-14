output "application_endpoint" {
    description = "The public endpoint to access the Kubernetes service in the GKE Cluster."
    value = kubernetes_service.service.spec.load_balancer_ip
}