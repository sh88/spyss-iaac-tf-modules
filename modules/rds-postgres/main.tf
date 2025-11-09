# RDS PostgreSQL Database Module
# This module creates an RDS PostgreSQL instance accessible by ECS Fargate services

# DB Subnet Group
resource "aws_db_subnet_group" "postgres" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    {
      Name = "${var.name}-subnet-group"
    },
    var.tags
  )
}

# Security Group for RDS
resource "aws_security_group" "postgres" {
  name_prefix = "${var.name}-rds-"
  description = "Security group for ${var.name} RDS PostgreSQL instance"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name = "${var.name}-rds-sg"
    },
    var.tags
  )
}

# Ingress rule to allow PostgreSQL access from ECS Fargate security group
resource "aws_security_group_rule" "postgres_ingress" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.ecs_security_group_id
  security_group_id        = aws_security_group.postgres.id
  description              = "Allow PostgreSQL access from ECS Fargate"
}

# Egress rule (if needed for maintenance/updates)
resource "aws_security_group_rule" "postgres_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgres.id
  description       = "Allow all outbound traffic"
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "postgres" {
  identifier     = var.name
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  db_name  = var.database_name
  username = var.master_username
  password = var.master_password
  port     = 5432

  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [aws_security_group.postgres.id]
  publicly_accessible    = var.publicly_accessible

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.name}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  deletion_protection = var.deletion_protection
  multi_az            = var.multi_az

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
