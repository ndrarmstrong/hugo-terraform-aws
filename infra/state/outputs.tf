output "s3_backend_bucket" {
  value       = aws_s3_bucket.tf_state.bucket
  description = "S3 backend bucket"
}

output "s3_backend_region" {
  value       = aws_s3_bucket.tf_state.region
  description = "S3 backend region"
}

output "s3_backend_key" {
  value       = "global/s3/terraform.tfstate"
  description = "S3 backend key"
}