provider "aws" {
    region = "${var.region}"
}

provider "aws" {
    region = "us-east-1"
    alias  = "virginia"
}

data "aws_caller_identity" "current" {}
