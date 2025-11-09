# Outputs for connecting to the PostgreSQL database

output "db_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.postgres.id
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = aws_db_instance.postgres.arn
}

output "db_instance_endpoint" {
  description = "RDS instance connection endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "db_instance_address" {
  description = "RDS instance hostname"
  value       = aws_db_instance.postgres.address
}

output "db_instance_port" {
  description = "RDS instance port"
  value       = aws_db_instance.postgres.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.postgres.db_name
}

output "db_username" {
  description = "Master username"
  value       = aws_db_instance.postgres.username
  sensitive   = true
}

output "db_security_group_id" {
  description = "Security group ID of the RDS instance"
  value       = aws_security_group.postgres.id
}

output "db_subnet_group_name" {
  description = "DB subnet group name"
  value       = aws_db_subnet_group.postgres.name
}

output "connection_string" {
  description = "PostgreSQL connection string (without password)"
  value       = "postgresql://${aws_db_instance.postgres.username}@${aws_db_instance.postgres.address}:${aws_db_instance.postgres.port}/${aws_db_instance.postgres.db_name}"
  sensitive   = true
}
