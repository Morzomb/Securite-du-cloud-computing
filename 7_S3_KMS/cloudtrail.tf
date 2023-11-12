# cloudtrail.tf

# Configuration du journal CloudTrail avec prise en charge de KMS

resource "aws_cloudtrail" "whiz_kms_trail" {
  name                          = var.whiz_kms_trail_vars.name
  s3_bucket_name                = aws_s3_bucket.whizlabs_cloudtrail_kms.bucket
  include_global_service_events = var.whiz_kms_trail_vars.include_global_service_events
  is_multi_region_trail         = var.whiz_kms_trail_vars.is_multi_region_trail

  # Sélecteur d'événements CloudTrail
  event_selector {
    read_write_type          = var.whiz_kms_trail_vars.read_write_type
    include_management_events = var.whiz_kms_trail_vars.include_management_events
  }

  # Dépendance sur la politique du compartiment S3
  depends_on = [aws_s3_bucket_policy.S3_Bukket_policy]
}
