# ACM Certificate
# NB: This will be created by Terraform, but needs to be manually validated before use
resource "aws_acm_certificate" "site" {
  provider          = aws.us-east-1
  domain_name       = var.domain_name
  validation_method = "DNS"
}