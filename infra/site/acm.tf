# ACM Certificate
# NB: This will be created by Terraform, but needs to be approved through the console.
resource "aws_acm_certificate" "site" {
  provider          = aws.us-east-1
  domain_name       = var.domain_name
  validation_method = "DNS"
}