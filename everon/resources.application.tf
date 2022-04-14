module "application" {
  source = "./application"

  project          = var.project
  region           = var.region
  zone             = var.zone
  network          = var.network
  subnetwork       = var.subnetwork
  dns_zone = var.dns_zone
  ip_ranges        = var.ip_ranges
  cluster_endpoint = module.cluster.services_cidr

  # APPLICATION
  application = var.application
}