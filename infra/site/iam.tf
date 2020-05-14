resource "aws_iam_user" "publish" {
  name = var.publish_user

  # Not strictly necessary, but this makes the user get created last
  depends_on = [aws_cloudfront_distribution.site]
}

resource "aws_iam_access_key" "publish" {
  user = aws_iam_user.publish.name
}

# User policy
data "template_file" "publish-policy" {
  template = "${file("publish_user_policy.json")}"
  vars = {
    bucket       = aws_s3_bucket.site-bucket.arn
    distribution = aws_cloudfront_distribution.site.arn
  }
}
resource "aws_iam_user_policy" "publish" {
  name   = "${aws_iam_user.publish.name}Policy"
  user   = aws_iam_user.publish.name
  policy = data.template_file.publish-policy.rendered
}