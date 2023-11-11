################### AWS ###################

aws_vars = "eu-west-1"

################### EC2 ###################

instance_vars ={
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    name                        = "TP1_cloudtrail"
}

################### CLOUDTRAIL ###################

whiz_kms_trail_vars ={
    name                            = "whiz-kms-trail"
    include_global_service_events   = true
    is_multi_region_trail           = false
    read_write_type                 = "All"
    include_management_events       = true
}

################### KMS ###################

whiz_kms_key_vars ={
    description             = "KMS key to encrypt S3 Objects"
    deletion_window_in_days = 7
    enable_key_rotation     = true
    tags                    = "KMS key to encrypt S3 Objects"
}

alias_vars = "alias/whiz_kms_key"

################### S3_BUKKET ###################

whizlabs_cloudtrail_kms_vars ={
    bucket          = "whizlabs-cloudtrail-kms"
    acl             = "private"
    force_destroy   = true
    enabled         = true
    sse_algorithm   = "aws:kms"
}

encrypted_object_vars ={
    key                     = "toto.txt"
    acl                     = "private"
    source                  = "toto.txt"
    server_side_encryption  = "aws:kms"
}

################### IAM ###################

iam_vars = "ssm_instance_profile"

iam_role_vars ={
    name = "ssm_role"
}

whizlabs_kms_role_vars = "whizlabs_user-12345"