#!/bin/bash

# Function to check if AWS CLI is installed
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it before proceeding."
        return 1
    else
        echo "AWS CLI is installed."
        return 0
    fi
}

# Call the function
check_aws_cli
