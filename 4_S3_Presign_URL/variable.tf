# variable.tf

################### AWS ###################

variable "aws_vars" { type = string }

################### BUCKET ###################

# Variables pour la configuration du compartiment S3
variable "my_bucket_vars" {
  type = object({
    bucket      = string
    acl         = string
  })
}

# Variables pour le chargement d'un objet dans le compartiment S3
variable "file_upload_vars" {
  type = object({
    key           = string
    source        = string
    content_type  = string
  })
}
