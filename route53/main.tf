resource "aws_route53_record" "record" {
  zone_id = "${var.route53_zone_id}"
  name    = "${var.route53_subdomain}"
  type    = "A"

  alias {
    name                   = "${var.alias_domain_name}"
    zone_id                = "${var.alias_zone_id}"
    evaluate_target_health = "${var.evaluate_target_health_true}"
  }
}
