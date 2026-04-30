output "website_url" {
  description = "Website url to get access of static website"
  value       = module.cloudfront.domain_name
}