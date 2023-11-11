resource "aws_cloudtrail" "cloudtrail" {
  name                          = var.cloudtrail_vars.name 
  s3_bucket_name                = aws_s3_bucket.S3_Bukket.id
  s3_key_prefix                 = var.cloudtrail_vars.s3_key_prefix 
  include_global_service_events = var.cloudtrail_vars.include_global_service_events
  depends_on = [ aws_s3_bucket_policy.S3_Bukket_policy,aws_s3_bucket.S3_Bukket ]
}
