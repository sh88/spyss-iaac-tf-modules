# CloudFront Distribution Outputs

output "distribution_id" {
  description = "The identifier for the distribution"
  value       = aws_cloudfront_distribution.main.id
}

output "domain_name" {
  description = "The domain name corresponding to the distribution"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution"
  value       = aws_cloudfront_distribution.main.arn
}

output "etag" {
  description = "The current version of the distribution's information"
  value       = aws_cloudfront_distribution.main.etag
}

output "hosted_zone_id" {
  description = "The CloudFront hosted zone ID that can be used to create alias records in Route 53"
  value       = aws_cloudfront_distribution.main.hosted_zone_id
}

output "status" {
  description = "The current status of the distribution"
  value       = aws_cloudfront_distribution.main.status
}

# output "invalidation_id" {
#   description = "The ID of the cache invalidation request"
#   value       = try(aws_cloudfront_invalidation.main[0].id, null)
# }

