resource "aws_s3_bucket" "me-fe-shell-assets" {
  bucket = "me-fe-shell-assets"

  tags = {
    Name        = "me-fe-shell-assets"
    COST_CENTER = "personal-website"
  }
}
