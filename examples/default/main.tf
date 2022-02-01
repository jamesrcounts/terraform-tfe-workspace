resource "tfe_organization" "org" {
  name  = "test-workspaces"
  email = "nobody@example.com"
}

module "test_ws" {
  source            = "../../"
  name              = "ws-test"
  github_pat        = var.github_pat
  organization_name = tfe_organization.org.name

  environment = {
    MY_SECRET = {
      description = "This is a big secret"
      sensitive   = true
      value       = "I<3U"
    }
  }
}

data "tfe_workspace" "test_ws" {
  name         = module.test_ws.name
  organization = tfe_organization.org.name
}

data "tfe_oauth_client" "client" {
  oauth_client_id = module.test_ws.oauth_client_id
}

data "tfe_variables" "test" {
  workspace_id = module.test_ws.id
}

output "name" {
  value = data.tfe_workspace.test_ws.name
}

output "oauth_http_url" {
  value = data.tfe_oauth_client.client.http_url
}

output "my_secret_name" {
  value = data.tfe_variables.test.env.0.name
}