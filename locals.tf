locals {
  domain        = "glenwinters.com"
  domain_prefix = var.environment == "production" ? "" : "${var.environment}."
  site_hostname = "${local.domain_prefix}${local.domain}"
}
