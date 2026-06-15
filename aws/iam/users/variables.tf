variable "users" {
  description = "List of users to be created"
  type        = list(string)
}

variable "initial_password" {
  description = "Initial password for the users"
  type        = string
  default = "ChangeMe123!"
}