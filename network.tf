# References:
# google_compute_network resource (https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)

resource "google_compute_network" "vpc" {
  name                            = "vpc-${var.environment}"
  description                     = "VPC network in ${var.environment}."
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "private_subnet" {
  count = length(var.subnet_cidr)

  name          = "vpc-${var.environment}-subnet-${count.index}"
  description   = "Subnet ${count.index} in ${var.environment}."
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet_cidr[count.index]
}
