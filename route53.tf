data "aws_route53_zone" "glenwinters_com" {
  name         = "glenwinters.com"
  private_zone = false
}

resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.glenwinters_com.zone_id
  name    = local.site_hostname
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "website_www" {
  zone_id = data.aws_route53_zone.glenwinters_com.zone_id
  name    = "www.${local.site_hostname}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = false
  }
}