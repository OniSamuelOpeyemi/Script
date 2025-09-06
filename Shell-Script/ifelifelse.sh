#! /bin/bash 
# This is a if, elif and else control flow script
 
#USERNAME = oniesammy
if [ $"{1,,}" = "sam" ]; then 
echo "Welcome to the back dear user!"

elif [ "${1,,}" = help ]; then
echo "Enter your username"

else  
echo "Wrong username, try again!!"
fi 


