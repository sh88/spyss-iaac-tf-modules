variable "group_name" {
  description = "The name of the IAM group."
  type        = string
}

variable "group_path" {
  description = "The path of the IAM group."
  type        = string
  default     = "/"
}