# cloudwatch.tf

resource "aws_cloudwatch_log_group" "vpc_logs" {
  name = var.vpc_logs_vars
}

resource "aws_iam_role_policy" "cloudwatch_logs_policy" {
  name = var.cloudwatch_logs_policy_vars
  role = aws_iam_role.ssm_managed_instance_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_flow_log" "my_flow_log" {
  log_destination           = aws_cloudwatch_log_group.vpc_logs.arn
  traffic_type              = "ACCEPT"
  vpc_id                    = aws_vpc.my_vpc.id
  iam_role_arn              = aws_iam_role.vpc_flow_log_role.arn
  max_aggregation_interval  = 60
}

resource "aws_iam_policy" "vpc_flow_log_policy" {
  name        = var.vpc_flow_log_policy_vars.name
  description = var.vpc_flow_log_policy_vars.description
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "VisualEditor0",
        Effect = "Allow",
        Action = "logs:*",
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "vpc_flow_log_attachment" {
  policy_arn = aws_iam_policy.vpc_flow_log_policy.arn
  role       = aws_iam_role.vpc_flow_log_role.name
}