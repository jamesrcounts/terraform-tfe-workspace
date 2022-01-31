variable "github_pat" {
  description = "(Required) The github PAT used to create an oauth client in the workspace."
  sensitive   = true
  type        = string
}