#terraform.tfvars

################### AWS ###################

# Variables AWS
aws_vars = "eu-west-1"

################### EC2 ###################

# Variables pour l'instance EC2
instance_vars ={
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    name                        = "TP1_cloudtrail"
}

################### CLOUDTRAIL ###################

# Variables pour CloudTrail
cloudtrail_vars ={
    name                            = "cloudtrail_ilies"
    s3_key_prefix                   = "prefix"
    include_global_service_events   = false
}

################### S3_BUKKET ###################

# Variables pour le seau S3
s3_bucket_vars ={
    bucket          = "bucket-ilies"
    force_destroy   = true
}

################### IAM ###################

# Variables pour IAM
iam_vars = "ssm_instance_profile"

# Variables pour le rôle IAM
iam_role_vars ={
    name = "ssm_role"
}
