output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = module.postgres.db_instance_endpoint
}

output "db_instance_address" {
  description = "RDS instance hostname"
  value       = module.postgres.db_instance_address
}

output "db_instance_port" {
  description = "RDS instance port"
  value       = module.postgres.db_instance_port
}

output "db_name" {
  description = "Database name"
  value       = module.postgres.db_name
}

output "db_username" {
  description = "Master username"
  value       = module.postgres.db_username
  sensitive   = true
}

output "db_security_group_id" {
  description = "Security group ID of the RDS instance"
  value       = module.postgres.db_security_group_id
}

output "connection_string" {
  description = "PostgreSQL connection string (without password)"
  value       = module.postgres.connection_string
  sensitive   = true
}
