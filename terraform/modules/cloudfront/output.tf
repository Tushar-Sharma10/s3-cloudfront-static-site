output "distribution_id" {
  description = "CloudFront Distribution ID"
  value       = aws_cloudfront_distribution.cdn.id
}

output "domain_name" {
  description = "CloudFront Domain Name"
  value       = aws_cloudfront_distribution.cdn.domain_name
}