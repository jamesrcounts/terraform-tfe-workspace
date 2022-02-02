#!/usr/bin/env bash
set -euo pipefail

terraform fmt -recursive

cd examples/default
# echo "github_pat=\"$AZDO_GITHUB_SERVICE_CONNECTION_PAT\"" > terraform.secrets.auto.tfvars
terraform apply