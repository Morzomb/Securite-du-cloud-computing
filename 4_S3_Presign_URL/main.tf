
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
  region = "eu-west-1"  # Région AWS dans laquelle déployer les ressources
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = var.object_key
  source = var.local_file_path
  content_type = var.mime_type
}

output "generate_presigned_url_command" {
  value = "url à copier dans cloudshell : aws s3 presign s3://${aws_s3_bucket.my_bucket.bucket}/${aws_s3_bucket_object.file_upload.key} --expires-in 60"
}
