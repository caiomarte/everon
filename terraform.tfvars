# GLOBAL
author = {
  name    = "Caio"
  surname = "Martinho"
  email   = "caiomartesilva@gmail.com"
  ip      = "189.0.90.112/32"
}

region      = "europe-west1"
zone        = "europe-west1-d"
project     = "evbox-infrastructure"
environment = "prod"

ip_ranges = {
  network  = "10.10.0.0/16"
  pods     = "10.30.0.0/16"
  services = "10.50.0.0/16"
  master   = "10.70.0.0/28"
}

# NETWORK
aggregation_interval = "INTERVAL_1_MIN"

# CLUSTER
cluster_resources = {
  cpu_min    = 1
  cpu_max    = 1
  memory_min = 1
  memory_max = 1
}

node_count = {
  min = 1
  max = 5
}

node_availability = {
  surge       = 1
  unavailable = 0
}

node_disk = {
  type = "pd-standard"
  size = 10
}

node_machine = "e2-medium"
node_image   = "COS_CONTAINERD"
