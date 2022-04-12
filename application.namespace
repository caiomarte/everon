# References:
# kubernetes_namespace resource (https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "caio-hello-namespace"
    labels = {
      "app.kubernetes.io/name"       = "${lower(var.author.name)}-${local.values["name"]}"
      "app.kubernetes.io/managed-by" = local.values["manager"]
      "app.kubernetes.io/created-by" = local.values["author"]
    }
  }
}
