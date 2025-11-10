# Route53 Module

This module creates a Route53 DNS record pointing to an Application Load Balancer.

## Features

- A record with alias to ALB
- Configurable health check evaluation
- Simple integration with ALB outputs

## Usage

```hcl
module "route53" {
  source = "../../modules/route53"

  hosted_zone_id          = "Z1234567890ABC"
  record_name             = "app"
  alb_dns_name            = "my-alb-123456789.ap-south-1.elb.amazonaws.com"
  alb_zone_id             = "Z35SXDOTRQ7X7K"
  evaluate_target_health  = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hosted_zone_id | ID of the Route53 hosted zone | `string` | n/a | yes |
| record_name | DNS record name (e.g., 'app' for app.example.com) | `string` | n/a | yes |
| alb_dns_name | DNS name of the Application Load Balancer | `string` | n/a | yes |
| alb_zone_id | Zone ID of the Application Load Balancer | `string` | n/a | yes |
| evaluate_target_health | Whether to evaluate the health of the target | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| record_name | Name of the DNS record |
| record_fqdn | FQDN of the DNS record |

## Requirements

- Terraform >= 1.0
- AWS Provider >= 4.0

## Notes

- The record is created as an alias record pointing to the ALB
- Health check evaluation can be enabled/disabled
- The record name is relative to the hosted zone (e.g., 'app' becomes 'app.example.com')
