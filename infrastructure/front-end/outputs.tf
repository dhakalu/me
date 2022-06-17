output "cloud_formation_domain_name" {
  value = aws_cloudfront_distribution.me_s3_distribution.domain_name
}
