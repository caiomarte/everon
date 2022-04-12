terraform {
  required_providers {
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
