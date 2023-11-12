# variable.tf

################### AWS ###################

variable "aws_vars" { type = string }

################### EC2 ###################

variable "instance_vars" {
  type = object({
    ami             = string
    instance_type   = string
    name            = string
  })
}

################### CLOUDWATCH ###################

# Variables pour les journaux CloudWatch
variable "vpc_logs_vars" { type = string }
variable "cloudwatch_logs_policy_vars" { type = string }

# Variables pour la politique IAM des logs VPC
variable "vpc_flow_log_policy_vars" {
  type = object({
    name        = string
    description = string
  })
}

################### IAM ###################

# Variables pour les rôles IAM
variable "iam_role_vpc_vars" { type = string }
variable "iam_role_ssm_vars" { type = string }

################### NETWORK ###################

# Variables pour la configuration de la VPC
variable "my_vpc_vars" {
  type = object({
    cidr_block              = string
    instance_tenancy        = string
    enable_dns_hostnames    = bool
    enable_dns_support      = bool
    name                    = string
  })
}

# Variables pour la configuration de la passerelle Internet
variable "my_internet_gateway_vars" { type = string }

# Variables pour la configuration du sous-réseau
variable "my_subnet_vars" {
  type = object({
    cidr_block              = string
    map_public_ip_on_launch = bool
    name                    = string
  })
}

# Variables pour la configuration de la route vers Internet
variable "internet_vars" {
  type = object({
    cidr_block              = string
    name                    = string
  })
}

# Variables pour la configuration du groupe de sécurité
variable "Security_Group" {
  type = object({
    name                = string
    ingress_from_port   = number
    ingress_to_port     = number
    ingress_protocol    = string
    ingress_cidr_blocks = list(string)

    egress_from_port    = number
    egress_to_port      = number
    egress_protocol     = string
    egress_cidr_blocks  = list(string)
  })
}
