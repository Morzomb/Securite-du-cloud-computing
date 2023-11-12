# variable.tf

################### AWS ###################

# Variable pour les paramètres AWS
variable "aws_vars" { type = string }

################### EC2 ###################

# Variable pour les paramètres de l'instance EC2
variable "instance_vars" {
  type = object({
    ami             = string
    instance_type   = string
    name            = string
  })
}

################### CLOUDWATCH ###################

# Variable pour la règle CloudWatch
variable "cloudwatch_vars" { type = string }

################### IAM ###################

# Variable pour le profil IAM de l'instance
variable "iam_instance_vars" { type = string }

# Variable pour les paramètres du rôle IAM
variable "iam_role_vars" {
  type = object({
    name = string
  })
}

# Liste des politiques IAM attachées au rôle
variable "iam_policy_vars" {
  type = list(object({
    name        = string
    policy_arn  = string
  }))
}

################### SNS ###################

# Variables pour le sujet SNS
variable "sns_topic_vars" {
  type = object({
    name         = string
    display_name = string
  })
}

# Variables pour l'abonnement au sujet SNS
variable "sns_topic_subscription_vars" {
  type = object({
    protocol = string
    endpoint = string
  })
}

################### SEC GROUP ###################

# Variables pour le groupe de sécurité
variable "Security_Group" {
  type = object({
    name_prefix         = string
    description         = string

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
