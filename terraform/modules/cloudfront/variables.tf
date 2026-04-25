variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  type        = bool
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution."
  type        = bool
  default     = true
}

variable "bucket_domain_name" {
  type = string
}

variable "default_root_object" {
  type        = string
  description = "Object that you want CloudFront to return"
  default     = "index.html"
}

variable "origin_id" {
  type        = string
  description = "Unique identifier"
  default     = "s3-origin"
}

variable "viewer_protocol_policy" {
  type        = string
  description = "Use this element to specify the protocol that users can use to access the files in the origin"
  default     = "redirect-to-https"

  validation {
    condition     = contains(["allow-all", "https-only", "redirect-to-https"], var.viewer_protocol_policy)
    error_message = "View protocol policy should be allow-all, https-only, redirect to https."
  }
}

variable "allowed_methods" {
  description = "Allowed HTTP methods for CloudFront"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cached_methods" {
  description = "Cached HTTP methods for CloudFront"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "restriction_type" {
  type        = string
  description = "Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  default     = "none"

  validation {
    condition     = contains(["none", "whitelist", "blacklist"], var.restriction_type)
    error_message = "Value should be none, whitelist or blacklist"
  }
}

variable "cloudfront_default_certificate" {
  description = "if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution."
  type        = bool
  default     = true
}