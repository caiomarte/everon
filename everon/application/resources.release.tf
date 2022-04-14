locals {
  values = {
    name      = var.application.image
    image     = var.application.image
    version   = var.application.version
    namespace = "${var.application.image}-namespace"
    replicas  = var.application.replicas
    port      = var.application.port
    domain    = var.dns_zone
    manager   = "terraform"
    author    = "${lower(var.author.name)}-${lower(var.author.surname)}"
  }
}

resource "helm_release" "hello" {
  name             = local.values["name"]
  description      = "${title(var.author.name)}'s Helm Chart for the ${local.values["image"]} image."
  chart            = "./application/helm"
  namespace        = local.values["namespace"]
  create_namespace = true
  cleanup_on_fail  = true
  atomic           = true

  dynamic "set" {
    for_each = local.values
    content {
      name  = set.key
      value = set.value
    }
  }
}

data "kubernetes_service" "hello" {
  metadata {
    name = "${local.values["name"]}-service"
    namespace = local.values["namespace"]
  }

  depends_on = [
    helm_release.hello
  ]
}