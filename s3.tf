# HTTP-only static site served by S3
resource "aws_s3_bucket" "website" {
  bucket        = local.site_hostname
  acl           = "private"
  force_destroy = false

  website {
    error_document = "404.html"
    index_document = "index.html"
  }
}

data "aws_iam_policy_document" "website" {
  statement {
    sid = "S3GetObjectForAll"

    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.website.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }

  statement {
    sid = "S3ListBucketForCloudFront"

    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.website.id}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.default.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.website.json
}