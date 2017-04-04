resource "aws_cloudfront_distribution" "cloudfront" {
  enabled             = true
  comment             = "cloudfront distribution"
  default_root_object = "${var.default_root_object}"
  http_version        = "http2"

  origin {
    domain_name = "${var.origin_domain_name}"
    origin_id   = "${var.origin_id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  aliases = ["${var.route53_subdomain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "https-only"
    min_ttl                = "${var.min_ttl}"
    default_ttl            = "${var.default_ttl}"
    max_ttl                = "${var.max_ttl}"
  }

  price_class      = "PriceClass_All"
  retain_on_delete = false

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "${var.certificate_arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Access Identity"
}
