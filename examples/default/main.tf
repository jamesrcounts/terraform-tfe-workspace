resource "random_pet" "project" {}

resource "tfe_organization" "org" {
  name  = "test-${random_pet.project.id}"
  email = "nobody@example.com"
}

resource "tfe_oauth_client" "github" {
  organization     = tfe_organization.org.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_pat
  service_provider = "github"
}

module "test_ws" {
  source = "../../"

  name                = "ws-test"
  oauth_token_id      = tfe_oauth_client.github.oauth_token_id
  organization_name   = tfe_organization.org.name
  repository_id       = "jamesrcounts/terraform-tfe-workspace"
  terraform_directory = "examples/default"

  environment = {
    MY_SECRET = {
      description = "This is a big secret"
      sensitive   = true
      value       = "I<3U"
    }
  }

  variables = {
    MY_PAT = {
      description = "Secret token"
      sensitive   = true
      value       = "t0pS3cret"
    }
  }
}
