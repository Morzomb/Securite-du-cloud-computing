################ Main ################

# Déclaration de la région AWS
variable "region" {
  type = string
}

################ Network ################

# Configuration de la VPC
variable "aws_vpc" {
  type = object({
    cidr_block           = string
    instance_tenancy     = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    name                 = string
  })
}

# Configuration de la Subnet-Public
variable "Subnet-Public" {
  type = object({
    cidr_block        = string
    availability_zone = string
    name              = string
  })
}

# Configuration de la Subnet-Public-Backup
variable "Subnet-Public-Backup" {
  type = object({
    cidr_block        = string
    availability_zone = string
    name              = string
  })
}

# Configuration de la passerelle Internet (Internet Gateway)
variable "GW" {
  type = string
}

# Configuration de la table de routage Internet
variable "Route_Table_Internet" {
  type = object({
    cidr_block = string
    name       = string
  })
}

################ Instance ################

# Configuration du groupe de sécurité
variable "Security_Group" {
  type = object({
    name_prefix        = string

    ingress_from_port   = number
    ingress_to_port     = number
    ingress_protocol    = string
    ingress_cidr_blocks = list(string)

    egress_from_port   = number
    egress_to_port     = number
    egress_protocol    = string
    egress_cidr_blocks = list(string)

    tags_Name          = string
  })
}

# Liste des configurations d'instance EC2
variable "instance" {
  type = list(object({
    public                      = bool
    ami                        = string
    instance_type              = string
    associate_public_ip_address = bool
    name                        = string
  }))
}

################ S3 ################

# Configuration du seau S3 pour les journaux du Load Balancer
variable "Log_LoadBalancer_S3" {
  type = object({
    bucket        = string
    force_destroy = bool
    Name          = string
    Environment   = string
  })
}

################ LB ################

# Configuration du Load Balancer
variable "aws_lb_web_server_lb" {
  type = object({
    name                     = string
    internal                 = bool
    load_balancer_type       = string
    enable_deletion_protection = bool
    prefix                   = string
    enabled                  = bool
    Environment              = string
  })
}

# Configuration du groupe cible du Load Balancer
variable "aws_lb_target_group_web_server_tg" {
  type = object({
    name                   = string
    port                   = number
    protocol               = string
    path                   = string
    interval               = number
    healthy_threshold      = number
    unhealthy_threshold    = number
    timeout                = number
  })
}

# Configuration du port d'attache du groupe cible du Load Balancer
variable "aws_lb_target_group_attachment_port" {
  type = number
}

# Configuration du listener du Load Balancer
variable "aws_lb_listener_web_server_lb_listener" {
  type = object({
    port         = number
    protocol     = string
    type         = string
    content_type = string
    status_code  = string
  })
}

################ Data ################

# Configuration des données pour l'initialisation des instances publiques
variable "template_file_init_public" {
  type = object({
    template = string
    message  = string
  })
}

# Configuration des données pour l'initialisation des instances privées
variable "template_file_init_public_backup" {
  type = object({
    template = string
    message  = string
  })
}

# Configuration du document de politique IAM autorisant le Load Balancer
variable "aws_iam_policy_document_allow-lb" {
  type = object({
    effect       = string
    type         = string
    identifiers  = list(string)
    actions      = string
  })
}
