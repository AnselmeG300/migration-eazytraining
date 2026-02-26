# define cloudfront resource parameters for import
resource "aws_cloudfront_distribution" "distribution" {
    aliases                        = data.aws_cloudfront_distribution.data_cloudfront.aliases
    enabled                        = data.aws_cloudfront_distribution.data_cloudfront.enabled
    http_version                   = data.aws_cloudfront_distribution.data_cloudfront.http_version
    is_ipv6_enabled                = data.aws_cloudfront_distribution.data_cloudfront.is_ipv6_enabled
    price_class                    = data.aws_cloudfront_distribution.data_cloudfront.price_class
    retain_on_delete               = data.aws_cloudfront_distribution.data_cloudfront.retain_on_delete
    staging                        = data.aws_cloudfront_distribution.data_cloudfront.staging
    tags                           = data.aws_cloudfront_distribution.data_cloudfront.tags
    tags_all                       = data.aws_cloudfront_distribution.data_cloudfront.tags_all
    wait_for_deployment            = data.aws_cloudfront_distribution.data_cloudfront.wait_for_deployment

    default_cache_behavior {
        allowed_methods          = data.aws_cloudfront_distribution.data_cloudfront.allowed_methods
        cache_policy_id          = data.aws_cloudfront_distribution.data_cloudfront.cache_policy_id
        cached_methods           = data.aws_cloudfront_distribution.data_cloudfront.cached_methods
        compress                 = data.aws_cloudfront_distribution.data_cloudfront.compress
        default_ttl              = data.aws_cloudfront_distribution.data_cloudfront.default_ttl
        max_ttl                  = data.aws_cloudfront_distribution.data_cloudfront.max_ttl
        min_ttl                  = data.aws_cloudfront_distribution.data_cloudfront.min_ttl 
        origin_request_policy_id = data.aws_cloudfront_distribution.data_cloudfront.origin_request_policy_id
        smooth_streaming         = data.aws_cloudfront_distribution.data_cloudfront.smooth_streaming
        target_origin_id         = data.aws_cloudfront_distribution.data_cloudfront.target_origin_id
        trusted_key_groups       = data.aws_cloudfront_distribution.data_cloudfront.trusted_key_groups
        trusted_signers          = data.aws_cloudfront_distribution.data_cloudfront.trusted_signers
        viewer_protocol_policy   = data.aws_cloudfront_distribution.data_cloudfront.viewer_protocol_policy
    }

    origin {
        connection_attempts = data.aws_cloudfront_distribution.data_cloudfront.connection_attempts
        connection_timeout  = data.aws_cloudfront_distribution.data_cloudfront.connection_timeout
        domain_name         = data.aws_cloudfront_distribution.data_cloudfront.domain_name
        origin_id           = data.aws_cloudfront_distribution.data_cloudfront.origin_id

        custom_origin_config {
            http_port                = data.aws_cloudfront_distribution.data_cloudfront.http_port
            https_port               = data.aws_cloudfront_distribution.data_cloudfront.https_port
            origin_keepalive_timeout = data.aws_cloudfront_distribution.data_cloudfront.origin_keepalive_timeout
            origin_protocol_policy   = data.aws_cloudfront_distribution.data_cloudfront.origin_protocol_policy
            origin_read_timeout      = data.aws_cloudfront_distribution.data_cloudfront.origin_read_timeout
            origin_ssl_protocols     = data.aws_cloudfront_distribution.data_cloudfront.origin_ssl_protocols
        }
    }

    restrictions {
        geo_restriction {
            locations        = data.aws_cloudfront_distribution.data_cloudfront.locations
            restriction_type = data.aws_cloudfront_distribution.data_cloudfront.restriction_type
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = data.aws_cloudfront_distribution.data_cloudfront.cloudfront_default_certificate
        minimum_protocol_version       = data.aws_cloudfront_distribution.data_cloudfront.minimum_protocol_version
    }
}