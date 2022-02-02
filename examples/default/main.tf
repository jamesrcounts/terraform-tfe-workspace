resource "tfe_organization" "org" {
  name  = "test-workspaces"
  email = "nobody@example.com"
}

module "test_ws" {
  source            = "../../"
  name              = "ws-test"
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

data "tfe_variables" "test" {
  depends_on = [module.test_ws]

  workspace_id = module.test_ws.id
}

output "name" {
  value = data.tfe_workspace.test_ws.name
}

output "my_secret_name" {
  value = data.tfe_variables.test.env.0.name
}