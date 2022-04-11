variable "author" {
  description = "Author's signature. Cannot be changed."
  type = object({
    name    = string
    surname = string
    email   = string
    ip      = string
  })

  validation {
    condition     = title(var.author.name) == "Caio" && title(var.author.surname) == "Martinho" && lower(var.author.email) == "caiomartesilva@gmail.com"
    error_message = "This project belongs to Caio Martinho - caiomartesilva@gmail.com, and this values shall not be changed."
  }
}

variable "region" {
  description = "Default location regional resources are deployed to. Defaults to 'europe-west1'."
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "Default location zonal resources are deployed to. Defaults to 'europe-west1-d'."
  type        = string
  default     = "europe-west1-d"
}

variable "project" {
  description = "Default GCP project resources are associated with. Defaults to 'evbox-infrastructure'."
  type        = string
  default     = "evbox-infrastructure"
}

variable "environment" {
  description = "Environment resources are deployed to. Must be either 'dev', 'stg', or 'prod'. Defaults to 'dev'."
  type        = string
  default     = "dev"

  validation {
    condition = contains([
      "dev",
      "stg",
      "prod"
    ], var.environment)
    error_message = "Invalid. Must be either 'dev', 'stg', or 'prod'."
  }
}

variable "ip_ranges" {
  description = "CIDR blocks for VPC subnetwork, pods, services, and cluster master, one for each. They cannot overlap. Cluster master's must be /28. Defaults to {network='10.10.0.0/16' pods='10.30.0.0/16' services='10.50.0.0/16' master='10.70.0.0/28'}."
  type = object({
    network  = string
    pods     = string
    services = string
    master   = string
  })

  default = {
    network  = "10.10.0.0/16"
    pods     = "10.30.0.0/16"
    services = "10.50.0.0/16"
    master   = "10.70.0.0/28"
  }

  validation {
    condition     = can(cidrhost(var.ip_ranges.network, 32)) && can(cidrhost(var.ip_ranges.pods, 32)) && can(cidrhost(var.ip_ranges.services, 32)) && can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}($|/(28))$", var.ip_ranges.master)) && cidrhost(var.ip_ranges.network, 0) != cidrhost(var.ip_ranges.pods, 0) && cidrhost(var.ip_ranges.network, 0) != cidrhost(var.ip_ranges.services, 0) && cidrhost(var.ip_ranges.network, 0) != cidrhost(var.ip_ranges.master, 0) && cidrhost(var.ip_ranges.pods, 0) != cidrhost(var.ip_ranges.services, 0) && cidrhost(var.ip_ranges.pods, 0) != cidrhost(var.ip_ranges.master, 0) && cidrhost(var.ip_ranges.services, 0) != cidrhost(var.ip_ranges.master, 0)
    error_message = "Invalid. Must be 4 valid CIDR blocks that DO NOT overlap. Cluster master's must be /28. E.g. {network='10.10.0.0/16' pods='10.30.0.0/16' services='10.50.0.0/16' master='10.70.0.0/28'}."
  }
}
