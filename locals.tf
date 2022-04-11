locals {
  tags = [
    "${lower(var.author.name)}-${lower(var.author.surname)}"
  ]
}
