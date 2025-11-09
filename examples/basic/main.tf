terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Use the RDS PostgreSQL module
module "postgres" {
  source = "../../modules/rds-postgres"

  name                  = var.db_name
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  ecs_security_group_id = var.ecs_security_group_id
  master_password       = var.master_password

  # Optional: Override defaults
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  multi_az          = var.multi_az

  # For testing/development only
  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection

  tags = var.tags
}
