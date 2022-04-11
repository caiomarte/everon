variable "subnet_cidr" {
  description = "CIDR block for the subnet. Defaults to '10.10.0.0/24'."
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.subnet_cidr, 32))
    error_message = "Invalid. Must be a valid IPv4 CIDR block, e.g. '10.0.0.0/16'."
  }
}

variable "aggregation_interval" {
  description = "Aggregation interval for collecting VPC flow logs. Must be either 'INTERVAL_5_SEC', 'INTERVAL_30_SEC', 'INTERVAL_1_MIN', 'INTERVAL_5_MIN', 'INTERVAL_10_MIN', or 'INTERVAL_15_MIN'. Defaults to 'INTERVAL_1_MIN'."
  type        = string
  default     = "INTERVAL_1_MIN"

  validation {
    condition = contains([
      "INTERVAL_5_SEC",
      "INTERVAL_30_SEC",
      "INTERVAL_1_MIN",
      "INTERVAL_5_MIN",
      "INTERVAL_10_MIN",
      "INTERVAL_15_MIN"
    ], var.aggregation_interval)
    error_message = "Invalid. Must be either 'INTERVAL_5_SEC', 'INTERVAL_30_SEC', 'INTERVAL_1_MIN', 'INTERVAL_5_MIN', 'INTERVAL_10_MIN', or 'INTERVAL_15_MIN'."
  }
}
