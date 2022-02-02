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