#!/bin/bash

# Environment variable from the first argument
ENVIRONMENT=$1

# Function to check number of arguments
check_num_of_args() {
    # Checking the number of arguments
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <environment>"
        exit 1
    fi
}

# Function to activate infrastructure environment
activate_infra_environment() {
    case "$ENVIRONMENT" in
        local)
            echo "Running script for Local Environment..."
            ;;
        testing)
            echo "Running script for Testing Environment..."
            ;;
        production)
            echo "Running script for Production Environment..."
            ;;
        *)
            echo "Invalid environment specified. Please use 'local', 'testing', or 'production'."
            exit 2
            ;;
    esac
}

# Call functions
check_num_of_args "$@"
activate_infra_environment
