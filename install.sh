#!/bin/bash
brew install pre-commit terraform-docs tflint tfsec coreutils checkov terrascan infracost jq

DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}

pre-commit install

