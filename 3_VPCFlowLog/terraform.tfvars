################### AWS ###################

aws_vars = "eu-west-1"

################### EC2 ###################

instance_vars ={
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    name                        = "Group5EC2Instance"
}

################### CLOUDWATCH ###################

vpc_logs_vars = "group5vpclogs"

cloudwatch_logs_policy_vars = "CloudWatchLogsPolicy"

vpc_flow_log_policy_vars ={
    name        = "esgi_VPCFlowLog_policy"
    description = "Policy for VPC flow logs"
}

################### IAM ###################

iam_role_vpc_vars = "VPCFlowLog_Role"

iam_role_ssm_vars = "SSMManagedInstance_Role"


################### NETWORK ###################

my_vpc_vars ={
    cidr_block              = "172.16.0.0/16"
    instance_tenancy        = "default"
    enable_dns_hostnames    = true
    enable_dns_support      = true
    name                    = "aws_vpc_terraform"
}

my_internet_gateway_vars = "Group5InternetGateway"

my_subnet_vars ={
    cidr_block              = "172.16.10.0/24"
    map_public_ip_on_launch = true
    name                    = "group5sub"
}

internet_vars ={
    cidr_block              = "0.0.0.0/0"
    name                    = "route_internet"
}

Security_Group = {
  name                  = "HTTP_Security_Group"
  ingress_from_port     = 80
  ingress_to_port       = 80
  ingress_protocol      = "tcp"
  ingress_cidr_blocks   = ["0.0.0.0/0"]
  egress_from_port      = 0
  egress_to_port        = 0
  egress_protocol       = "-1"
  egress_cidr_blocks    = ["0.0.0.0/0"]
}