# instance.tf

# Configuration de l'instance EC2
resource "aws_instance" "ec2_instance" {
  ami           = var.instance_vars.ami # ID de l'AMI pour l'instance EC2
  instance_type = var.instance_vars.instance_type # Type d'instance EC2
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name # Profil IAM associé à l'instance EC2

  user_data = data.template_file.ssm_agent_sh.rendered # Données utilisateur pour l'initialisation de l'agent SSM

  tags = { 
    Name = var.instance_vars.name # Balises associées à l'instance EC2
    } 
}
