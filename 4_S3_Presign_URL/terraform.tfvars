################### AWS ###################

aws_vars = "eu-west-1"

################### EC2 ###################

my_bucket_vars ={
    bucket      = "esgigroup5"
    acl         = "private"
}

file_upload_vars ={
    key             = "logo.PNG"
    source          = "logo.PNG"
    content_type    = "image/png"
}