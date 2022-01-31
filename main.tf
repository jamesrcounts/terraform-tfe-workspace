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