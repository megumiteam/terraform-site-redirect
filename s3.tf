resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"
    acl    = "public-read"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${var.bucket_name}"
        }
    ]
}
POLICY

    website {
        redirect_all_requests_to = "${var.s3_redirect_to}"
    }

    tags {
        Name      = "${var.bucket_name}"
    }
}