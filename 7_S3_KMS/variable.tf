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

################### CLOUDTRAIL ###################

variable "whiz_kms_trail_vars" {
  type = object({
    name                            = string
    s3_key_prefix                   = string
    include_global_service_events   = bool
    is_multi_region_trail           = bool
    read_write_type                 = string
    include_management_events       = bool
  })
}

################### KMS ###################

variable "whiz_kms_key_vars" {
  type = object({
    description             = string
    deletion_window_in_days = number
    enable_key_rotation     = bool
    tags                    = string
  })
}

variable "alias_vars" { type = string }

################### S3_BUKKET ###################

variable "whizlabs_cloudtrail_kms_vars" {
  type = object({
    bucket          = string
    acl             = string
    force_destroy   = bool
    enabled         = bool
    sse_algorithm   = string
  })
}

variable "encrypted_object_vars" {
  type = object({
    key                     = string
    acl                     = string
    source                  = string
    server_side_encryption  = string
  })
}

################### IAM ###################

variable "iam_vars" { type = string }

variable "iam_role_vars" {
  type = object({
    name = string
  })
}

variable "whizlabs_kms_role_vars" { type = string }