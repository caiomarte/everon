# References:
# google_compute_network resource (https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)
# google_compute_subnetwork resource (https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork)

resource "google_compute_network" "vpc" {
  name                    = "vpc-${var.environment}"
  description             = "VPC network in ${var.environment}."
  auto_create_subnetworks = false
  #delete_default_routes_on_create =  true | false
  #routing_mode = "REGIONAL" | "GLOBAL"
  #mtu
}

resource "google_compute_subnetwork" "subnet" {
  count = length(var.subnet_cidr)

  name        = "vpc-${var.environment}-subnet-${count.index}"
  description = "Subnet ${count.index} in ${var.environment}."
  network     = google_compute_network.vpc.name
  region      = var.region
  #purpose = "INTERNAL_HTTPS_LOAD_BALANCER" (requires role; competes with log_config)
  #role = "ACTIVE" | "BACKUP"
  ip_cidr_range = var.subnet_cidr[count.index]

  log_config {
    aggregation_interval = var.aggregation_interval
    flow_sampling        = "1.0"
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
