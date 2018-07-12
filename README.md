# What is it?

This Terraform template is for domain redirection without creating a server. It enabled you to create a redirection from archived site to live one or www-prefixed domain to naked domain (root domain). The redirect processes on Amazon S3 hosting, and SSL digital certificate is on CloudFront and managed with ACM which also releases you from yearly SSL updates works.
 

# Requirements

Get SSL digital certificate with ACM on us-east-1 region. 
This template never gets any SSL digital certificate or ACM.
Create or register Hosted Zone of your domain to Route53.
This template will add DNS records to Route53, but never create or register a domain to Hosted Zone on Route53.
 

# Example

Create `terraform.tfvars` to make redirection to `https://example.com` from `http://www.example.com`: 

```
"domain_name"    = "example.com"
"bucket_name"    = "redirect-bucket-name"
"ssl_cert"       = "www.example.com"
"aliases"        = [
    "www.example.com"
]
"s3_redirect_to" = "https://example.com"
​```