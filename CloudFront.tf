provider "aws" {
   region = var.region  
}

resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name

  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.b.id
  acl    = var.acl
}

locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.b.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id = local.s3_origin_id
  }

  enabled = true
  is_ipv6_enabled = true
  comment = var.comment
  default_root_object = var.default_root_object

  logging_config {
    include_cookies = false
    bucket = var.logging_bucket
    prefix = var.logging_prefix
  }

  aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods = var.allowed_methods
    cached_methods = var.cached_methods
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = var.geo_restriction_locations
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Configure AWS provider
provider "aws" {
  region = "us-east-1"  # Update with your desired region
}

# Create S3 buckets (modify names as needed)
resource "aws_s3_bucket" "primary" {
  bucket = var.bucket_name_primary

  tags = {
    Name = "Primary S3 Bucket"
  }

  acl = var.acl
}

resource "aws_s3_bucket" "failover" {
  bucket = var.bucket_name_failover

  tags = {
    Name = "Failover S3 Bucket"
  }

  acl = var.acl
}

# Define CloudFront origin access identity (optional, comment out if using default)
# resource "aws_cloudfront_origin_access_identity" "default" { }

# Origin Group definition
resource "aws_cloudfront_origin_group" "s3_group" {

  origin_id = "groupS3"

  failover_criteria {
    status_codes = [403, 404, 500, 502]
  }

  member {
    origin_id = "primaryS3"
  }

  member {
    origin_id = "failoverS3"
  }
}

# Primary S3 Origin definition
resource "aws_cloudfront_origin" "primary_s3" {
  domain_name = aws_s3_bucket.primary.bucket_regional_domain_name
  origin_id = "primaryS3"

  s3_origin_config {
    origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path  # Uncomment if using OAI
    # Alternatively, set the ARN directly if OAI path is not available
  }
}

# Failover S3 Origin definition
resource "aws_cloudfront_origin" "failover_s3" {
  domain_name = aws_s3_bucket.failover.bucket_regional_domain_name
  origin_id = "failoverS3"

  s3_origin_config {
    origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path  # Uncomment if using OAI
    # Alternatively, set the ARN directly if OAI path is not available
  }
}

# CloudFront distribution definition
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin_group {
    origin_id = aws_cloudfront_origin_group.


