# 📘 Bash Scripting Summary: Functions, Arguments, and Error Handling

## What I Learned

From this exercise, I learned the **proper way to define and structure functions in Bash scripting** using the `function_name() { ... }` syntax instead of wrapping code in invalid characters. I practiced **argument validation** by checking the number of inputs passed to a script (`$#`), ensuring the script only runs when the correct argument (environment) is provided.  

I also learned how to use **conditional logic (`if/elif` and `case`)** to handle different scenarios, such as activating different infrastructure environments (local, testing, or production).  

Another key lesson was **error handling with exit codes**, where different failure points return specific exit values to help with debugging. I explored how to use `command -v` to check if a dependency like the **AWS CLI** is installed, and how to validate whether **environment variables (like `$AWS_PROFILE`)** are set before continuing execution.  

## Key Takeaways
- ✅ Defining functions correctly in Bash.  
- ✅ Validating script arguments using `$#`.  
- ✅ Using `case` for clean conditional branching.  
- ✅ Handling errors with specific exit codes.  
- ✅ Checking for dependencies with `command -v`.  
- ✅ Validating environment variables before running sensitive commands.  

Overall, this exercise strengthened my foundation in combining **functions, arguments, conditionals, and error handling** to make Bash scripts more **robust, reusable, and production-ready**.
