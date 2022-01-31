resource "tfe_workspace" "ws" {
  name         = var.name
  organization = var.organization_name
  tag_names    = []
}