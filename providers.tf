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
    prefix      = "caio"
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("credentials.json")
}

#provider "kubernetes" {
#  host  = "https://${module.cluster.endpoint}"
#  token = data.google_client_config.provider.access_token
#  cluster_ca_certificate = base64decode(
#    module.cluster.ca_certificate
#  )
#}

#provider "helm" {
#  kubernetes {
#    host  = "https://${module.cluster.endpoint}"
#    token = data.google_client_config.provider.access_token
#    cluster_ca_certificate = base64decode(
#      module.cluster.ca_certificate
#    )
#  }
#}
