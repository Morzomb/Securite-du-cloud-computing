# terraform.tfvars

################### AWS ###################

aws_vars = "eu-west-1"

################### EC2 ###################

# Variables pour la configuration du compartiment S3
my_bucket_vars ={
    bucket      = "esgigroup4"
    acl         = "private"
}

# Variables pour le chargement d'un objet dans le compartiment S3
file_upload_vars ={
    key             = "logo.PNG"
    source          = "logo.PNG"
    content_type    = "image/png"
}
