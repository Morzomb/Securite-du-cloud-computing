# variable.tf

################### AWS ###################

variable "aws_vars" { type = string }

################### BUKKET ###################

variable "my_bucket_vars" {
  type = object({
    bucket      = string
    acl         = string
  })
}

variable "file_upload_vars" {
  type = object({
    key           = string
    source        = string
    content_type  = string
  })
}
