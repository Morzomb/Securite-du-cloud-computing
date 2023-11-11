resource "aws_kms_key" "whiz_kms_key" {
  description             = "KMS key to encrypt S3 Objects"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "key-default-1",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "*",
        Resource  = "*",
      },
    ],
  })

  tags = {
    Description = "KMS key to encrypt S3 Objects"
  }
}

resource "aws_kms_alias" "alias" {
  name          = "alias/whiz_kms_key"
  target_key_id = aws_kms_key.whiz_kms_key.key_id
}