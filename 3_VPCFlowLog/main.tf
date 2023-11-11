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

# Configuration du fournisseur AWS
provider "aws" {
  region = "eu-west-1"  # Région AWS dans laquelle déployer les ressources
}

# Task 1 - Créer des logs CloudWatch
resource "aws_cloudwatch_log_group" "vpc_logs" {
  name = "group5vpclogs"
}

# Task 2 - Créer une VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "aws_vpc_terraform"
  }
}

# Task 3 - Créer une passerelle Internet
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Group5InternetGateway"
  }
}

# Task 4 - Créer un Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.16.10.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "group5sub"
  }
}

resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "route_internet"
  }
}

resource "aws_security_group" "http_allowed" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" # Le protocole doit être "tcp" pour le trafic HTTP
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HTTP_Security_Group"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.internet.id
}

# Déclaration du rôle IAM pour les logs de flux VPC
resource "aws_iam_role" "vpc_flow_log_role" {
  name = "VPCFlowLog_Role"

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

# Déclaration du rôle IAM pour l'instance EC2 avec la politique "AmazonSSMManagedInstanceCore"
resource "aws_iam_role" "ssm_managed_instance_role" {
  name = "SSMManagedInstance_Role"

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

# Attacher la politique "AmazonSSMManagedInstanceCore" au rôle IAM
resource "aws_iam_role_policy_attachment" "ssm_managed_instance_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_managed_instance_role.name
}

# Attacher la politique pour les logs CloudWatch au rôle IAM
resource "aws_iam_role_policy" "cloudwatch_logs_policy" {
  name = "CloudWatchLogsPolicy"
  role = aws_iam_role.ssm_managed_instance_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

# Task 5 - Créer des logs de flux VPC
resource "aws_flow_log" "my_flow_log" {
  log_destination           = aws_cloudwatch_log_group.vpc_logs.arn
  traffic_type              = "ACCEPT"
  vpc_id                    = aws_vpc.my_vpc.id
  iam_role_arn              = aws_iam_role.vpc_flow_log_role.arn
  max_aggregation_interval  = 60
}

# Task 6 - Créer une instance EC2
resource "aws_instance" "my_instance" {
  ami           = "ami-0e309a5f3a6dd97ea" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.http_allowed.id]

  tags = {
    Name = "Group5EC2Instance"
  }

  iam_instance_profile = aws_iam_instance_profile.ssm_managed_instance_profile.name
  
  user_data = <<-EOF
              #!/bin/bash
              cd /tmp
              sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
              sudo systemctl enable amazon-ssm-agent
              sudo systemctl start amazon-ssm-agent
              EOF

  depends_on = [
    aws_iam_role.ssm_managed_instance_role,
    aws_iam_role_policy_attachment.ssm_managed_instance_attachment,
    aws_iam_instance_profile.ssm_managed_instance_profile,
  ]
}

# Déclaration de l'instance profile associée au rôle IAM pour l'instance EC2
resource "aws_iam_instance_profile" "ssm_managed_instance_profile" {
  name = aws_iam_role.ssm_managed_instance_role.name
  role = aws_iam_role.ssm_managed_instance_role.id
}
