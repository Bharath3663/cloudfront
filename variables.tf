variable "region" {
  type = string
  default = "us-east-2"
}

variable "bucket_name" {
  type = string
  default = "firstbucket"
}

variable "acl" {
  type = string
  default = "private"
}

variable "comment" {
  type = string
  default = "1st comment"
}

variable "default_root_object" {
  type = string
  default = "index.html"
}

variable "logging_bucket" {
  type = string
  default = "mylogs.s3.amazonaws.com"
}

variable "logging_prefix" {
  type = string
  default = "myprefix"
}

variable "allowed_methods" {
  type = list(string)
  default = [
    "DELETE",
    "GET",
    "HEAD",
    "OPTIONS",
    "PATCH",
    "POST",
    "PUT",
  ]
}

variable "cached_methods" {
  type = list(string)
  default = ["GET", "HEAD"]
}

variable "compress" {
  type = bool
  default = false  # Change to true for specific cache behaviors
}

variable "price_class" {
  type = string
  default = "PriceClass_200"
}

variable "geo_restriction_locations" {
  type = list(string)
  default = [
    "US",
    "CA",
    "GB",
    "DE",
  ]
}

variable "bucket_name_primary" {
  type = string
  default = "my-primary-bucket"
}

variable "bucket_name_failover" {
  type = string
  default = "my-failover-bucket"
}

variable "acl" {
  type = string
  default = "private"
}

variable "comment" {
  type = string
  default = "Some comment"
}

variable "default_root_object" {
  type = string
  default = "index.html"
}

variable "logging_bucket" {
  type = string
  default = "mylogs.s3.amazonaws.com"
}

variable "logging_prefix" {
  type = string
  default = "myprefix"
}

variable "allowed_methods" {
  type = list(string)
  default = [
    "DELETE",
    "GET",
    "HEAD",
    "OPTIONS",
    "PATCH",
    "POST",
    "PUT",
  ]
}

variable "cached_methods" {
  type = list(string)
  default = ["GET", "HEAD"]
}

variable "compress" {
  type = bool
  default = false  # Change to true for specific cache behaviors
}

variable "price_class" {
  type = string
  default = "PriceClass_200"
}

variable "geo_restriction_locations" {
  type = list(string)
  default = [
    "US",
    "CA",
    "GB",
    "DE",
  ]
}


