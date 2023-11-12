# data.tf

# Données de modèle pour le script utilisateur SSM Agent
data "template_file" "ssm_agent_sh" {
  template = file("user_data.sh")
  vars = {
    message = "ssm_agent_sh"
  }
}

# Document de politique IAM pour SNS
data "aws_iam_policy_document" "sns_policy" {
  # Partie importante du SNS, sans cela, les e-mails sont bloqués
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.Server_Monitor.arn]
  }
}
