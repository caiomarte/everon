module "application" {
  source = "./application"

  project          = var.project
  region           = var.region
  zone             = var.zone
  network          = var.network
  subnetwork       = var.subnetwork
  dns_zone = var.dns_zone
  ip_ranges        = var.ip_ranges

  # APPLICATION
  application = var.application
}