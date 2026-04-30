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

variable "oac_name" {
  type        = string
  description = "A name that identifies the Origin Access Control."
  default     = "s3-oac"
}

variable "oac_description" {
  type        = string
  description = "The description of the Origin Access Control."
  default     = "Managed by Terraform"
}

variable "origin_access_control_origin_type" {
  type        = string
  description = "The type of origin that this Origin Access Control is for."
  default     = "s3"

  validation {
    condition     = contains(["lambda", "mediapackagev2", "mediastore", "s3"], var.origin_access_control_origin_type)
    error_message = "Valid values are lambda, mediapackagev2, mediastore, and s3"
  }
}

variable "signing_behavior" {
  description = "Specifies which requests CloudFront signs."
  type        = string
  default     = "always"

  validation {
    condition     = contains(["always", "never", "no-override"], var.signing_behavior)
    error_message = "Vaild values must be always, never or no-override"
  }
}

variable "signing_protocol" {
  description = "Determines how CloudFront signs (authenticates) requests."
  type        = string
  default     = "sigv4"

  validation {
    condition     = contains(["sigv4"], var.signing_protocol)
    error_message = "The only valid value is sigv4"
  }
}