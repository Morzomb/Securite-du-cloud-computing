################ Iam ################

# Nom du rôle IAM pour la réplication
aws_iam_role_replication = "tf-iam-role-replication-12345"

# Nom de la politique IAM pour la réplication
aws_iam_policy_replication = "tf-iam-role-policy-replication-12345"

################ S3 ################

# Paramètres du seau S3 de destination
aws_s3_bucket_destination = {
  bucket        = "destination-groupe-4-bucket-esgi"
  force_destroy = true
}

# Statut de la versioning pour le seau S3 de destination
aws_s3_bucket_versioning_destination_status = "Enabled"

# Paramètres du seau S3 source
aws_s3_bucket_source = {
  bucket        = "source-groupe-4-bucket-esgi"
  force_destroy = true
}

# Statut de la versioning pour le seau S3 source
aws_s3_bucket_versioning_source_status = "Enabled"

# Paramètres de la réplication pour le seau S3 source vers le seau S3 de destination
aws_s3_bucket_replication_configuration_replication = {
  id            = "foobar"
  prefix        = ""
  status        = "Enabled"
  storage_class = "STANDARD"
}

################ Data ################

# Paramètres du document de politique IAM pour l'assumption de rôle
aws_iam_policy_document_assume_role = {
  effect      = "Allow"
  type        = "Service"
  identifiers = "s3.amazonaws.com"
  actions     = "sts:AssumeRole"
}
