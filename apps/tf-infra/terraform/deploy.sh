#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR"

echo "Deploying for environment: $ENVIRONMENT"

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Set up environment file
ENV_FILE="env/${ENVIRONMENT}.tfvars"
if [[ -f "$ENV_FILE" ]]; then
    echo "Using environment file: $ENV_FILE"
    VAR_FILE_ARG="-var-file=$ENV_FILE"
else
    echo "Error: Environment file $ENV_FILE not found"
    exit 1
fi

# Apply configuration
echo "Applying Terraform configuration for environment: $ENVIRONMENT"
terraform apply -auto-approve $VAR_FILE_ARG
