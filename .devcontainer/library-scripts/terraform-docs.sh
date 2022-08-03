#!/usr/bin/env bash
set -euo pipefail

curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
rm terraform-docs.tar.gz

chmod +x terraform-docs
mv terraform-docs /usr/local/bin/terraform-docs