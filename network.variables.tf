variable "subnet_cidr" {
  description = "List of CIDR blocks for subnets."
  type        = list(string)
  default = [
    "10.10.0.0/24",
    "10.30.0.0/24",
    "10.50.0.0/24"
  ]
}
