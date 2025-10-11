#!/bin/bash
# ------------------------------------------------------------
# File: aws-iam-manager.sh
# Author: Your Name
# Purpose: Automate the creation of IAM users, an 'admin' group,
#          attach AdministratorAccess policy, and add users to the group.
# Notes: Idempotent where possible. Supports DRY_RUN mode.
# ------------------------------------------------------------

# ---------------------------
# Configuration
# ---------------------------
# Define IAM User Names Array (five users as required)
IAM_USER_NAMES=(Jackson Mary John grace chike)

# Admin group name and policy
ADMIN_GROUP_NAME="admin"
ADMIN_POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"

# Set DRY_RUN to "true" to only print AWS commands instead of executing them
DRY_RUN=${DRY_RUN:-false}

# ---------------------------
# Helper functions
# ---------------------------
log() { printf "%s\n" "[INFO] $*"; }
warn() { printf "%s\n" "[WARN] $*"; }
err() { printf "%s\n" "[ERROR] $*"; }

run_cmd() {
    # Wrapper to run commands in DRY_RUN mode
    if [ "$DRY_RUN" = "true" ]; then
        echo "[DRY RUN] $*"
        return 0
    fi

    "$@"
}

# Check aws cli availability
check_aws_cli() {
    if ! command -v aws >/dev/null 2>&1; then
        err "AWS CLI not found. Install and configure it before running this script."
        exit 1
    fi
}

# ---------------------------
# Core functions
# ---------------------------
create_iam_users() {
    log "Starting IAM user creation process..."
    log "-------------------------------------"

    for user in "${IAM_USER_NAMES[@]}"; do
        # Check if user exists
        if aws iam get-user --user-name "$user" >/dev/null 2>&1; then
            warn "User '$user' already exists. Skipping creation."
            continue
        fi

        log "Creating IAM user: $user ..."
        if run_cmd aws iam create-user --user-name "$user"; then
            log "Created user: $user"
        else
            warn "Could not create user: $user (check permissions or errors)."
        fi
    done

    log "------------------------------------"
    log "IAM user creation process completed."
    echo
}

create_admin_group() {
    log "Creating admin group and attaching policy..."
    log "--------------------------------------------"

    # Check if group exists
    if aws iam get-group --group-name "$ADMIN_GROUP_NAME" >/dev/null 2>&1; then
        warn "Group '$ADMIN_GROUP_NAME' already exists."
    else
        log "Creating group '$ADMIN_GROUP_NAME'..."
        if run_cmd aws iam create-group --group-name "$ADMIN_GROUP_NAME"; then
            log "Group '$ADMIN_GROUP_NAME' created."
        else
            err "Failed to create group '$ADMIN_GROUP_NAME'."
        fi
    fi

    # Attach AdministratorAccess policy to the group if not already attached
    # There's no direct single 'get-group-policy-attachment' call; attempt to attach and handle the result.
    log "Attaching AdministratorAccess policy to group '$ADMIN_GROUP_NAME'..."
    if run_cmd aws iam attach-group-policy --group-name "$ADMIN_GROUP_NAME" --policy-arn "$ADMIN_POLICY_ARN"; then
        log "AdministratorAccess policy attached (or already attached)."
    else
        warn "Failed to attach AdministratorAccess policy to '$ADMIN_GROUP_NAME'."
    fi

    log "----------------------------------"
    echo
}

add_users_to_admin_group() {
    log "Adding users to admin group..."
    log "------------------------------"

    for user in "${IAM_USER_NAMES[@]}"; do
        # Ensure the user exists before adding
        if ! aws iam get-user --user-name "$user" >/dev/null 2>&1; then
            warn "User '$user' does not exist. Skipping add to group."
            continue
        fi

        log "Adding user '$user' to group '$ADMIN_GROUP_NAME'..."
        if run_cmd aws iam add-user-to-group --user-name "$user" --group-name "$ADMIN_GROUP_NAME"; then
            log "Added $user to $ADMIN_GROUP_NAME."
        else
            warn "Could not add $user to $ADMIN_GROUP_NAME (may already be a member)."
        fi
    done

    log "----------------------------------------"
    log "User group assignment process completed."
    echo
}

# ---------------------------
# Main
# ---------------------------
main() {
    cat <<'BANNER'
==================================
 AWS IAM Management Script
==================================
BANNER
    echo

    check_aws_cli

    # Confirm AWS configuration by attempting a harmless call (sts get-caller-identity)
    if ! aws sts get-caller-identity >/dev/null 2>&1; then
        warn "aws sts get-caller-identity failed. Ensure AWS CLI is configured with valid credentials and IAM permissions."
    fi

    create_iam_users
    create_admin_group
    add_users_to_admin_group

    cat <<'FOOT'
==================================
 AWS IAM Management Completed
==================================
FOOT
}

# Execute main
main

exit 0
