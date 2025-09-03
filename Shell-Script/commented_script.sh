#!/bin/bash
# ------------------------------------------------------------
# File: commented_script.sh
# Author: [Your Name]
# Purpose: Demonstrate a simple Bash script with comments
# ------------------------------------------------------------

# --- Step 1: Print a welcome message ---
echo "-----------------------------------"
echo " Welcome to the Bash Script Demo! "
echo "-----------------------------------"

# --- Step 2: Create a directory ---
# The script will create a directory called 'my_demo_dir'
# If the directory already exists, it will not throw an error.
mkdir -p my_demo_dir
echo "Directory 'my_demo_dir' created (or already exists)."

# --- Step 3: List files ---
# We will list the files in the current working directory
# Inline comment: 'ls -l' shows files in long format
echo "Here are the files in the current directory:"
ls -l

# --- Step 4: Display a goodbye message ---
echo "-----------------------------------"
echo " Thank you for running the script! "
echo " Goodbye! "
echo "-----------------------------------"
