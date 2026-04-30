data "aws_cloudfront_cache_policy" "cache_optimized" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = var.oac_name
  description                       = var.oac_description
  origin_access_control_origin_type = var.origin_access_control_origin_type
  signing_behavior                  = var.signing_behavior
  signing_protocol                  = var.signing_protocol
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  default_root_object = var.default_root_object

  origin {
    domain_name              = var.bucket_domain_name
    origin_id                = var.origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    target_origin_id       = var.origin_id
    viewer_protocol_policy = var.viewer_protocol_policy
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    cache_policy_id        = data.aws_cloudfront_cache_policy.cache_optimized.id
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/error.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/error.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
  }
}