# これは何？
閉鎖したサイトや、www 有りを無しにリダイレクトさせるなど単純にドメインのリダイレクトをしたいんだけど、サーバを建てたくは無いなというときに使います。
リダイレクト処理はS3ホスティングで行い、SSL証明書はCloudFrontに設置されたACMで管理するので一度作れば管理する必要がありません。

# 前提条件

このテンプレートではACMの取得は行いません。
事前に us-east-1 にて ACM で SSL証明書を取得しておいてください。

このテンプレートでは、Route53 へのレコード登録は行いますが Hosted Zone の登録は行いません。

# variable について

`www.example.com` を `https://example.com` にリダイレクトさせるには `terraform.tfvars` で設定するには、以下の感じで

```
"domain_name"    = "example.com"
"bucket_name"    = "redirect-bucket-name"
"ssl_cert"       = "www.example.com"
"aliases"        = [
    "www.example.com"
]
"s3_redirect_to" = "https://example.com"
```