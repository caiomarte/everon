# References:
# google_container_cluster resource - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# GKE best practices: Designing and building highly available clusters - https://cloud.google.com/blog/products/containers-kubernetes/best-practices-for-creating-a-highly-available-gke-cluster
# Using node auto-provisioning - https://cloud.google.com/kubernetes-engine/docs/how-to/node-auto-provisioning
# Creating a private cluster - https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters
# Harden your cluster's security - https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster
# Configuring Cloud Operations for GKE - https://cloud.google.com/stackdriver/docs/solutions/gke/installing#controlling_the_collection_of_application_logs
# Using Cloud DNS for GKE - https://cloud.google.com/kubernetes-engine/docs/how-to/cloud-dns

resource "google_container_cluster" "cluster" {
  name                        = "cluster-${var.environment}"
  description                 = "Regional cluster in ${var.environment}."
  location                    = var.region
  remove_default_node_pool    = true
  initial_node_count          = 1
  network                     = google_compute_network.vpc.name
  subnetwork                  = google_compute_subnetwork.subnet.name
  enable_binary_authorization = true
  enable_shielded_nodes       = true
  #enable_autopilot = true #Managed nodes # https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview#comparison
  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.ip_ranges.pods
    services_ipv4_cidr_block = var.ip_ranges.services
  }

  #addons_config {
  #horizontal_pod_autoscaling {
  #  disabled = false #default
  #}
  #http_load_balancing {
  #  disabled = false #default
  #}
  #cloudrun_config {    # Fully managed, serverless platform
  #  disabled           = false
  #  load_balancer_type = "LOAD_BALANCER_TYPE_INTERLA" | "LOAD_BALANCER_TYPE_EXTERNAL"
  #}
  #}

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      #maximum       = 0
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 1
      #maximum = 0
    }
    auto_provisioning_defaults {
      oauth_scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/devstorage.read_only"
      ]
      #service_account = 
      #image_type = "COS_CONTAINERD" | "COS_UBUNTU_CONTAINERD"
    }
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  database_encryption {
    state    = "ENCRYPTED"
    key_name = google_kms_crypto_key.key.name
  }

  enable_intranode_visibility = true
  logging_service             = "logging.googleapis.com/kubernetes"
  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS"
    ]
  }

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS"
    ]
  }

  maintenance_policy {
    recurring_window {
      start_time = "2022-04-10T03:00:00Z"
      end_time   = "2022-04-10T05:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=SA,SU"
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.ip_ranges.master
    master_global_access_config {
      enabled = true
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "189.0.90.112/32" #My IP
      display_name = "Caio's personal computer"
    }
  }

  dns_config {
    cluster_dns        = "CLOUD_DNS"
    cluster_dns_scope  = "CLUSTER_SCOPE"
    cluster_dns_domain = var.environment
  }
}
