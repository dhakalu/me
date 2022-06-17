## todo apply lifecycle management to artifacts and logs
# Bucket for holding all the artifacts and the logs for the front-end
resource "aws_s3_bucket" "me-fe-shell-assets" {
  bucket = "me-fe-shell-assets"

  tags = {
    Name        = "me-fe-shell-assets"
    COST_CENTER = "personal-website"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "shell_assests_lifecycles" {
  bucket = aws_s3_bucket.me-fe-shell-assets.id

  rule {
    id = "logs-rule"

    filter {
      prefix = "logs/"
    }

    transition {
      days          = 0
      storage_class = "GLACIER_IR"
    }

    transition {
      days          = 90
      storage_class = "DEEP_ARCHIVE"
    }
    # ... other transition/expiration actions ...

    status = "Enabled"
  }

  rule {
    id = "builds-rule"

    filter {
      prefix = "builds/"
    }

    transition {
      days          = 0
      storage_class = "GLACIER_IR"
    }

    transition {
      days          = 90
      storage_class = "DEEP_ARCHIVE"
    }
    # ... other transition/expiration actions ...

    status = "Enabled"
  }
}

# Bucket for serving the website
resource "aws_s3_bucket" "me_fe_website" {
  bucket = "me-fe-website"

  tags = {
    Name        = "me-fe-website"
    COST_CENTER = "personal-website"
  }
}
resource "aws_s3_bucket_acl" "me-fe-shell-assets-acl" {
  bucket = aws_s3_bucket.me_fe_website.id
  acl    = "private"
}

locals {
  s3_origin_id = "me-fe-website"
}

resource "aws_cloudfront_origin_access_identity" "fe_shell_origin_access_identity" {
  comment = "Origin Access Identity for me-fe-website bucket"
}

data "aws_iam_policy_document" "s3_cloudfront_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.me_fe_website.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.fe_shell_origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "me_fe_shell_assets_policy" {
  bucket = aws_s3_bucket.me_fe_website.id
  policy = data.aws_iam_policy_document.s3_cloudfront_policy.json
}

resource "aws_cloudfront_distribution" "me_s3_distribution" {

  comment = "Serves the content from me-fe-shell-assets bucket"

  #todo configure custom error codes

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  default_root_object = "/index.html"
  enabled             = true
  is_ipv6_enabled     = false
  http_version        = "http2"
  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.me-fe-shell-assets.bucket_domain_name
    prefix          = "logs/"
  }
  origin {
    domain_name = aws_s3_bucket.me_fe_website.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.fe_shell_origin_access_identity.cloudfront_access_identity_path
    }
  }
  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = {
    Name        = "me-cloudfront-distribution"
    COST_CENTER = "personal-website"
  }
}
