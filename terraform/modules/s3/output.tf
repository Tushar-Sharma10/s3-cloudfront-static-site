output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.origin_bucket.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.origin_bucket.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.origin_bucket.bucket_domain_name
}