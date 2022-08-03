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

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: (Required) The workspace name.

Type: `string`

### <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id)

Description: (Required) The token used to access the VCS provider.

Type: `string`

### <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name)

Description: (Required) The organization to create the workspace in.

Type: `string`

### <a name="input_repository_id"></a> [repository\_id](#input\_repository\_id)

Description: (Required) The repository containing Terraform configuration for this workspace.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_environment"></a> [environment](#input\_environment)

Description: (Optional) Map of environment variables to create in the workspace.

Type:

```hcl
map(object({
    description = string
    sensitive   = bool
    value       = string
  }))
```

Default: `{}`

### <a name="input_terraform_directory"></a> [terraform\_directory](#input\_terraform\_directory)

Description: (Optional) The directory that Terraform will execute within.

Type: `string`

Default: `""`

### <a name="input_variables"></a> [variables](#input\_variables)

Description: (Optional) Map of terraform variables to create in the workspace.

Type:

```hcl
map(object({
    description = string
    sensitive   = bool
    value       = string
  }))
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output\_id)

Description: The workspace id.

### <a name="output_name"></a> [name](#output\_name)

Description: The workspace name.
<!-- END_TF_DOCS -->