output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs_cluster.cluster_name
}

output "cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs_cluster.cluster_arn
}

output "service_name" {
  description = "Name of the ECS service"
  value       = module.ecs_fargate_service.service_name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.ecs_fargate_service.alb_dns_name
}

output "dns_record_fqdn" {
  description = "Fully qualified domain name of the DNS record"
  value       = module.route53.record_fqdn
}

output "service_url" {
  description = "URL to access the service"
  value       = "http://${module.route53.record_fqdn}"
}
