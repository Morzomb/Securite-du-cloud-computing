# main.tf

# Configuration Terraform
terraform {
  # Définition des fournisseurs requis
  required_providers {
    # Fournisseur AWS
    aws = {
      source  = "hashicorp/aws"  # Source du fournisseur AWS
      version = "~> 5.0"         # Version du fournisseur (série 5.x)
    }
  }
}

# Configuration du fournisseur AWS principal pour la région "eu-west-1"
provider "aws" {
  region = "eu-west-1"
}

# Configuration d'un fournisseur AWS avec un alias "central" pour la région "ap-south-1"
provider "aws" {
  alias  = "central" 
  region = "ap-south-1"
}
