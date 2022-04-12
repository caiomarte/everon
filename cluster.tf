# References:
# google_container_cluster resource - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# GKE best practices: Designing and building highly available clusters - https://cloud.google.com/blog/products/containers-kubernetes/best-practices-for-creating-a-highly-available-gke-cluster
# Using node auto-provisioning - https://cloud.google.com/kubernetes-engine/docs/how-to/node-auto-provisioning
# Creating a private cluster - https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters
# Harden your cluster's security - https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster
# Configuring Cloud Operations for GKE - https://cloud.google.com/stackdriver/docs/solutions/gke/installing#controlling_the_collection_of_application_logs
# Using Cloud DNS for GKE - https://cloud.google.com/kubernetes-engine/docs/how-to/cloud-dns
# container_node_pool resource - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
# Provision a GKE Cluster (Google Cloud) - https://learn.hashicorp.com/tutorials/terraform/gke

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

  #dns_config {
  #  cluster_dns        = "CLOUD_DNS"
  #  cluster_dns_scope  = "CLUSTER_SCOPE"
  #  cluster_dns_domain = google_dns_managed_zone.zone.dns_name
  #}

  #private_cluster_config {
  #  enable_private_nodes    = false
  #  enable_private_endpoint = false
  #  master_ipv4_cidr_block  = var.ip_ranges.master
  #  master_global_access_config {
  #    enabled = true
  #  }
  #}

  #enable_binary_authorization = true
  #enable_shielded_nodes       = true

  #enable_autopilot = true #Managed nodes # https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview#comparison

  #cluster_autoscaling {
  #  enabled = true
  #  resource_limits {
  #    resource_type = "cpu"
  #    minimum       = var.cluster_resources.cpu_min
  #    maximum       = var.cluster_resources.cpu_max
  #  }
  #  resource_limits {
  #    resource_type = "memory"
  #    minimum       = var.cluster_resources.memory_min
  #    maximum       = var.cluster_resources.memory_max
  #  }
  #}

  #enable_intranode_visibility = true
  #logging_service             = "logging.googleapis.com/kubernetes"
  #logging_config {
  #  enable_components = [
  #    "SYSTEM_COMPONENTS"
  #  ]
  #}

  #monitoring_service = "monitoring.googleapis.com/kubernetes"
  #monitoring_config {
  #  enable_components = [
  #    "SYSTEM_COMPONENTS"
  #  ]
  #}

  #master_auth {
  #  client_certificate_config {
  #    issue_client_certificate = true
  #  }
  #}

  #master_authorized_networks_config {
  #  cidr_blocks {
  #    cidr_block   = var.author.ip
  #    display_name = "${title(var.author.name)}'s IP address."
  #  }
  #}
}
