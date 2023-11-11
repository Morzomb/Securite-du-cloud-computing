resource "aws_s3_bucket" "whizlabs_cloudtrail_kms" {
  bucket = "whizlabs-cloudtrail-kms"  # Remplacez par le nom souhaité
  acl    = "private"  # Modifiez selon vos besoins
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = aws_kms_key.whiz_kms_key.arn
      }
    }
  }
}


resource "aws_s3_bucket_object" "encrypted_object" {
  bucket = aws_s3_bucket.whizlabs_cloudtrail_kms.bucket
  key    = "toto.txt"  # Remplacez par la clé souhaitée
  acl    = "private"  # Modifiez selon vos besoins

  source                  = "toto.txt"  # Remplacez par le chemin local de votre fichier
  server_side_encryption  = "aws:kms"
  kms_key_id              = aws_kms_key.whiz_kms_key.arn  # Utilisez l'ARN de la clé KMS
}

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
