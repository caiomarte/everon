resource "google_container_cluster" "cluster" {
  name                     = "cluster"
  description              = "${title(var.author.name)}'s zonal, VPC-native cluster."
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network
  subnetwork               = var.subnetwork

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.ip_ranges.pods
    services_ipv4_cidr_block = var.ip_ranges.services
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.ip_ranges.master
    master_global_access_config {
      enabled = true
    }
  }

  dns_config {
    cluster_dns = "CLOUD_DNS"
    cluster_dns_scope = "VPC_SCOPE"
    cluster_dns_domain = var.dns_zone
  }

  enable_intranode_visibility = true
  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS"
    ]
  }

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS"
    ]
  }

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = var.cluster_resources.cpu_min
      maximum       = var.cluster_resources.cpu_max
    }
    resource_limits {
      resource_type = "memory"
      minimum       = var.cluster_resources.memory_min
      maximum       = var.cluster_resources.memory_max
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
}
