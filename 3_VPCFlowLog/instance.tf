# instance.tf

# Configuration de l'instance EC2 "my_instance" avec l'ID de l'AMI, le type d'instance, le sous-réseau, les groupes de sécurité, les balises, le profil IAM, les données utilisateur pour l'initialisation de l'agent SSM, et les dépendances pour s'assurer que les ressources IAM sont créées avant l'instance EC2.
resource "aws_instance" "my_instance" {
  ami           = var.instance_vars.ami 
  instance_type = var.instance_vars.instance_type
  subnet_id     = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.http_allowed.id]

  tags = {
    Name = var.instance_vars.name
  }

  iam_instance_profile = aws_iam_instance_profile.ssm_managed_instance_profile.name
  
  user_data = data.template_file.ssm_agent_sh.rendered

  depends_on = [
    aws_iam_role.ssm_managed_instance_role,
    aws_iam_role_policy_attachment.ssm_managed_instance_attachment,
    aws_iam_instance_profile.ssm_managed_instance_profile,
  ]
}
