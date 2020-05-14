# Site S3 Bucket

## Bucket
resource "aws_s3_bucket" "site-bucket" {
  bucket = var.domain_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  logging {
    target_bucket = aws_s3_bucket.site-logs.bucket
    target_prefix = "${var.domain_name}/s3/root"
  }
}

## Bucket public access
resource "aws_s3_bucket_public_access_block" "site-bucket" {
  bucket = aws_s3_bucket.site-bucket.id
}

## Bucket policy
data "template_file" "site-bucket-policy" {
  template = "${file("public_bucket_policy.json")}"
  vars = {
    bucket = aws_s3_bucket.site-bucket.id
  }
}
resource "aws_s3_bucket_policy" "site-bucket" {
  bucket = aws_s3_bucket.site-bucket.id
  policy = data.template_file.site-bucket-policy.rendered
}



# Redirect www. S3 bucket

## Bucket
resource "aws_s3_bucket" "www-site-bucket" {
  bucket = "www.${var.domain_name}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = var.domain_name
  }

  logging {
    target_bucket = aws_s3_bucket.site-logs.bucket
    target_prefix = "${var.domain_name}/s3/www"
  }
}

## Bucket public access
resource "aws_s3_bucket_public_access_block" "www-site-bucket" {
  bucket = aws_s3_bucket.www-site-bucket.id
}

## Bucket policy
data "template_file" "www-site-bucket-policy" {
  template = "${file("public_bucket_policy.json")}"
  vars = {
    bucket = aws_s3_bucket.www-site-bucket.id
  }
}
resource "aws_s3_bucket_policy" "www-site-bucket" {
  bucket = aws_s3_bucket.www-site-bucket.id
  policy = data.template_file.www-site-bucket-policy.rendered
}


# Logs S3 bucket

## Bucket
resource "aws_s3_bucket" "site-logs" {
  bucket = var.logs_bucket
  acl    = "log-delivery-write"
}
## Disable bucket public access
resource "aws_s3_bucket_public_access_block" "site-logs" {
  bucket                  = aws_s3_bucket.site-logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}