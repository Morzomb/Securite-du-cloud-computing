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

provider "aws" {
  region = "eu-west-1"
  alias = "source"
}
provider "aws" {
  region = "eu-west-2"
  alias = "dest"
}

resource "aws_kms_key" "kms_key" {
  description             = "Clé KMS S3"
  enable_key_rotation     = true
  provider = aws.dest
  policy                  = <<-POLICY
{
    "Sid": "Allow use of the key",
    "Effect": "Allow",
    "Principal": {
        "AWS": [
            "arn:aws:iam::754053545032:role/replication-role-group4",
            "arn:aws:iam::754053545032:user/celian_user"
        ]
    },
    "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
        "kms:ReplicateKey"
    ],
    "Resource": "*"
}
POLICY
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "source_bucket" {
#   depends_on = [ aws_s3_bucket.Group4BucketS3 ]
#   bucket = aws_s3_bucket.Group4BucketS3.id

#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.kms_key.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }
resource "aws_s3_bucket_server_side_encryption_configuration" "target_bucket" {
  depends_on = [ aws_s3_bucket.Group4BucketS3target ]
  provider = aws.dest
  bucket = aws_s3_bucket.Group4BucketS3target.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_iam_policy" "policy_attachement" {
  name        = "policy_attachement"
  path        = "/"
  description = "Allow"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutBucketAcl",
          "s3:PutBucketVersionning",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        "Resource" : [
          aws_s3_bucket.Group4BucketS3.arn,
          aws_s3_bucket.Group4BucketS3target.arn
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "some_bucket_policy" {
  user      = "celian_user"
  policy_arn = aws_iam_policy.policy_attachement.arn
}
resource "aws_s3_bucket" "Group4BucketS3"{
  depends_on = [ aws_s3_bucket.Group4BucketS3target ]
  bucket = "group4buckets3"
  provider = aws.source
}
resource "aws_s3_bucket" "Group4BucketS3target"{
  bucket = "group4buckets3target"
  provider = aws.dest  
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.Group4BucketS3.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "access_public_block" {
  bucket = aws_s3_bucket.Group4BucketS3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "access_public_block2" {
  bucket = aws_s3_bucket.Group4BucketS3target.id
  provider = aws.dest
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "versioning_bucket_group4" {
  bucket = aws_s3_bucket.Group4BucketS3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "versioning_bucket_group4target" {
  bucket = aws_s3_bucket.Group4BucketS3target.id
  provider = aws.dest
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "replication_config" {
  bucket = aws_s3_bucket.Group4BucketS3.id
  depends_on = [aws_s3_bucket_versioning.versioning_bucket_group4]
  role = aws_iam_role.replication_role_Group4.arn
  rule {
    id     = "rule_replication"
    status = "Enabled"
    filter {
      prefix = ""
    }
    delete_marker_replication {
      status = "Enabled"
    }
    source_selection_criteria {
      sse_kms_encrypted_objects {
        status = "Enabled"

      }
      
    }
  
    destination {
      bucket = aws_s3_bucket.Group4BucketS3target.arn
      storage_class  = "ONEZONE_IA"
      encryption_configuration {
        replica_kms_key_id = aws_kms_key.kms_key.arn
      }
    }
  }
}

resource "aws_iam_role" "replication_role_Group4" {
  name = "replication-role-group4"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        }
      }
    ]
  })
}
