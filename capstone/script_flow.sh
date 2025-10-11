#!/bin/bash
# ==========================================================
# Multiplication Table Generator
# Author: Samuel Oni
# Purpose: Generate a multiplication table (full or partial)
# Features: 
#   - Accepts user input for number
#   - Full table (1 to 10) or partial (custom range)
#   - Input validation
#   - Clear formatted output
#   - Option to repeat without restarting
# ==========================================================

while true; do
    # Step 1: Prompt the user for a number
    read -p "Enter a number to generate its multiplication table: " number

    # Validate that input is a number (integer)
    if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
        echo "❌ Invalid input. Please enter an integer."
        continue
    fi

    # Step 2: Ask for table type (full or partial)
    echo "Do you want a full table (1 to 10) or a partial table?"
    read -p "Enter 'f' for full or 'p' for partial: " choice

    # Step 3: Handle user choice
    if [[ "$choice" == "f" || "$choice" == "F" ]]; then
        start=1
        end=10
    elif [[ "$choice" == "p" || "$choice" == "P" ]]; then
        # Prompt for start and end values
        read -p "Enter the start of the range: " start
        read -p "Enter the end of the range: " end

        # Validate inputs
        if ! [[ "$start" =~ ^[0-9]+$ && "$end" =~ ^[0-9]+$ ]]; then
            echo "⚠️ Invalid range values. Defaulting to full table (1 to 10)."
            start=1
            end=10
        elif (( start < 1 || end < start )); then
            echo "⚠️ Invalid range. Start should be >=1 and End >= Start."
            echo "Defaulting to full table (1 to 10)."
            start=1
            end=10
        fi
    else
        echo "⚠️ Invalid choice. Defaulting to full table (1 to 10)."
        start=1
        end=10
    fi

    # Step 4: Generate the multiplication table using a loop
    echo "======================================="
    echo "Multiplication Table for $number"
    echo "Range: $start to $end"
    echo "======================================="

    for (( i=$start; i<=$end; i++ )); do
        printf "%d x %d = %d\n" "$number" "$i" $(( number * i ))
    done

    echo "======================================="

    # Step 5: Ask if the user wants to try another number
    read -p "Do you want to generate another table? (y/n): " again
    if [[ "$again" != "y" && "$again" != "Y" ]]; then
        echo "Goodbye! 👋"
        break
    fi
done
