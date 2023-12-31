# cloudwatch.tf

# Règle CloudWatch pour les changements d'état des instances EC2
resource "aws_cloudwatch_event_rule" "EC2_State_Change_Event" {
  name        = var.cloudwatch_vars
  is_enabled  = true
  event_pattern = jsonencode(
    {
      source = [
        "aws.ec2",
      ]
      detail-type = [
        "EC2 Instance State-change Notification"
      ]
    }
  )
}

# Cible CloudWatch pour la règle d'événement des changements d'état des instances EC2
resource "aws_cloudwatch_event_target" "Group4EC2Target" {
  rule = aws_cloudwatch_event_rule.EC2_State_Change_Event.name
  arn  = aws_sns_topic.Server_Monitor.arn
}
