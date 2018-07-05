data "aws_route53_zone" "selected" {
    name         = "${var.domain_name}."
    private_zone = false
}

resource "aws_route53_record" "A" {
    depends_on  = [
        "aws_s3_bucket.bucket",
        "aws_cloudfront_distribution.site"
    ]

    count   = "${length(var.aliases)}"
    zone_id = "${data.aws_route53_zone.selected.id}"
    name    = "${element(var.aliases,count.index)}"
    type    = "A"
    alias {
        name    = "${aws_cloudfront_distribution.site.domain_name}"
        zone_id = "${local.cf_zone_id}"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "AAAA" {
    depends_on  = [
        "aws_s3_bucket.bucket",
        "aws_cloudfront_distribution.site"
    ]

    count   = "${length(var.aliases)}"
    zone_id = "${data.aws_route53_zone.selected.id}"
    name    = "${element(var.aliases,count.index)}"
    type    = "AAAA"
    alias {
        name    = "${aws_cloudfront_distribution.site.domain_name}"
        zone_id = "${local.cf_zone_id}"
        evaluate_target_health = false
    }
}
