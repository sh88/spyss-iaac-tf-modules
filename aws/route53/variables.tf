variable "hosted_zone_id" {
  description = "ID of the Route53 hosted zone"
  type        = string
}

variable "record_name" {
  description = "DNS record name (e.g., 'app' for app.example.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  type        = string
}

variable "evaluate_target_health" {
  description = "Whether to evaluate the health of the target"
  type        = bool
  default     = true
}
