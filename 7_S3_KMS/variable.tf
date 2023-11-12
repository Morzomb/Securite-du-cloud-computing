# variable.tf

################### AWS ###################

# Variable pour spécifier la région AWS.
variable "aws_vars" { type = string }

################### EC2 ###################

# Variables pour la configuration de l'instance EC2.
variable "instance_vars" {
  type = object({
    ami             = string
    instance_type   = string
    name            = string
  })
}

################### CLOUDTRAIL ###################

# Variables pour la configuration du CloudTrail avec KMS.
variable "whiz_kms_trail_vars" {
  type = object({
    name                            = string
    include_global_service_events   = bool
    is_multi_region_trail           = bool
    read_write_type                 = string
    include_management_events       = bool
  })
}

################### KMS ###################

# Variables pour la configuration de la clé KMS.
variable "whiz_kms_key_vars" {
  type = object({
    description             = string
    deletion_window_in_days = number
    enable_key_rotation     = bool
    tags                    = string
  })
}

# Variable pour l'alias de la clé KMS.
variable "alias_vars" { type = string }

################### S3_BUCKET ###################

# Variables pour la configuration du bucket S3 utilisé par CloudTrail avec KMS.
variable "whizlabs_cloudtrail_kms_vars" {
  type = object({
    bucket          = string
    acl             = string
    force_destroy   = bool
    enabled         = bool
    sse_algorithm   = string
  })
}

# Variables pour la configuration de l'objet S3 chiffré.
variable "encrypted_object_vars" {
  type = object({
    key                     = string
    acl                     = string
    source                  = string
    server_side_encryption  = string
  })
}

################### IAM ###################

# Variable pour la configuration de l'instance profile IAM.
variable "iam_vars" { type = string }

# Variables pour la configuration du rôle IAM.
variable "iam_role_vars" {
  type = object({
    name = string
  })
}

# Variable pour le nom du rôle IAM utilisé par KMS.
variable "whizlabs_kms_role_vars" { type = string }
