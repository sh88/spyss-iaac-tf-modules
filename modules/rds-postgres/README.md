# RDS PostgreSQL Module

This Terraform module creates an AWS RDS PostgreSQL database instance with minimal configuration that is accessible by ECS Fargate services.

## Features

- PostgreSQL RDS instance with sensible defaults
- Dedicated security group with ingress rule for ECS Fargate access
- DB subnet group for multi-AZ support
- Storage encryption enabled by default
- Automated backups with 7-day retention
- CloudWatch logs export enabled
- Auto-scaling storage support

## Usage

### Basic Example

```hcl
module "postgres" {
  source = "./modules/rds-postgres"

  name                   = "myapp-db"
  vpc_id                 = "vpc-xxxxx"
  subnet_ids             = ["subnet-xxxxx", "subnet-yyyyy"]
  ecs_security_group_id  = "sg-xxxxx"
  master_password        = "your-secure-password"  # Use AWS Secrets Manager in production
}
```

### Production Example with Custom Configuration

```hcl
module "postgres" {
  source = "./modules/rds-postgres"

  name                   = "myapp-prod-db"
  vpc_id                 = var.vpc_id
  subnet_ids             = var.private_subnet_ids
  ecs_security_group_id  = module.ecs_service.security_group_id
  
  # Database configuration
  database_name          = "myapp"
  master_username        = "dbadmin"
  master_password        = data.aws_secretsmanager_secret_version.db_password.secret_string
  
  # Instance configuration
  engine_version         = "15.4"
  instance_class         = "db.t3.small"
  allocated_storage      = 50
  max_allocated_storage  = 200
  storage_type           = "gp3"
  
  # High availability
  multi_az               = true
  deletion_protection    = true
  
  # Backup configuration
  backup_retention_period = 14
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"
  
  # Monitoring
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  
  tags = {
    Environment = "production"
    Application = "myapp"
    ManagedBy   = "terraform"
  }
}
```

### Using with ECS Fargate Task Definition

After creating the RDS instance, use the outputs in your ECS task definition:

```hcl
resource "aws_ecs_task_definition" "app" {
  family                   = "myapp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "myapp"
      image = "myapp:latest"
      environment = [
        {
          name  = "DB_HOST"
          value = module.postgres.db_instance_address
        },
        {
          name  = "DB_PORT"
          value = tostring(module.postgres.db_instance_port)
        },
        {
          name  = "DB_NAME"
          value = module.postgres.db_name
        },
        {
          name  = "DB_USER"
          value = module.postgres.db_username
        }
      ]
      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = aws_secretsmanager_secret.db_password.arn
        }
      ]
      # ... other container configuration
    }
  ])
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Inputs

### Required Inputs

| Name | Description | Type |
|------|-------------|------|
| name | Name identifier for the RDS instance | `string` |
| vpc_id | VPC ID where the RDS instance will be created | `string` |
| subnet_ids | List of subnet IDs for the DB subnet group | `list(string)` |
| ecs_security_group_id | Security group ID of the ECS Fargate service | `string` |
| master_password | Master password for the database | `string` |

### Optional Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| master_username | Master username for the database | `string` | `"postgres"` |
| database_name | Name of the default database to create | `string` | `"postgres"` |
| engine_version | PostgreSQL engine version | `string` | `"15.4"` |
| instance_class | RDS instance class | `string` | `"db.t3.micro"` |
| allocated_storage | Allocated storage in GB | `number` | `20` |
| max_allocated_storage | Maximum allocated storage for autoscaling in GB | `number` | `100` |
| storage_type | Storage type (gp2, gp3, io1) | `string` | `"gp3"` |
| storage_encrypted | Enable storage encryption | `bool` | `true` |
| publicly_accessible | Whether the database should be publicly accessible | `bool` | `false` |
| backup_retention_period | Backup retention period in days | `number` | `7` |
| backup_window | Preferred backup window | `string` | `"03:00-04:00"` |
| maintenance_window | Preferred maintenance window | `string` | `"mon:04:00-mon:05:00"` |
| skip_final_snapshot | Skip final snapshot when destroying the database | `bool` | `false` |
| deletion_protection | Enable deletion protection | `bool` | `true` |
| multi_az | Enable Multi-AZ deployment | `bool` | `false` |
| enabled_cloudwatch_logs_exports | List of log types to export to CloudWatch | `list(string)` | `["postgresql", "upgrade"]` |
| tags | Additional tags for the resources | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_id | RDS instance ID |
| db_instance_arn | RDS instance ARN |
| db_instance_endpoint | RDS instance connection endpoint |
| db_instance_address | RDS instance hostname |
| db_instance_port | RDS instance port |
| db_name | Database name |
| db_username | Master username (sensitive) |
| db_security_group_id | Security group ID of the RDS instance |
| db_subnet_group_name | DB subnet group name |
| connection_string | PostgreSQL connection string without password (sensitive) |

## Security Best Practices

1. **Password Management**: Always use AWS Secrets Manager to store and retrieve database passwords:
   ```hcl
   data "aws_secretsmanager_secret_version" "db_password" {
     secret_id = "myapp/db/password"
   }
   
   module "postgres" {
     source          = "./modules/rds-postgres"
     # ... other variables
     master_password = data.aws_secretsmanager_secret_version.db_password.secret_string
   }
   ```

2. **Encryption**: Storage encryption is enabled by default. Consider enabling encryption at rest using KMS:
   ```hcl
   storage_encrypted = true
   kms_key_id       = aws_kms_key.rds.arn
   ```

3. **Network Security**: The module creates a security group that only allows access from the specified ECS security group. Never set `publicly_accessible = true` in production.

4. **Deletion Protection**: Enabled by default. Disable only when necessary for non-production environments.

## Notes

- The module uses private subnets for the database by default
- Multi-AZ is disabled by default for cost savings but should be enabled for production
- CloudWatch logs export is enabled for PostgreSQL logs and upgrade logs
- Storage autoscaling is enabled with a maximum of 100 GB by default
- Final snapshot is created by default when destroying the database (can be disabled with `skip_final_snapshot = true`)

## License

MIT
