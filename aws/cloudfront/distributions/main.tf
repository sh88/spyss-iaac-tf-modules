# CloudFront distribution for S3 bucket with HTTPS and cache invalidation

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = var.s3_bucket_domain
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = var.origin_access_identity
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  default_root_object = var.default_root_object
  comment             = var.distribution_comment

  # Aliases for custom domain names
  aliases = var.aliases

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = var.query_string_enabled

      cookies {
        forward = var.cookies_forward
      }
    }

    compress               = var.compress_content
    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  price_class = var.price_class

  # Restrictions
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  # Viewer certificate configuration
  viewer_certificate {
    cloudfront_default_certificate = var.use_cloudfront_default_certificate
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.use_cloudfront_default_certificate ? null : "sni-only"
    minimum_protocol_version       = var.use_cloudfront_default_certificate ? null : var.minimum_tls_version
  }

  tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
      Module    = "cloudfront-distributions"
    }
  )

  depends_on = []
}

