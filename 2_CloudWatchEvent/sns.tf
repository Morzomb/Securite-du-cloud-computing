# sns.tf

# Configuration du sujet SNS Server_Monitor avec un nom et un nom d'affichage spécifiés.
resource "aws_sns_topic" "Server_Monitor" {
  name         = var.sns_topic_vars.name
  display_name = var.sns_topic_vars.display_name
}

# Abonnement au sujet SNS Server_Monitor avec le protocole et l'endpoint spécifiés, et confirmation automatique de l'endpoint.
resource "aws_sns_topic_subscription" "Subscription" {
  topic_arn = aws_sns_topic.Server_Monitor.arn
  protocol  = var.sns_topic_subscription_vars.protocol
  endpoint  = var.sns_topic_subscription_vars.endpoint
  endpoint_auto_confirms = true
}

# Politique par défaut pour le sujet SNS Server_Monitor basée sur le document de politique spécifié.
resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.Server_Monitor.arn
  policy = data.aws_iam_policy_document.sns_policy.json
}
