resource "tfe_workspace" "ws" {
  name         = var.name
  organization = var.organization_name
  tag_names    = []
}

resource "tfe_oauth_client" "github" {
  organization     = var.organization_name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_pat
  service_provider = "github"
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