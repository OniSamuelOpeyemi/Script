# 📝 Bash Script Project: Functions and Arrays

## 📌 Project Overview
This project demonstrates the use of **functions** and **arrays** in a Bash script.  
Functions help organize reusable blocks of code, while arrays allow handling multiple values efficiently.  

The script performs the following tasks:
1. Defines an **array of items** (e.g., fruits).  
2. Uses **functions** to:  
   - Print a welcome message  
   - Display the array items  
   - Add a new item to the array  
   - Count the number of items in the array  
   - Display a goodbye message  

This project illustrates how functions and arrays can make Bash scripts **modular, reusable, and scalable** for real-world automation tasks.

---

## 🖥️ The Script: `functions_arrays.sh`

```bash
#!/bin/bash
# ------------------------------------------------------------
# File: functions_arrays.sh
# Author: Your Name
# Purpose: Demonstrate the use of functions and arrays in Bash
# ------------------------------------------------------------

# --- Step 1: Define an array of items ---
fruits=("Apple" "Banana" "Mango" "Orange")

# --- Step 2: Define functions ---

# Function to print a welcome message
welcome_message() {
    echo "-----------------------------------"
    echo " Welcome to the Functions & Arrays Demo "
    echo "-----------------------------------"
}

# Function to display all fruits in the array
list_fruits() {
    echo "Here are the fruits in the basket:"
    for fruit in "${fruits[@]}"; do
        echo "- $fruit"
    done
}

# Function to add a new fruit to the array
add_fruit() {
    local new_fruit=$1
    fruits+=("$new_fruit")
    echo "Fruit '$new_fruit' has been added to the basket."
}

# Function to count number of fruits
count_fruits() {
    echo "There are ${#fruits[@]} fruits in the basket."
}

# Function to display a goodbye message
goodbye_message() {
    echo "-----------------------------------"
    echo " Thank you for using the script! "
    echo " Goodbye! "
    echo "-----------------------------------"
}

# --- Step 3: Execute functions in order ---
welcome_message
list_fruits
add_fruit "Pineapple"
count_fruits
list_fruits
goodbye_message
```

---

## ⚙️ How to Run the Script

1. **Save the script** into a file named `functions_arrays.sh`.
   ```bash
   nano functions_arrays.sh
   ```

2. **Make the script executable**:
   ```bash
   chmod +x functions_arrays.sh
   ```

3. **Run the script**:
   ```bash
   ./functions_arrays.sh
   ```

---

## ✅ Expected Output

When you run the script, you should see:

```
-----------------------------------
 Welcome to the Functions & Arrays Demo 
-----------------------------------
Here are the fruits in the basket:
- Apple
- Banana
- Mango
- Orange
Fruit 'Pineapple' has been added to the basket.
There are 5 fruits in the basket.
Here are the fruits in the basket:
- Apple
- Banana
- Mango
- Orange
- Pineapple
-----------------------------------
 Thank you for using the script! 
 Goodbye! 
-----------------------------------
```

---

## 🔧 Real-World Use Case

Functions and arrays are widely used in **system administration** and **DevOps** tasks.  
For example:
- **Arrays** can store lists of servers, users, or file paths.  
- **Functions** can modularize tasks such as checking system health, deploying applications, or cleaning up logs.  

Imagine a scenario where you have multiple servers to check. Instead of repeating the same commands, you can store all server names in an array and create a function to SSH into each server. This makes the script cleaner and reusable.  

---

## 📚 Learning Takeaways
From this project, you have practiced:
- Declaring and manipulating **arrays** in Bash.  
- Creating **functions** to modularize code.  
- Using arrays and functions together to create a **scalable script**.  
- Linking Bash fundamentals to real-world automation workflows.  

---
