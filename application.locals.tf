locals {
  app_name    = "${lower(var.author.name)}-${lower(var.application.repo)}-${var.application.image}"
  app_author  = "${lower(var.author.name)}-${lower(var.author.surname)}"
  app_manager = "Terraform"
  app_image   = "${lower(var.application.repo)}/${lower(var.application.image)}:latest"

  values = {
    name      = local.app_name
    image     = local.app_image
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
    replicas  = var.application.replicas
    port      = var.application.port
    manager   = local.app_manager
    author    = local.app_author
  }
}
