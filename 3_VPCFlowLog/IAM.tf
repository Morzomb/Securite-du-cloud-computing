# IAM.tf

# Rôle IAM pour les flux de logs VPC
resource "aws_iam_role" "vpc_flow_log_role" {
  name = var.iam_role_vpc_vars

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
    }]
  })
}

# Rôle IAM pour les instances EC2 gérées par SSM
resource "aws_iam_role" "ssm_managed_instance_role" {
  name = var.iam_role_ssm_vars

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attachement de la politique IAM au rôle pour les instances EC2 gérées par SSM
resource "aws_iam_role_policy_attachment" "ssm_managed_instance_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_managed_instance_role.name
}

# Profil d'instance IAM pour les instances EC2 gérées par SSM
resource "aws_iam_instance_profile" "ssm_managed_instance_profile" {
  name = aws_iam_role.ssm_managed_instance_role.name
  role = aws_iam_role.ssm_managed_instance_role.id
}
