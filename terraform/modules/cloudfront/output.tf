output "distribution_id" {
  description = "CloudFront Distribution ID"
  value       = aws_cloudfront_distribution.cdn.id
}

output "domain_name" {
  description = "CloudFront Domain Name"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_arn" {
  description = "arn for aws cloudfront distribution"
  value       = aws_cloudfront_distribution.cdn.arn
}