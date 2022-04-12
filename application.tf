# References:
# helm_release resource (https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)
# Recommended Labels (https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
# dynamic Blocks (https://www.terraform.io/language/expressions/dynamic-blocks)

resource "helm_release" "hello" {
  name             = local.values["name"]
  description      = "${title(var.author.name)}'s Helm Chart for the ${local.values["image"]} image."
  chart            = "./application"
  namespace        = local.values["namespace"]
  create_namespace = true
  reset_values     = true
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
