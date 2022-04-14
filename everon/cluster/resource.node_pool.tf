resource "google_container_node_pool" "node_pool" {
  name               = "${lower(var.author.name)}-cluster-node-pool"
  location           = var.zone
  cluster            = google_container_cluster.cluster.name
  initial_node_count = var.node_count.min

  autoscaling {
    min_node_count = var.node_count.min
    max_node_count = var.node_count.max
  }

  node_config {
    disk_size_gb = var.node_disk.size
    disk_type    = var.node_disk.type
    image_type   = var.node_image
    machine_type = var.node_machine

    labels = {
      author = "${lower(var.author.name)}-${lower(var.author.surname)}"
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    workload_metadata_config {
      mode = "GCE_METADATA"
    }

    tags = [
      "${lower(var.author.name)}-${lower(var.author.surname)}"
    ]
  }

  upgrade_settings {
    max_surge       = var.node_availability.surge
    max_unavailable = var.node_availability.unavailable
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
