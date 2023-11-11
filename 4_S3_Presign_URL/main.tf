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
  region = var.aws_vars  # Région AWS dans laquelle déployer les ressources
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = var.my_bucket_vars.bucket
  acl    = var.my_bucket_vars.acl
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = var.file_upload_vars.key
  source = var.file_upload_vars.source
  content_type = var.file_upload_vars.content_type
}

output "url_à_copier_dans_PowerShell_ou_CloudShell" {
  value = "aws s3 presign s3://${aws_s3_bucket.my_bucket.bucket}/${aws_s3_bucket_object.file_upload.key} --expires-in 60"
}
