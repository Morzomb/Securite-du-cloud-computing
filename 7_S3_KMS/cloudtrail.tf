resource "aws_cloudtrail" "whiz_kms_trail" {
  name                          = "whiz-kms-trail"
  s3_bucket_name                = aws_s3_bucket.whizlabs_cloudtrail_kms.bucket
  include_global_service_events = true
  is_multi_region_trail         = false

  event_selector {
    read_write_type          = "All"
    include_management_events = true
  }
  depends_on = [aws_s3_bucket_policy.S3_Bukket_policy]
}