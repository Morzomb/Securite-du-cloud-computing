# Définition du seau S3 pour la destination avec les paramètres spécifiés dans les variables
resource "aws_s3_bucket" "destination" {
  bucket        = var.aws_s3_bucket_destination.bucket
  force_destroy = var.aws_s3_bucket_destination.force_destroy
}

# Configuration de la versioning pour le seau S3 de destination
resource "aws_s3_bucket_versioning" "destination" {
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = var.aws_s3_bucket_versioning_destination_status
  }
}

# Définition du seau S3 pour la source avec les paramètres spécifiés dans les variables
resource "aws_s3_bucket" "source" {
  provider      = aws.central
  bucket        = var.aws_s3_bucket_source.bucket
  force_destroy = var.aws_s3_bucket_source.force_destroy
}

# Configuration de la versioning pour le seau S3 source
resource "aws_s3_bucket_versioning" "source" {
  provider = aws.central

  bucket = aws_s3_bucket.source.id
  versioning_configuration {
    status = var.aws_s3_bucket_versioning_source_status
  }
}

# Configuration de la réplication pour le seau S3 source vers le seau S3 de destination
resource "aws_s3_bucket_replication_configuration" "replication" {
  provider   = aws.central
  depends_on = [aws_s3_bucket_versioning.source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.source.id

  rule {
    id = var.aws_s3_bucket_replication_configuration_replication.id

    filter {
      prefix = var.aws_s3_bucket_replication_configuration_replication.prefix
    }

    status = var.aws_s3_bucket_replication_configuration_replication.status

    delete_marker_replication {
      status = var.aws_s3_bucket_replication_configuration_replication.status
    }

    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = var.aws_s3_bucket_replication_configuration_replication.storage_class
    }
  }
}
