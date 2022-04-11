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
