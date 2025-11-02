#!/bin/bash

set -euo pipefail

WORKSPACE=${TERRAFORM_WORKSPACE:-}

echo "=== Terraform Deployment Script ==="
echo "Workspace: $WORKSPACE"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "AWS Account ID: $ACCOUNT_ID"


echo "Initializing Terraform..."
cd terraform
terraform init

echo "Available workspaces:"
terraform workspace list

terraform -chdir=terraform workspace select -or-create ${WORKSPACE}

echo "Current workspace: $(terraform workspace show)"

# Set up environment file
ENV_FILE="env/${WORKSPACE}.tfvars"
if [[ -f "$ENV_FILE" ]]; then
    echo "Using environment file: $ENV_FILE"
    VAR_FILE_ARG="-var-file=$ENV_FILE"
else
    echo "Error: Environment file $ENV_FILE not found"
    exit 1
fi

echo "Applying Terraform changes..."
terraform apply -auto-approve $VAR_FILE_ARG

echo "Deployment completed successfully!"
