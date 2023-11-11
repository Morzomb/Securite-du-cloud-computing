################### AWS ###################

aws_vars = "eu-west-1"

################### EC2 ###################

instance_vars ={
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    name                        = "TP1_cloudtrail"
}

################### CLOUDTRAIL ###################

cloudtrail_vars ={
    name                            = "cloudtrail_ilies"
    s3_key_prefix                   = "prefix"
    include_global_service_events   = false
}

################### S3_BUKKET ###################

s3_bucket_vars ={
    bucket          = "bucket-ilies"
    force_destroy   = true
}

################### IAM ###################

iam_vars = "ssm_instance_profile"

iam_role_vars ={
    name = "ssm_role"
}
