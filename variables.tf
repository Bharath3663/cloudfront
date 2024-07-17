variable "region" {
  type = string
  default = "us-east-1"
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

