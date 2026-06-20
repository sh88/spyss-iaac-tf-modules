# CloudFront Distribution Variables

variable "s3_bucket_domain" {
  description = "The domain name of the S3 bucket (e.g., mybucket.s3.amazonaws.com)"
  type        = string
}

variable "origin_id" {
  description = "Unique identifier for the S3 origin"
  type        = string
  default     = "myS3Origin"
}

variable "origin_access_identity" {
  description = "The CloudFront origin access identity for S3 bucket (e.g., origin-access-identity/cloudfront/ABCDEFG1234567)"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content"
  type        = bool
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether IPv6 is enabled for the distribution"
  type        = bool
  default     = true
}

variable "default_root_object" {
  description = "The object that CloudFront returns when an end user requests the root URL"
  type        = string
  default     = "index.html"
}

variable "distribution_comment" {
  description = "Any comments you want to include about the distribution"
  type        = string
  default     = "CloudFront distribution for S3 bucket"
}

variable "aliases" {
  description = "List of CNAMEs (alternate domain names) for the distribution"
  type        = list(string)
  default     = []
}

variable "allowed_methods" {
  description = "List of allowed HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "List of HTTP methods that CloudFront caches"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "query_string_enabled" {
  description = "Whether CloudFront forwards query strings to the origin"
  type        = bool
  default     = false
}

variable "cookies_forward" {
  description = "Forward cookies to origin. Options: 'none', 'all', or 'whitelist'"
  type        = string
  default     = "none"
}

variable "compress_content" {
  description = "Whether CloudFront automatically compresses certain files"
  type        = bool
  default     = true
}

variable "viewer_protocol_policy" {
  description = "Policy for viewer protocol. Options: 'allow-all', 'https-only', 'redirect-to-https'"
  type        = string
  default     = "redirect-to-https"
}

variable "min_ttl" {
  description = "Minimum TTL in seconds"
  type        = number
  default     = 0
}

variable "default_ttl" {
  description = "Default TTL in seconds"
  type        = number
  default     = 3600
}

variable "max_ttl" {
  description = "Maximum TTL in seconds"
  type        = number
  default     = 86400
}

variable "price_class" {
  description = "Price class for the distribution. Options: 'PriceClass_All', 'PriceClass_100', 'PriceClass_200'"
  type        = string
  default     = "PriceClass_All"
}

variable "geo_restriction_type" {
  description = "Restriction type. Options: 'none', 'whitelist', 'blacklist'"
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "ISO 3166-1-alpha-2 codes for geo restriction"
  type        = list(string)
  default     = []
}

variable "use_cloudfront_default_certificate" {
  description = "Whether to use the default CloudFront certificate"
  type        = bool
  default     = true
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS (required if not using CloudFront default certificate)"
  type        = string
  default     = ""
}

variable "minimum_tls_version" {
  description = "Minimum TLS version. Options: 'TLSv1', 'TLSv1_2_2019_08', 'TLSv1_2_2021_06'"
  type        = string
  default     = "TLSv1_2_2021_06"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

