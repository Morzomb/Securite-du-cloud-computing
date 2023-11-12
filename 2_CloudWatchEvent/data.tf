# data.tf

data "template_file" "ssm_agent_sh" {
  template = file("user_data.sh")
  vars = {
    message = "ssm_agent_sh"
  }
}

data "aws_iam_policy_document" "sns_policy" { #Partie importante du SNS, sans ca, mails bloqués
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