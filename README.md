# spyss-iaac-tf-modules

Terraform modules for AWS infrastructure as code.

## Available Modules

### RDS PostgreSQL Module

Creates an AWS RDS PostgreSQL database instance with minimal configuration that is accessible by ECS Fargate services.

**Location**: `modules/rds-postgres`

**Features**:
- PostgreSQL RDS instance with sensible defaults
- Dedicated security group with ingress rule for ECS Fargate access
- DB subnet group for multi-AZ support
- Storage encryption enabled by default
- Automated backups with 7-day retention
- CloudWatch logs export enabled
- Auto-scaling storage support

**Quick Start**:
```hcl
module "postgres" {
  source = "./modules/rds-postgres"

  name                   = "myapp-db"
  vpc_id                 = "vpc-xxxxx"
  subnet_ids             = ["subnet-xxxxx", "subnet-yyyyy"]
  ecs_security_group_id  = "sg-xxxxx"
  master_password        = var.db_password
}
```

See [modules/rds-postgres/README.md](aws/rds-postgres/README.md) for detailed documentation.

## Examples

The `examples/` directory contains working examples for each module:

- `examples/basic` - Basic RDS PostgreSQL setup

## Usage

1. Clone this repository
2. Reference the modules in your Terraform configuration
3. Provide required variables
4. Run `terraform init`, `terraform plan`, and `terraform apply`

## Requirements

- Terraform >= 1.0
- AWS Provider >= 4.0

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

MIT
