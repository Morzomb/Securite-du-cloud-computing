# instance.tf

# Création d'un groupe de sécurité pour les serveurs web
resource "aws_security_group" "webserver_sg" {
  name_prefix = var.Security_Group.name_prefix
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.Security_Group.ingress_from_port
    to_port     = var.Security_Group.ingress_to_port
    protocol    = var.Security_Group.ingress_protocol 
    cidr_blocks = var.Security_Group.ingress_cidr_blocks
  }

  egress {
    from_port   = var.Security_Group.egress_from_port
    to_port     = var.Security_Group.egress_to_port
    protocol    = var.Security_Group.egress_protocol 
    cidr_blocks = var.Security_Group.egress_cidr_blocks
  }

  tags = {
    Name = var.Security_Group.tags_Name
  }
}

# Création d'une instance AWS EC2 publique
resource "aws_instance" "instance" {
  count         = length(var.instance)
  ami           = var.instance[count.index].ami 
  instance_type = var.instance[count.index].instance_type
  subnet_id     = var.instance[count.index].public ? aws_subnet.public.id : aws_subnet.public-backup.id
  security_groups  = [aws_security_group.webserver_sg.id]

  user_data = var.instance[count.index].public ? data.template_file.init_public.rendered : data.template_file.init_public-backup.rendered

  associate_public_ip_address = var.instance[count.index].associate_public_ip_address   

  tags = {
    Name = var.instance[count.index].name
  }
  depends_on = [data.template_file.init_public, data.template_file.init_public-backup]
}
