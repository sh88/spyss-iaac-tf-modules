# spyss-iaac-tf-modules

Terraform modules for AWS infrastructure as code, including ECS Fargate services with Route53 integration.

## Modules

### ecs-cluster

Creates an ECS cluster with Fargate capacity providers.

**Features:**
- ECS cluster with configurable name (default: "dev")
- Fargate and Fargate Spot capacity providers
- Optional CloudWatch Container Insights

**Usage:**
```hcl
module "ecs_cluster" {
  source = "./modules/ecs-cluster"

  cluster_name                = "dev"
  container_insights_enabled  = true
  default_capacity_provider   = "FARGATE"

  tags = {
    Environment = "dev"
  }
}
```

### ecs-fargate-service

Creates an ECS Fargate service with Application Load Balancer.

**Features:**
- ECS task definition with Fargate launch type
- ECS service with configurable desired count
- Application Load Balancer (ALB)
- ALB target group with health checks
- Security groups for ALB and ECS tasks
- IAM roles for task execution and task role
- CloudWatch log group for container logs

**Usage:**
```hcl
module "ecs_fargate_service" {
  source = "./modules/ecs-fargate-service"

  service_name     = "my-app"
  cluster_id       = module.ecs_cluster.cluster_id
  vpc_id           = "vpc-xxxxx"
  subnet_ids       = ["subnet-xxxxx", "subnet-yyyyy"]
  alb_subnet_ids   = ["subnet-aaaaa", "subnet-bbbbb"]

  container_name   = "app"
  container_image  = "nginx:latest"
  container_port   = 80

  task_cpu         = "512"
  task_memory      = "1024"
  desired_count    = 2
}
```

### route53

Creates a Route53 DNS record pointing to an Application Load Balancer.

**Features:**
- A record with alias to ALB
- Configurable health check evaluation

**Usage:**
```hcl
module "route53" {
  source = "./modules/route53"

  hosted_zone_id          = "Z1234567890ABC"
  record_name             = "app"
  alb_dns_name            = module.ecs_fargate_service.alb_dns_name
  alb_zone_id             = module.ecs_fargate_service.alb_zone_id
  evaluate_target_health  = true
}
```

## Complete Example

See the [complete example](./examples/complete) for a full working configuration that demonstrates:
- Creating an ECS cluster named "dev"
- Deploying a Fargate service with ALB
- Setting up Route53 DNS record for service access

### Prerequisites

1. AWS account with appropriate permissions
2. Existing VPC with public and private subnets
3. Route53 hosted zone for your domain

### Example Usage

```bash
cd examples/complete

# Create terraform.tfvars file
cat > terraform.tfvars <<EOF
vpc_id       = "vpc-xxxxx"
domain_name  = "example.com"
subdomain    = "app"
service_name = "my-app"
EOF

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

After deployment, your service will be accessible at `http://app.example.com`

## Module Requirements

- Terraform >= 1.0
- AWS Provider >= 4.0

## Architecture

The modules create the following architecture:

```
┌─────────────────────────────────────────────────────────────────┐
│                         Route53 Hosted Zone                     │
│                    (app.example.com → ALB)                      │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                   Application Load Balancer                     │
│                        (Public Subnets)                         │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                         ECS Cluster (dev)                       │
│  ┌────────────────────────────────────────────────────────┐    │
│  │              ECS Fargate Service                       │    │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │    │
│  │  │   Task 1     │  │   Task 2     │  │   Task N     │ │    │
│  │  │  (Container) │  │  (Container) │  │  (Container) │ │    │
│  │  └──────────────┘  └──────────────┘  └──────────────┘ │    │
│  │                  (Private Subnets)                     │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

## Security

- ALB is placed in public subnets and accepts traffic on port 80 (configurable)
- ECS tasks are placed in private subnets
- Security groups restrict traffic between ALB and ECS tasks
- IAM roles follow the principle of least privilege
- CloudWatch logs enabled for monitoring and debugging

## License

This project is licensed under the MIT License.