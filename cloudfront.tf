locals {
    origin_id-media = "${var.project}-${var.stage}-S3"
}

data "aws_acm_certificate" "selected" {
    provider = "aws.virginia"
    domain   = "${var.ssl_cert}"
    statuses = ["ISSUED"]
}

resource "aws_cloudfront_distribution" "site" {
    enabled             = true
    aliases             = ["${var.aliases}"]
    price_class         = "PriceClass_All"
    http_version        = "http2"
    is_ipv6_enabled     = true

    origin {
        domain_name = "${aws_s3_bucket.bucket.id}.${aws_s3_bucket.bucket.website_domain}"
        origin_id   = "${local.origin_id-media}"
        custom_origin_config {
            http_port              = 80
            https_port             = 443
            origin_protocol_policy = "http-only"
            origin_ssl_protocols   = ["TLSv1","TLSv1.1","TLSv1.2"]
            origin_read_timeout    = 60
        }
    }

    viewer_certificate {
        acm_certificate_arn      = "${data.aws_acm_certificate.selected.arn}"
        ssl_support_method       = "sni-only"
        minimum_protocol_version = "TLSv1"
        cloudfront_default_certificate = false
    }

    tags {
        project   = "${var.project}"
        stack     = "${var.stage}"
    }

    restrictions {
        geo_restriction {
            restriction_type         = "none"
        }
    }

    default_cache_behavior {
        target_origin_id          = "${local.origin_id-media}"
        allowed_methods           = ["GET", "HEAD"]
        cached_methods            = ["GET", "HEAD"]
        forwarded_values {
            headers                   = []
            query_string              = true
            cookies {
                forward                   = "none"
            }
        }
        viewer_protocol_policy    = "${var.redirect_policy}"
        min_ttl                   = 43200
        default_ttl               = 86400
        max_ttl                   = 86400
        smooth_streaming          = false
        compress                  = true
    }
}
