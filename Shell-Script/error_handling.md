# Error Handling in Shell Scripts

Error handling is an important part of shell scripting. It ensures that
your script behaves predictably even when commands fail. This document
explains key error-handling concepts in Bash using an **AWS S3 bucket
creation example**.

------------------------------------------------------------------------

## 1. Exit Codes

-   Every command in Bash returns an **exit code** (also known as
    **return status**).\
-   Exit code meanings:
    -   `0` → Success (command executed without error).\
    -   Non-zero (e.g., `1`, `2`, `127`) → Failure.

### Example:

``` bash
ls existing_file
echo $?   # 0 (success)

ls missing_file
echo $?   # 2 (error: no such file)
```

------------------------------------------------------------------------

## 2. Checking Exit Codes with `$?`

The special variable `$?` holds the exit code of the **last executed
command**.\
It is often used in `if` statements for error handling.

### Example:

``` bash
aws s3api create-bucket --bucket my-bucket --region us-east-1
if [ $? -eq 0 ]; then
    echo "Bucket created successfully."
else
    echo "Bucket creation failed."
fi
```

------------------------------------------------------------------------

## 3. Redirecting Errors

You can **suppress error messages** by redirecting them to
`/dev/null`: - `command &>/dev/null` → hides both stdout and stderr. -
Useful when you only care about success/failure, not the actual error
output.

### Example:

``` bash
if aws s3api head-bucket --bucket my-bucket &>/dev/null; then
    echo "Bucket exists."
else
    echo "Bucket does not exist."
fi
```

------------------------------------------------------------------------

## 4. Using `if-elif-else` for Error Handling

Conditionals allow scripts to take different paths depending on whether
a command succeeded or failed.

### Example with AWS Buckets:

``` bash
if aws s3api head-bucket --bucket "$bucket_name" &>/dev/null; then
    echo "S3 bucket '$bucket_name' already exists."
else
    aws s3api create-bucket --bucket "$bucket_name" --region us-east-1
    if [ $? -eq 0 ]; then
        echo "S3 bucket '$bucket_name' created successfully."
    else
        echo "Failed to create S3 bucket '$bucket_name'."
    fi
fi
```

------------------------------------------------------------------------

## 5. Full Example: Creating Buckets for Multiple Departments

``` bash
#!/bin/bash

# Function to create S3 buckets for different departments
create_s3_buckets() {
    company="datawise"
    departments=("Marketing" "Sales" "HR" "Operations" "Media")
    
    for department in "${departments[@]}"; do
        bucket_name="${company}-${department}-Data-Bucket"
        
        # Check if the bucket already exists
        if aws s3api head-bucket --bucket "$bucket_name" &>/dev/null; then
            echo "S3 bucket '$bucket_name' already exists."
        else
            # Try to create the bucket
            aws s3api create-bucket --bucket "$bucket_name" --region us-east-1
            if [ $? -eq 0 ]; then
                echo "S3 bucket '$bucket_name' created successfully."
            else
                echo "Failed to create S3 bucket '$bucket_name'."
            fi
        fi
    done
}
```

------------------------------------------------------------------------

## 6. Best Practices for Error Handling

-   **Always check exit codes** of critical commands.\

-   Use `set -e` at the start of scripts to automatically exit on errors
    (but be careful with loops).\

-   Redirect errors to logs instead of ignoring them completely:

    ``` bash
    command 2>>error.log
    ```

-   Use `trap` to handle unexpected errors or cleanup tasks:

    ``` bash
    trap 'echo "Error occurred. Exiting..."; exit 1' ERR
    ```

------------------------------------------------------------------------

## 7. Key Takeaways

-   **Exit codes** determine success (`0`) or failure (`>0`).\
-   **`$?`** gives the last command's exit status.\
-   **Error redirection** (`&>/dev/null`, `2>file`) controls output.\
-   **Conditionals** help scripts recover or handle errors gracefully.\
-   Using structured error handling makes scripts **robust, predictable,
    and professional**.
