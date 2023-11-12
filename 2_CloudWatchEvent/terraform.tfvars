# terraform.tfvars

################### AWS ###################

# Variables AWS
aws_vars = "eu-west-1"

################### EC2 ###################

# Variables pour l'instance EC2
instance_vars ={
    ami             = "ami-0e309a5f3a6dd97ea"
    instance_type   = "t2.micro"
    name            = "TP2_Cloudwatch"
}

################### CLOUDWATCH ###################

# Variable pour la règle CloudWatch
cloudwatch_vars = "EC2_State_Change_Event"

################### IAM ###################

# Variables pour le profil IAM de l'instance
iam_instance_vars = "iam_profile_instance"

# Variables pour le rôle IAM
iam_role_vars ={
    name = "esgi_EC2_Role"
}

# Variables pour les politiques IAM attachées au rôle
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

# Variables pour le sujet SNS
sns_topic_vars ={
    name         = "Server_Monitor"
    display_name = "Server_Monitor"
}

# Variables pour l'abonnement au sujet SNS
sns_topic_subscription_vars ={
    protocol = "email"
    endpoint = "une_address_mail@gmail.com"
}

################### SEC GROUP ###################

# Variables pour le groupe de sécurité
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
