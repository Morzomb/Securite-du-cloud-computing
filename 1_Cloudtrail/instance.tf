resource "aws_instance" "ec2_instance" {
  ami           = var.instance_vars.ami 
  instance_type = var.instance_vars.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name

  user_data = data.template_file.ssm_agent_sh.rendered
  
  tags = {
    Name = var.instance_vars.name
  }
}
