# instance.tf

resource "aws_instance" "Group4EC2Server" {
  ami           = var.instance_vars.ami 
  instance_type = var.instance_vars.instance_type
  iam_instance_profile = aws_iam_instance_profile.iam_profile_instance.name

  user_data = data.template_file.ssm_agent_sh.rendered
  
  vpc_security_group_ids = [aws_security_group.EC2_Server_SG.id]

  tags = {
    Name = var.instance_vars.name
  }
}