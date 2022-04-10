# References:
# Backend Types - GCS (https://www.terraform.io/language/settings/backends/gcs)
# Google Provider Configuration Reference (https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#configuration-reference)

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.16.0"
    }
  }

  backend "gcs" {
    bucket      = "devops-assignment"
    credentials = "credentials.json"
    #prefix      = "caiomartesilva@gmail.com"
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("credentials.json")
}
