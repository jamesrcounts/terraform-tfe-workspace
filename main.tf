resource "tfe_workspace" "ws" {
  name         = var.name
  organization = var.organization_name
  tag_names    = []
}

resource "tfe_variable" "env" {
  for_each = var.environment

  category     = "env"
  description  = each.value.description
  key          = each.key
  sensitive    = each.value.sensitive
  value        = each.value.value
  workspace_id = tfe_workspace.ws.id
}