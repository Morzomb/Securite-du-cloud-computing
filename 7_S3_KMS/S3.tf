# S3.tf

# Configuration du bucket S3 pour CloudTrail avec chiffrement KMS

resource "aws_s3_bucket" "whizlabs_cloudtrail_kms" {
  bucket        = var.whizlabs_cloudtrail_kms_vars.bucket
  acl           = var.whizlabs_cloudtrail_kms_vars.acl
  force_destroy = var.whizlabs_cloudtrail_kms_vars.force_destroy

  versioning {
    enabled = var.whizlabs_cloudtrail_kms_vars.enabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.whizlabs_cloudtrail_kms_vars.sse_algorithm
        kms_master_key_id = aws_kms_key.whiz_kms_key.arn
      }
    }
  }
}

# Configuration de l'objet dans le bucket S3 avec chiffrement KMS

resource "aws_s3_bucket_object" "encrypted_object" {
  bucket                  = aws_s3_bucket.whizlabs_cloudtrail_kms.bucket
  key                     = var.encrypted_object_vars.key
  acl                     = var.encrypted_object_vars.acl
  source                  = var.encrypted_object_vars.source
  server_side_encryption  = var.encrypted_object_vars.server_side_encryption
  kms_key_id              = aws_kms_key.whiz_kms_key.arn
}

# Configuration de la politique du bucket S3 pour CloudTrail

resource "aws_s3_bucket_policy" "S3_Bukket_policy" {
  bucket = aws_s3_bucket.whizlabs_cloudtrail_kms.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action = [
          "s3:GetBucketAcl",
          "s3:ListBucket"
        ],
        Resource = aws_s3_bucket.whizlabs_cloudtrail_kms.arn
      },
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action = "s3:PutObject",
        Resource = "${aws_s3_bucket.whizlabs_cloudtrail_kms.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
