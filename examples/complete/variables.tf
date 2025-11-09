variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "domain_name" {
  description = "Domain name of the Route53 hosted zone (e.g., example.com)"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the service (e.g., 'app' for app.example.com)"
  type        = string
  default     = "app"
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "my-app"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "app"
}

variable "container_image" {
  description = "Docker image to run (e.g., nginx:latest)"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "environment_variables" {
  description = "Environment variables for the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
