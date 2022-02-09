default: test

DEFAULT_EXAMPLE := examples/default

fmt:
	terraform fmt -recursive

init:
	cd $(DEFAULT_EXAMPLE) && \
		terraform init -upgrade && \
		terraform providers && \
		terraform version

apply: fmt
	bash scripts/deploy.sh

test: fmt
	bash scripts/test.sh
