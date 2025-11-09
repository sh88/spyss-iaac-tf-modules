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
  description = "Default capacity provider (FARGATE or FARGATE_SPOT)"
  type        = string
  default     = "FARGATE"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
