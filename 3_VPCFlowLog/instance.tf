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

