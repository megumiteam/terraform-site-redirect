data "aws_iam_policy_document" "s3_policy" {
    statement {
        actions   = ["s3:GetObject"]
        resources = ["arn:aws:s3:::${var.bucket_name}/*"]
    }

    statement {
        actions   = ["s3:ListBucket"]
        resources = ["arn:aws:s3:::${var.bucket_name}"]
    }
}

resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"
    policy = "${data.aws_iam_policy_document.s3_policy.json}"

    website {
        redirect_all_requests_to = "${var.s3_redirect_to}"
    }

    tags {
        Name      = "${var.bucket_name}"
        project   = "${var.project}"
        stack     = "${var.stage}"
    }
}