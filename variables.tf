variable "project"     {}
variable "stage"       {}

variable "domain_name"     {}
variable "bucket_name"     {}
variable "ssl_cert"        {}
variable "aliases"         { type = "list" }
variable "redirect_policy" { default = "redirect-to-https" }
variable "s3_redirect_to"  {}

locals {
    cf_zone_id = "Z2FDTNDATAQYW2"
}
