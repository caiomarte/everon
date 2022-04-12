locals {
  values = {
    name      = var.application.image
    image     = "${var.application.repo}/${var.application.image}:latest"
    namespace = "${var.application.image}-namespace"
    replicas  = var.application.replicas
    port      = var.application.port
    manager   = "Terraform"
    author    = "${lower(var.author.name)}-${lower(var.author.surname)}"
  }
}
