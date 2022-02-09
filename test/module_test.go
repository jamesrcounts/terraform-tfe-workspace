package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestWorkspace(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/default",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	actualName := terraform.Output(t, terraformOptions, "name")
	actualSecretName := terraform.Output(t, terraformOptions, "my_secret_name")
	actualRepositoryId := terraform.Output(t, terraformOptions, "repository_id")
	actualVariableName := terraform.Output(t, terraformOptions, "my_variable_name")

	assert.Equal(t, "ws-test", actualName)
	assert.Equal(t, "MY_SECRET", actualSecretName)
	assert.Equal(t, "MY_PAT", actualVariableName)
	assert.Equal(t, "jamesrcounts/terraform-tfe-workspace", actualRepositoryId)
}
