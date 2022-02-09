variable "name" {
  description = "(Required) The workspace name."
  type        = string
}

variable "organization_name" {
  description = "(Required) The organization to create the workspace in."
  type        = string
}

variable "environment" {
  description = "(Optional) Map of environment variables to create in the workspace."
  default     = {}

  type = map(object({
    description = string
    sensitive   = bool
    value       = string
  }))
}

variable "variables" {
  description = "(Optional) Map of terraform variables to create in the workspace."
  default     = {}

  type = map(object({
    description = string
    sensitive   = bool
    value       = string
  }))
}

variable "oauth_token_id" {
  description = "(Required) The token used to access the VCS provider."
  type        = string
}

variable "repository_id" {
  description = "(Required) The repository containing Terraform configuration for this workspace."
  type        = string
}

variable "terraform_directory" {
  default     = ""
  description = "(Optional) The directory that Terraform will execute within."
  type        = string
}