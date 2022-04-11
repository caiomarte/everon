locals {
  tags = [
    "Environment: ${var.environment}",
    "Author: ${title(var.author.name)} ${title(var.author.surname)} - ${lower(var.author.email)}"
  ]
}
