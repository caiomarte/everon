# References:
# helm_release resource (https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)
# Recommended Labels (https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
# kubernetes_namespace resource (https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)
# dynamic Blocks (https://www.terraform.io/language/expressions/dynamic-blocks)

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "${local.app_name}-namespace"
    labels = {
      "app.kubernetes.io/name"       = local.app_name
      "app.kubernetes.io/managed-by" = local.app_manager
      "app.kubernetes.io/created-by" = local.app_author
    }
  }
}

resource "helm_release" "hello" {
  name              = local.app_name
  description       = "${title(var.author.name)}'s Helm Chart for the ${var.application.repo}/${var.application.image}:latest image."
  chart             = "./application"
  namespace         = kubernetes_namespace.app_namespace.metadata[0].name
  reset_values      = true
  cleanup_on_fail   = true
  atomic            = true
  dependency_update = true

  dynamic "set" {
    for_each = local.values
    content {
      name  = set.key
      value = set.value
    }
  }
}
