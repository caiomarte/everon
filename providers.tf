# References:
# Backend Types - GCS (https://www.terraform.io/language/settings/backends/gcs)
# Google Provider Configuration Reference (https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#configuration-reference)
# Kubernetes Provider (https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
# Helm Provider (https://registry.terraform.io/providers/hashicorp/helm/latest/docs)

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

    helm = {
      source  = "hashicorp/helm"
      version = ">=1.14.0"
    }
  }

  backend "gcs" {
    bucket      = "devops-assignment"
    credentials = "credentials.json"
    prefix      = "caio-martinho"
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("credentials.json")
}

#provider "kubernetes" {
#  host  = "https://${google_container_cluster.cluster.endpoint}"
#  token = data.google_client_config.provider.access_token
#  cluster_ca_certificate = base64decode(
#    google_container_cluster.cluster.master_auth[0].cluster_ca_certificate,
#  )
#}

#provider "helm" {
#  kubernetes {
#    host  = "https://${google_container_cluster.cluster.endpoint}"
#    token = data.google_client_config.provider.access_token
#    cluster_ca_certificate = base64decode(
#      google_container_cluster.cluster.master_auth[0].cluster_ca_certificate,
#    )
#  }
#}
