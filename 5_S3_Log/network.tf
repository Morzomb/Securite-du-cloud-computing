# Création d'une VPC
resource "aws_vpc" "main" {
  cidr_block           = var.aws_vpc.cidr_block
  instance_tenancy     = var.aws_vpc.instance_tenancy
  enable_dns_support   = var.aws_vpc.enable_dns_support
  enable_dns_hostnames = var.aws_vpc.enable_dns_hostnames

  tags = {
    Name = var.aws_vpc.name # Nom de la VPC
  }
}

# Création d'un sous-réseau public
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.Subnet-Public.cidr_block
  availability_zone = var.Subnet-Public.availability_zone

  tags = {
    Name = var.Subnet-Public.name
  }
}

# Création d'un autre sous-réseau public (Backup)
resource "aws_subnet" "public-backup" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.Subnet-Public-Backup.cidr_block
  availability_zone = var.Subnet-Public-Backup.availability_zone

  tags = {
    Name = var.Subnet-Public-Backup.name
  }
}

# Création d'une passerelle Internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.GW
  }
}

# Création d'une table de routage pour l'accès à Internet
resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.Route_Table_Internet.cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.Route_Table_Internet.name
  }
}

# Association du sous-réseau public avec la table de routage vers Internet
resource "aws_route_table_association" "Public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.internet.id
}

# Association du sous-réseau public (Backup) avec la table de routage vers Internet
resource "aws_route_table_association" "Public-Backup" {
  subnet_id      = aws_subnet.public-backup.id
  route_table_id = aws_route_table.internet.id
}
