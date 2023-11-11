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

variable "cloudtrail_vars" {
  type = object({
    name                            = string
    s3_key_prefix                   = string
    include_global_service_events   = bool
  })
}

################### S3_BUKKET ###################

variable "s3_bucket_vars" {
  type = object({
    bucket          = string
    force_destroy   = bool
  })
}

################### IAM ###################

variable "iam_vars" { type = string }

variable "iam_role_vars" {
  type = object({
    name = string
  })
}
