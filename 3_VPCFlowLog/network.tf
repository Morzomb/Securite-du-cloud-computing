resource "aws_vpc" "my_vpc" {
  cidr_block           = var.my_vpc_vars.cidr_block
  instance_tenancy     = var.my_vpc_vars.instance_tenancy
  enable_dns_hostnames = var.my_vpc_vars.enable_dns_hostnames
  enable_dns_support   = var.my_vpc_vars.enable_dns_support

  tags = {
    Name = var.my_vpc_vars.name
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.my_internet_gateway_vars
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.my_subnet_vars.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = var.my_subnet_vars.name
  }
}

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

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.internet.id
}