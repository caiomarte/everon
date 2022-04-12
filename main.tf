module "cluster" {
  source = "./cluster"

  # GLOBAL
  project    = var.project
  region     = var.region
  zone       = var.zone
  network    = var.network
  subnetwork = var.subnetwork
  ip_ranges  = var.ip_ranges

  # CLUSTER
  cluster_resources = var.cluster_resources

  # CLUSTER NODE POOL
  node_count        = var.node_count
  node_availability = var.node_availability
  node_disk         = var.node_disk
  node_machine      = var.node_machine
  node_image        = var.node_image
}

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
