variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, stg, prod)"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "email" {
  description = "The email address for notifications"
  type        = string
}

variable "account_type" {
  description = "The type of AWS account (e.g., production, development)"
  type        = string
}

variable "costcentre" {
  description = "The cost centre associated with the resources"
  type        = string
}

variable "ecr_scan_on_push" {
  description = "Enable or disable ECR image scanning on push"
  type        = bool
  default     = false
}
