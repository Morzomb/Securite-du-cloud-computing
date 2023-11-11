################ Main ################
region = "eu-west-1"

################ Network ################

# Configuration du VPC
aws_vpc = {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  name                 = "aws_vpc_terraform"
}

# Configuration de la Subnet-Public
Subnet-Public = {
  name              = "Subnet-Public"
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-west-1a"
}

# Configuration de la Subnet-Public-Backup
Subnet-Public-Backup = {
  name              = "Subnet-Public-Backup"
  cidr_block        = "172.16.20.0/24"
  availability_zone = "eu-west-1b"
}

# Configuration de la passerelle Internet (Internet Gateway)
GW = "main"

# Configuration de la table de routage Internet
Route_Table_Internet = {
  cidr_block = "0.0.0.0/0"
  name       = "route_internet"
}

################ Instance ################

# Configuration du groupe de sécurité
Security_Group = {
  name_prefix           = "webserver-SG"
  ingress_from_port     = 80
  ingress_to_port       = 80
  ingress_protocol      = "tcp"
  ingress_cidr_blocks   = ["0.0.0.0/0"]
  egress_from_port      = 0
  egress_to_port        = 0
  egress_protocol       = "-1"
  egress_cidr_blocks    = ["0.0.0.0/0"]
  tags_Name             = "http_allowed"
}

# Liste des configurations d'instance EC2
instance = [
  {
    public                      = true
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    associate_public_ip_address = true
    name                        = "webserver-A"
  },
  {
    public                      = false
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    associate_public_ip_address = true
    name                        = "webserver-B"
  }
]

################ S3 ################

# Configuration du seau S3 pour les journaux du Load Balancer
Log_LoadBalancer_S3 = {
  bucket        = "log-loadbalancer-s3-esgi"
  force_destroy = true
  Name          = "log-loadbalancer-s3-esgi"
  Environment   = "Production"
}

################ LB ################

# Configuration du Load Balancer
aws_lb_web_server_lb = {
  name                     = "Web-server-LB"
  internal                 = false
  load_balancer_type       = "application"
  enable_deletion_protection = false
  prefix                   = "log-lb"
  enabled                  = true
  Environment              = "production"
}

# Configuration du groupe cible du Load Balancer
aws_lb_target_group_web_server_tg = {
  name                   = "web-server-TG"
  port                   = 80
  protocol               = "HTTP"
  path                   = ""
  interval               = 6
  healthy_threshold      = 3
  unhealthy_threshold    = 2
  timeout                = 5
}

# Configuration du port d'attache du groupe cible du Load Balancer
aws_lb_target_group_attachment_port = 80

# Configuration du listener du Load Balancer
aws_lb_listener_web_server_lb_listener = {
  port         = 80
  protocol     = "HTTP"
  type         = "forward"
  content_type = "text/plain"
  status_code  = "200"
}

################ Data ################

# Configuration des données pour l'initialisation des instances publiques
template_file_init_public = {
  template = "user_data_template_A.sh"
  message  = "Public"
}

# Configuration des données pour l'initialisation des instances privées
template_file_init_public_backup = {
  template = "user_data_template_B.sh"
  message  = "Public-Backup"
}

# Configuration du document de politique IAM autorisant le Load Balancer
aws_iam_policy_document_allow-lb = {
  effect       = "Allow"
  type         = "AWS"
  identifiers  = ["arn:aws:iam::156460612806:root"]
  actions      = "s3:PutObject"
}
