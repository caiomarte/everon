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
}
