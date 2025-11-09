# Basic Example for RDS PostgreSQL Module

This example demonstrates the minimal configuration required to create a PostgreSQL RDS instance accessible by ECS Fargate services.

## Usage

1. Update the `terraform.tfvars` file with your actual values
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

## Prerequisites

- AWS account with appropriate permissions
- Existing VPC with private subnets
- ECS Fargate service with security group

## Resources Created

- RDS PostgreSQL instance
- DB subnet group
- Security group for RDS
- Security group rules for ECS access

## Clean Up

To destroy the resources:
```bash
terraform destroy
```

**Note**: By default, a final snapshot will be created. Set `skip_final_snapshot = true` in the module to skip this.
