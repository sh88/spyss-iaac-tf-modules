# ECS Fargate Service Module

This module creates an ECS Fargate service with Application Load Balancer, security groups, and necessary IAM roles.

## Features

- ECS task definition with Fargate launch type
- ECS service with configurable desired count
- Application Load Balancer (ALB)
- ALB target group with health checks
- Security groups for ALB and ECS tasks
- IAM roles for task execution and task role
- CloudWatch log group for container logs
- Support for custom environment variables

## Usage

```hcl
module "ecs_fargate_service" {
  source = "../../modules/ecs-fargate-service"

  service_name     = "my-app"
  cluster_id       = "arn:aws:ecs:ap-south-1:123456789:cluster/dev"
  vpc_id           = "vpc-xxxxx"
  subnet_ids       = ["subnet-xxxxx", "subnet-yyyyy"]
  alb_subnet_ids   = ["subnet-aaaaa", "subnet-bbbbb"]

  container_name   = "app"
  container_image  = "nginx:latest"
  container_port   = 80

  task_cpu         = "512"
  task_memory      = "1024"
  desired_count    = 2

  assign_public_ip = false
  internal_alb     = false

  health_check_path = "/"

  environment_variables = [
    {
      name  = "ENV"
      value = "production"
    }
  ]

  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| service_name | Name of the ECS service | `string` | n/a | yes |
| cluster_id | ID of the ECS cluster | `string` | n/a | yes |
| vpc_id | VPC ID where resources will be created | `string` | n/a | yes |
| subnet_ids | Subnet IDs for ECS tasks | `list(string)` | n/a | yes |
| alb_subnet_ids | Subnet IDs for Application Load Balancer | `list(string)` | n/a | yes |
| container_name | Name of the container | `string` | n/a | yes |
| container_image | Docker image to run | `string` | n/a | yes |
| container_port | Port exposed by the container | `number` | `80` | no |
| task_cpu | CPU units for the task | `string` | `"256"` | no |
| task_memory | Memory for the task in MB | `string` | `"512"` | no |
| desired_count | Desired number of tasks | `number` | `1` | no |
| assign_public_ip | Assign public IP to ECS tasks | `bool` | `false` | no |
| internal_alb | Whether the ALB is internal | `bool` | `false` | no |
| listener_port | Port for ALB listener | `number` | `80` | no |
| listener_protocol | Protocol for ALB listener | `string` | `"HTTP"` | no |
| alb_ingress_cidr_blocks | CIDR blocks allowed to access the ALB | `list(string)` | `["0.0.0.0/0"]` | no |
| health_check_path | Health check path | `string` | `"/"` | no |
| health_check_interval | Health check interval in seconds | `number` | `30` | no |
| health_check_timeout | Health check timeout in seconds | `number` | `5` | no |
| health_check_healthy_threshold | Number of consecutive successful health checks | `number` | `2` | no |
| health_check_unhealthy_threshold | Number of consecutive failed health checks | `number` | `2` | no |
| health_check_matcher | HTTP response codes to consider healthy | `string` | `"200"` | no |
| log_retention_days | CloudWatch log retention in days | `number` | `7` | no |
| enable_deletion_protection | Enable deletion protection for ALB | `bool` | `false` | no |
| environment_variables | Environment variables for the container | `list(object)` | `[]` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| service_id | ID of the ECS service |
| service_name | Name of the ECS service |
| task_definition_arn | ARN of the task definition |
| alb_dns_name | DNS name of the Application Load Balancer |
| alb_zone_id | Zone ID of the Application Load Balancer |
| alb_arn | ARN of the Application Load Balancer |
| target_group_arn | ARN of the target group |
| security_group_alb_id | ID of the ALB security group |
| security_group_ecs_tasks_id | ID of the ECS tasks security group |
| log_group_name | Name of the CloudWatch log group |

## Requirements

- Terraform >= 1.0
- AWS Provider >= 4.0

## Notes

- The module creates security groups that allow traffic from ALB to ECS tasks
- ECS tasks are configured with CloudWatch Logs
- IAM roles include the necessary permissions for task execution
- Health checks are configured on the target group
