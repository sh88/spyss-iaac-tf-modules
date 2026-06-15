variable "group_names" {
    description = "The name of the IAM group."
    type        = list(string)
}

variable "group_path" {
  description = "The path of the IAM group."
  type        = string
  default     = "/"
}