# GLOBAL
project    = "evbox-infrastructure"
region     = "europe-west-1"
zone       = "europe-west1-d"
network    = "default"
subnetwork = "default"

ip_ranges = {
  network  = "10.10.0.0/16"
  pods     = "10.30.0.0/16"
  services = "10.50.0.0/16"
  master   = "10.70.0.0/28"
}

# CLUSTER
cluster_resources = {
  cpu_min    = 50
  cpu_max    = 100
  memory_min = 250
  memory_max = 500
}

# CLUSTER NODE POOL
node_count = {
  min = 3
  max = 9
}

node_availability = {
  surge       = 1
  unavailable = 6
}

node_disk = {
  type = "pd-standard"
  size = 10
}

node_machine = "n1-standard-1"
node_image   = "COS_CONTAINERD"

# APPLICATION
application = {
  image    = "nginx"
  tag     = "1.21.6-alpine"
  version  = "0.3"
  port     = 80
  replicas = 3
}
