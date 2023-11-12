# IAM.tf

# Définition d'un rôle IAM pour la réplication avec le nom spécifié dans la variable
resource "aws_iam_role" "replication" {
  name               = var.aws_iam_role_replication
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Définition d'une politique IAM pour la réplication avec le nom spécifié dans la variable
resource "aws_iam_policy" "replication" {
  name   = var.aws_iam_policy_replication
  policy = data.aws_iam_policy_document.replication.json
}

# Attachement de la politique IAM au rôle IAM créé pour la réplication
resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}
