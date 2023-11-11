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

variable "cloudwatch_vars" { type = string }

################### IAM ###################

variable "iam_instance_vars" { type = string }

variable "iam_role_vars" {
  type = object({
    name = string
  })
}

# Liste des policy
variable "iam_policy_vars" {
  type = list(object({
    name        = string
    policy_arn  = string
  }))
}

################### SNS ###################

variable "sns_topic_vars" {
  type = object({
    name         = string
    display_name = string
  })
}

variable "sns_topic_subscription_vars" {
  type = object({
    protocol = string
    endpoint = string
  })
}

################### SEC GROUP ###################

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