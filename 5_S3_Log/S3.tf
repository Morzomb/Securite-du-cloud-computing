# S3.tf

# Création d'un bucket S3 pour les logs du Load Balancer
resource "aws_s3_bucket" "log-loadbalancer-s3-esgi" {
  bucket        = var.Log_LoadBalancer_S3.bucket
  force_destroy = var.Log_LoadBalancer_S3.force_destroy

  tags = {
    Name        = var.Log_LoadBalancer_S3.Name
    Environment = var.Log_LoadBalancer_S3.Environment
  }
}

# Définition d'une politique pour le bucket S3
resource "aws_s3_bucket_policy" "allow-lb" {
  bucket = aws_s3_bucket.log-loadbalancer-s3-esgi.id
  policy = data.aws_iam_policy_document.allow-lb.json
}
