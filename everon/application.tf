module "application" {
  source = "./application"

  # GLOBAL
  project          = var.project
  region           = var.region
  zone             = var.zone
  network          = var.network
  subnetwork       = var.subnetwork
  ip_ranges        = var.ip_ranges
  cluster_endpoint = module.cluster.endpoint

  # APPLICATION
  application = var.application
}