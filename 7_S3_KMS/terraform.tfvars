# terraform.tfvars

################### AWS ###################

# La région AWS pour le déploiement des ressources.
aws_vars = "eu-west-1"

################### EC2 ###################

# Configuration de l'instance EC2.
instance_vars ={
    ami                         = "ami-0e309a5f3a6dd97ea"
    instance_type               = "t2.micro"
    name                        = "TP1_cloudtrail"
}

################### CLOUDTRAIL ###################

# Configuration du CloudTrail pour le chiffrement KMS.
whiz_kms_trail_vars ={
    name                            = "whiz-kms-trail"
    include_global_service_events   = true
    is_multi_region_trail           = false
    read_write_type                 = "All"
    include_management_events       = true
}

################### KMS ###################

# Configuration de la clé KMS pour le chiffrement des objets S3.
whiz_kms_key_vars ={
    description             = "Clé KMS pour le chiffrement des objets S3"
    deletion_window_in_days = 7
    enable_key_rotation     = true
    tags                    = "Clé KMS pour le chiffrement des objets S3"
}

# Alias pour la clé KMS.
alias_vars = "alias/whiz_kms_key"

################### S3_BUCKET ###################

# Configuration du bucket S3 pour le CloudTrail avec chiffrement KMS.
whizlabs_cloudtrail_kms_vars ={
    bucket          = "whizlabs-cloudtrail-kms"
    acl             = "private"
    force_destroy   = true
    enabled         = true
    sse_algorithm   = "aws:kms"
}

# Configuration de l'objet S3 chiffré.
encrypted_object_vars ={
    key                     = "toto.txt"
    acl                     = "private"
    source                  = "toto.txt"
    server_side_encryption  = "aws:kms"
}

################### IAM ###################

# Configuration de l'instance profile IAM.
iam_vars = "ssm_instance_profile"

# Configuration du rôle IAM.
iam_role_vars ={
    name = "ssm_role"
}

# Configuration du rôle IAM pour KMS.
whizlabs_kms_role_vars = "whizlabs_user-12345"
