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
  type = object({
    network  = string
    pods     = string
    services = string
  })

  default = {
    network  = "10.10.0.0/16"
    pods     = "10.30.0.0/16"
    services = "10.50.0.0/16"
  }

  validation {
    condition     = can(cidrhost(var.ip_ranges.network, 32)) && can(cidrhost(var.ip_ranges.pods, 32)) && can(cidrhost(var.ip_ranges.services, 32)) && var.ip_ranges.network != var.ip_ranges.pods && var.ip_ranges.network != var.ip_ranges.services && var.ip_ranges.pods != var.ip_ranges.services
    error_message = "Invalid. Must be 3 valid CIDR blocks, e.g. 10.0.0.0/16."
  }
}
