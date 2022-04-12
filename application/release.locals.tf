locals {
  values = {
    name      = var.application.image
    image     = "${var.application.repo}/${var.application.image}:latest"
    namespace = "${var.application.image}-namespace"
    replicas  = var.application.replicas
    port      = var.application.port
    address   = var.cluster_endpoint
    manager   = "terraform"
    author    = "${lower(var.author.name)}-${lower(var.author.surname)}"
  }
}
