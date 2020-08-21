resource "aws_acm_certificate" "glenwinters_com" {
  domain_name               = local.site_hostname
  validation_method         = "DNS"
  subject_alternative_names = ["www.${local.site_hostname}"]

  lifecycle {
    create_before_destroy = true
  }
}
