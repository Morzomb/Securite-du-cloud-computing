# network.tf

# Configuration de la VPC "my_vpc" avec le bloc CIDR, la tenance des instances, la prise en charge des noms DNS, et les balises associées.
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.my_vpc_vars.cidr_block
  instance_tenancy     = var.my_vpc_vars.instance_tenancy
  enable_dns_hostnames = var.my_vpc_vars.enable_dns_hostnames
  enable_dns_support   = var.my_vpc_vars.enable_dns_support

  tags = {
    Name = var.my_vpc_vars.name
  }
}

# Configuration de la passerelle Internet "my_internet_gateway" associée à la VPC "my_vpc" et les balises associées.
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.my_internet_gateway_vars
  }
}

# Configuration du sous-réseau "my_subnet" dans la VPC "my_vpc" avec le bloc CIDR, l'attribution automatique d'adresses IP publiques, et les balises associées.
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.my_subnet_vars.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = var.my_subnet_vars.name
  }
}

# Configuration de la table de routage "internet" dans la VPC "my_vpc" avec une route vers Internet via la passerelle Internet "my_internet_gateway" et les balises associées.
resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.internet_vars.cidr_block
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = var.internet_vars.name
  }
}

# Configuration du groupe de sécurité "http_allowed" dans la VPC "my_vpc" avec les règles d'ingress et d'egress spécifiées, et les balises associées.
resource "aws_security_group" "http_allowed" {
  vpc_id = aws_vpc.my_vpc.id
  
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
    Name = var.Security_Group.name
  }
}

# Association du sous-réseau "my_subnet" avec la table de routage "internet".
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.internet.id
}
