variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "dev"
}

variable "container_insights_enabled" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = true
}

variable "default_capacity_provider" {
  description = "Default capacity provider (FARGATE_SPOT only)"
  type        = string
  default     = "FARGATE_SPOT"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
