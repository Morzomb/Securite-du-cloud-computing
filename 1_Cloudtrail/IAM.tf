# IAM.tf

# Profil d'instance IAM pour SSM
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = var.iam_vars
  role = aws_iam_role.ssm_role.name
}

# Rôle IAM pour SSM
resource "aws_iam_role" "ssm_role" {
  name = var.iam_role_vars.name

  # Politique d'assumption de rôle permettant à EC2 d'assumer ce rôle
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
