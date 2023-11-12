# security_group.tf

# Configuration du groupe de sécurité EC2_Server_SG, avec un préfixe de nom, une description, et des règles d'entrée et de sortie définies par les variables.
resource "aws_security_group" "EC2_Server_SG" {
    name_prefix = var.Security_Group.name_prefix
    description = var.Security_Group.description

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
}
