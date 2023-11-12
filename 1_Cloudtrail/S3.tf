# S3.tf

# Configuration du seau S3
resource "aws_s3_bucket" "S3_Bukket" {
  # Nom du seau S3
  bucket        = var.s3_bucket_vars.bucket

  # Activation de la suppression forcée du seau S3
  force_destroy = var.s3_bucket_vars.force_destroy
}

# Politique d'accès pour le seau S3
resource "aws_s3_bucket_policy" "S3_Bukket_policy" {
  # Seau S3 cible pour la politique
  bucket = aws_s3_bucket.S3_Bukket.id

  # Définition de la politique d'accès en format JSON
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:GetBucketAcl",
        Resource  = aws_s3_bucket.S3_Bukket.arn
      },
      {
        Sid       = "AWSCloudTrailWrite",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.S3_Bukket.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid    = "AWSCloudTrailList",
        Effect = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action = "s3:ListBucket",
        Resource = aws_s3_bucket.S3_Bukket.arn,
        Condition = {
          StringLike = {
            "s3:prefix" = "prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
          }
        }
      },
    ]
  })
}
