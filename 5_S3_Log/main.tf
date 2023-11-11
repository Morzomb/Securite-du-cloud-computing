# Configuration du fournisseur AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Fournisseur AWS avec la région spécifiée
provider "aws" {
  region = var.region
}