#!/usr/bin/env bash

set -euo pipefail

terraform fmt -recursive

cd test
go fmt
go test -v