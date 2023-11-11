# Récupération des données de modèle pour l'initialisation des instances publiques
data "template_file" "init_public" {
  template = file(var.template_file_init_public.template)
  vars     = {
    message = var.template_file_init_public.message
  }
}

# Récupération des données de modèle pour l'initialisation des instances privées
data "template_file" "init_public-backup" {
  template = file(var.template_file_init_public_backup.template)
  vars     = {
    message = var.template_file_init_public_backup.message
  }
}

# Définition d'un document de politique IAM autorisant le Load Balancer
data "aws_iam_policy_document" "allow-lb" {
  statement {
    effect = var.aws_iam_policy_document_allow-lb.effect
    principals {
      type        = var.aws_iam_policy_document_allow-lb.type
      identifiers = var.aws_iam_policy_document_allow-lb.identifiers
    }

    actions = [
      var.aws_iam_policy_document_allow-lb.actions
    ]

    resources = [
      "arn:aws:s3:::${var.Log_LoadBalancer_S3.bucket}/*"
    ]
  }
}
