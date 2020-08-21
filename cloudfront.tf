resource "aws_cloudfront_origin_access_identity" "default" {
  comment = "glenwinters.com-${var.environment}"
}

resource "aws_cloudfront_distribution" "website" {
  enabled             = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100" # US, Europe
  is_ipv6_enabled = true
  depends_on          = [aws_s3_bucket.website]

  aliases = [local.site_hostname, "www.${local.site_hostname}"]

  origin {
    domain_name = aws_s3_bucket.website.website_endpoint
    origin_id   = "S3-glenwinters.com-${var.environment}"

    custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.glenwinters_com.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2019"
    cloudfront_default_certificate = false
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-glenwinters.com-${var.environment}"
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}