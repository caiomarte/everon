# References:
# kubernetes_namespace resource (https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)

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
