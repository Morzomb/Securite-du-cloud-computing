# IAM.tf

# Configuration des rôles IAM

# Profil d'instance IAM pour le SSM
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = var.iam_vars
  role = aws_iam_role.ssm_role.name
}

# Rôle IAM pour le SSM
resource "aws_iam_role" "ssm_role" {
  name = var.iam_role_vars.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Rôle IAM pour KMS (Remplacez par le nom souhaité)
resource "aws_iam_role" "whizlabs_kms_role" {
  name = var.whizlabs_kms_role_vars

  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "kms.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
