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

################### CLOUDTRAIL ###################

# Variable pour les paramètres CloudTrail
variable "cloudtrail_vars" {
  type = object({
    name                            = string
    s3_key_prefix                   = string
    include_global_service_events   = bool
  })
}

################### S3_BUKKET ###################

# Variable pour les paramètres du seau S3
variable "s3_bucket_vars" {
  type = object({
    bucket          = string
    force_destroy   = bool
  })
}

################### IAM ###################

# Variable pour les paramètres IAM
variable "iam_vars" { type = string }

# Variable pour les paramètres du rôle IAM
variable "iam_role_vars" {
  type = object({
    name = string
  })
}
