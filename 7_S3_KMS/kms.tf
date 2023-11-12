# kms.tf

# Configuration de la clé KMS et de l'alias

resource "aws_kms_key" "whiz_kms_key" {
  description             = var.whiz_kms_key_vars.description
  deletion_window_in_days = var.whiz_kms_key_vars.deletion_window_in_days
  enable_key_rotation     = var.whiz_kms_key_vars.enable_key_rotation

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
    Description = var.whiz_kms_key_vars.tags
  }
}

# Alias pour la clé KMS
resource "aws_kms_alias" "alias" {
  name          = var.alias_vars
  target_key_id = aws_kms_key.whiz_kms_key.key_id
}
