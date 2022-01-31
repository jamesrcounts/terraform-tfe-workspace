resource "tfe_organization" "org" {
  name  = "test-workspaces"
  email = "nobody@example.com"
}

module "test_ws" {
  source            = "../../"
  name              = "ws-test"
  organization_name = tfe_organization.org.name
}

data "tfe_workspace" "test_ws" {
  name         = module.test_ws.name
  organization = tfe_organization.org.name
}

output "name" {
  value = data.tfe_workspace.test_ws.name
}