# variable.tf

################ Iam ################

# Variable définissant le nom du rôle IAM pour la réplication
variable "aws_iam_role_replication" {
  type = string
}

# Variable définissant le nom de la politique IAM pour la réplication
variable "aws_iam_policy_replication" {
  type = string
}

################ S3 ################

# Variable définissant les paramètres du seau S3 de destination
variable "aws_s3_bucket_destination" {
  type = object({
    bucket        = string
    force_destroy = bool
  })
}

# Variable définissant le statut de la versioning pour le seau S3 de destination
variable "aws_s3_bucket_versioning_destination_status" {
  type = string
}

# Variable définissant les paramètres du seau S3 source
variable "aws_s3_bucket_source" {
  type = object({
    bucket        = string
    force_destroy = bool
  })
}

# Variable définissant le statut de la versioning pour le seau S3 source
variable "aws_s3_bucket_versioning_source_status" {
  type = string
}

# Variable définissant les paramètres de la réplication pour le seau S3 source vers le seau S3 de destination
variable "aws_s3_bucket_replication_configuration_replication" {
  type = object({
    id            = string
    prefix        = string
    status        = string
    storage_class = string
  })
}

################ Data ################

# Variable définissant les paramètres du document de politique IAM pour l'assumption de rôle
variable "aws_iam_policy_document_assume_role" {
  type = object({
    effect      = string
    type        = string
    identifiers = string
    actions     = string
  })
}
