# IAM.tf

# Profil d'instance IAM
resource "aws_iam_instance_profile" "iam_profile_instance" {
  name = var.iam_instance_vars
  role = aws_iam_role.esgi_EC2_Role.name
}

# Rôle IAM pour les instances EC2
resource "aws_iam_role" "esgi_EC2_Role" {
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

# Attachement de politique IAM au rôle
resource "aws_iam_policy_attachment" "policy_attachement" {
  count      = length(var.iam_policy_vars)
  name       = var.iam_policy_vars[count.index].name
  roles      = [aws_iam_role.esgi_EC2_Role.name]
  policy_arn = var.iam_policy_vars[count.index].policy_arn
}
