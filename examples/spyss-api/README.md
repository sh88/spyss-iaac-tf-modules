# SPYSS API Example

This example demonstrates how to use all modules together to create a complete ECS Fargate service with Route53 integration using Fargate Spot.

## What This Example Creates

- ECS cluster named "dev" with Fargate Spot capacity provider
- ECS Fargate service with Application Load Balancer
- Route53 DNS record pointing to the ALB
- All necessary security groups and IAM roles

## Prerequisites

1. AWS account with appropriate permissions
2. Existing VPC with:
   - Private subnets (tagged with `Tier = "Private"`)
   - Public subnets (tagged with `Tier = "Public"`)
3. Route53 hosted zone for your domain

## Usage

1. Create a `terraform.tfvars` file:

```hcl
vpc_id       = "vpc-xxxxx"
domain_name  = "example.com"
subdomain    = "app"
service_name = "my-app"

# Optional: customize container settings
container_name  = "app"
container_image = "nginx:latest"
container_port  = 80
```

2. Initialize Terraform:

```bash
terraform init
```

3. Review the plan:

```bash
terraform plan
```

4. Apply the configuration:

```bash
terraform apply
```

5. After deployment, your service will be accessible at:
   - Via ALB: Output will show `alb_dns_name`
   - Via Route53: Output will show `dns_record_fqdn` (e.g., `http://app.example.com`)

## Customization

### Using a Different Container Image

```hcl
container_image = "your-registry/your-image:tag"
container_port  = 8080
```

### Adding Environment Variables

```hcl
environment_variables = [
  {
    name  = "DATABASE_URL"
    value = "postgresql://..."
  },
  {
    name  = "API_KEY"
    value = "your-api-key"
  }
]
```

### Adjusting Task Resources

Edit the `main.tf` file and modify:

```hcl
task_cpu      = "1024"  # 1 vCPU
task_memory   = "2048"  # 2 GB
desired_count = 3       # Number of tasks
```

## Outputs

After applying, you'll see outputs including:

- `cluster_name`: Name of the ECS cluster
- `cluster_arn`: ARN of the ECS cluster
- `service_name`: Name of the ECS service
- `alb_dns_name`: DNS name of the ALB
- `dns_record_fqdn`: Fully qualified domain name
- `service_url`: URL to access the service

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

## Notes

- The example assumes you have properly tagged subnets
- If your subnets are not tagged, modify the data sources in `main.tf` to use specific subnet IDs
- The example uses HTTP (port 80) by default. For HTTPS, you'll need to add an SSL certificate
