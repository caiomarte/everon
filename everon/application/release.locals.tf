locals {
  values = {
    name      = var.application.image
    image     = var.application.image
    version   = var.application.version
    namespace = "${var.application.image}-namespace"
    replicas  = var.application.replicas
    port      = var.application.port
    address   = var.cluster_endpoint
    domain    = local.dns_zone
    manager   = "terraform"
    author    = "${lower(var.author.name)}-${lower(var.author.surname)}"
  }
}
