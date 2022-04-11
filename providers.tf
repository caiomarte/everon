# References:
# Backend Types - GCS (https://www.terraform.io/language/settings/backends/gcs)
# Google Provider Configuration Reference (https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#configuration-reference)

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.16.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.7"
    }
  }

  backend "gcs" {
    bucket      = "devops-assignment"
    credentials = "credentials.json"
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("credentials.json")
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate,
  )
}
