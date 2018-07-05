variable "project"         {}
variable "stage"           {}

variable "region"          { default = "us-east-1" }
variable "domain_name"     {}
variable "bucket_name"     {}
variable "ssl_cert"        {}
variable "aliases"         { type = "list" }
variable "redirect_policy" { default = "allow-all" }
variable "s3_redirect_to"  {}
variable "minimum_protocol_version" { default = "TLSv1" }

locals {
    cf_zone_id = "Z2FDTNDATAQYW2"
}
