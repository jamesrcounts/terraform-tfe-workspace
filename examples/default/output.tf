
data "tfe_workspace" "test_ws" {
  depends_on = [module.test_ws]

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

output "repository_id" {
  value = data.tfe_workspace.test_ws.vcs_repo.0.identifier
}

output "my_secret_name" {
  value = data.tfe_variables.test.env.0.name
}

output "my_variable_name" {
  value = data.tfe_variables.test.terraform.0.name
}