# terraform-tfe-workspace
Configures a Terraform Cloud workspace and variables

<!-- BEGIN_TF_DOCS -->


## Example

```hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Map of environment variables to create in the workspace. | <pre>map(object({<br>    description = string<br>    sensitive   = bool<br>    value       = string<br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The workspace name. | `string` | n/a | yes |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | (Required) The token used to access the VCS provider. | `string` | n/a | yes |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | (Required) The organization to create the workspace in. | `string` | n/a | yes |
| <a name="input_repository_id"></a> [repository\_id](#input\_repository\_id) | (Required) The repository containing Terraform configuration for this workspace. | `string` | n/a | yes |
| <a name="input_terraform_directory"></a> [terraform\_directory](#input\_terraform\_directory) | (Optional) The directory that Terraform will execute within. | `string` | `""` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | (Optional) Map of terraform variables to create in the workspace. | <pre>map(object({<br>    description = string<br>    sensitive   = bool<br>    value       = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The workspace id. |
| <a name="output_name"></a> [name](#output\_name) | The workspace name. |
<!-- END_TF_DOCS -->