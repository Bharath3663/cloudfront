# Configure AWS provider
provider "aws" {
   region = var.region  
}

# Create S3 bucket resource
resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name

  tags = {
    Name = "My bucket"
  }
}

# Set S3 bucket ACL
resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.b.id
  acl    = var.acl
}

# Define CloudFront origin ID (local value)
locals {
  s3_origin_id = "myS3Origin"
}

# Create CloudFront distribution
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

  # Ordered cache behaviors (modify as needed)
  # ... (you can add additional ordered_cache_behavior blocks here)

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

