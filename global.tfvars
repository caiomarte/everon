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
