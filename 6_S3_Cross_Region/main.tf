
/* 
Pour tester que votre compte fonctionne :
terraform init definir rep
terraform plan 
terraform apply
terraform destroy
*/

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

# Configuration du fournisseur AWS
provider "aws" {
  region = "eu-west-3"  # Région AWS dans laquelle déployer les ressources
}
