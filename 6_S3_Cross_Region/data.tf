# Définition du document de politique IAM pour l'assumption de rôle
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = var.aws_iam_policy_document_assume_role.effect

    principals {
      type        = var.aws_iam_policy_document_assume_role.type
      identifiers = [var.aws_iam_policy_document_assume_role.identifiers]
    }

    actions = [var.aws_iam_policy_document_assume_role.actions]
  }
}

# Définition du document de politique IAM pour la réplication
data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.source.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${aws_s3_bucket.source.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.destination.arn}/*"]
  }
}
