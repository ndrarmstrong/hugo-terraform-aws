output "acm_verify_name" {
  value       = aws_acm_certificate.site.domain_validation_options[0].resource_record_name
  description = "ACM domain verification record name"
}

output "acm_verify_type" {
  value       = aws_acm_certificate.site.domain_validation_options[0].resource_record_type
  description = "ACM domain verification record type"
}

output "acm_verify_value" {
  value       = aws_acm_certificate.site.domain_validation_options[0].resource_record_value
  description = "ACM domain verification record value"
}

output "s3_bucket_url" {
  value       = "s3://${aws_s3_bucket.site-bucket.id}?region=${aws_s3_bucket.site-bucket.region}"
  description = "S3 site bucket URL"
}

output "s3_redirect_endpoint" {
  value       = aws_s3_bucket.www-site-bucket.website_endpoint
  description = "S3 www redirect endpoint"
}

output "cf_website_endpoint" {
  value       = aws_cloudfront_distribution.site.domain_name
  description = "CloudFront website endpoint"
}

output "cf_distribution_id" {
  value       = aws_cloudfront_distribution.site.id
  description = "CloudFront distribution ID"
}

output "iam_publish_access_key" {
  value       = aws_iam_access_key.publish.id
  description = "Access Key ID for publish user"
}

output "iam_publish_secret_key" {
  value       = aws_iam_access_key.publish.secret
  description = "Secret access key for publish user"
}