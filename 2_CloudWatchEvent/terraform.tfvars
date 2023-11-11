################### AWS ###################

aws_vars = "eu-west-1"

################### EC2 ###################

instance_vars ={
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    name                        = "TP2_Cloudwatch"
}

################### CLOUDWATCH ###################

cloudwatch_vars = "EC2_State_Change_Event"

################### IAM ###################

iam_instance_vars = "iam_profile_instance"

iam_role_vars ={
    name = "esgi_EC2_Role"
}

iam_policy_vars = [
  {
    name        = "policy_attachement"
    policy_arn  = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  },
  {
    name        = "policy_attachment2"
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  },
  {
    name        = "policy_attachment3"
    policy_arn  = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
  },
  {
    name        = "policy_attachment4"
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
  }
]

################### SNS ###################

sns_topic_vars ={
    name         = "Server_Monitor"
    display_name = "Server_Monitor"
}

sns_topic_subscription_vars ={
    protocol = "email"
    endpoint = "ilies.behuet@gmail.com"
}

################### SEC GROUP ###################

Security_Group = {
  name_prefix           = "EC2_Server_SG"
  description           = "Security Group to allow traffic to EC2"
  ingress_from_port     = 0
  ingress_to_port       = 0
  ingress_protocol      = "-1"
  ingress_cidr_blocks   = ["0.0.0.0/0"]
  egress_from_port      = 0
  egress_to_port        = 0
  egress_protocol       = "-1"
  egress_cidr_blocks    = ["0.0.0.0/0"]
}