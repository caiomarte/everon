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
