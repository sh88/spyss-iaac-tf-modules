# ECS Cluster Module

This module creates an ECS cluster with Fargate Spot capacity provider.

## Features

- ECS cluster with configurable name
- Fargate Spot capacity provider (default)
- Optional CloudWatch Container Insights
- Tagging support

## Usage

```hcl
module "ecs_cluster" {
  source = "../../modules/ecs-cluster"

  cluster_name                = "dev"
  container_insights_enabled  = true
  default_capacity_provider   = "FARGATE_SPOT"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | Name of the ECS cluster | `string` | `"dev"` | no |
| container_insights_enabled | Enable CloudWatch Container Insights | `bool` | `true` | no |
| default_capacity_provider | Default capacity provider (FARGATE_SPOT only) | `string` | `"FARGATE_SPOT"` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | ID of the ECS cluster |
| cluster_name | Name of the ECS cluster |
| cluster_arn | ARN of the ECS cluster |

## Requirements

- Terraform >= 1.0
- AWS Provider >= 4.0
