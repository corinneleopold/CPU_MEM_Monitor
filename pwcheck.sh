#!/bin/bash

#DO NOT REMOVE THE FOLLOWING TWO LINES
git add $0 >> .local.git.out
git commit -a -m "Lab 2 commit" >> .local.git.out

if [ "$#" -lt 1 ]; then
  echo "Error: Number of arguments is less than one"
  exit
fi

#Your code here
PASSWORD=$1	      # Store the password argument in a variable
SCORE=0		      # Initialize the score variable to 0
PWSIZE=$(wc -c < $1)  # Get the length of the password

# Remove newline at end of file and update password size
PWSIZE=$((PWSIZE-1))

# Check if password size < 6 or > 32
if [ $PWSIZE -lt 6 -o $PWSIZE -gt 32 ]; then
  echo "Error: Password length invalid."
  exit
fi

# +1 point for each character in the string
SCORE=$((SCORE+PWSIZE))

# +5 points if pw contains a special character
hasSpecialChar=$(grep "[#$\+%@]" $PASSWORD | wc -l)
if [ $hasSpecialChar != 0 ]; then
  SCORE=$((SCORE+5))
fi

# +5 points if pw contains at least one number (0-9)
if [ $(grep "[0-9]" $PASSWORD | wc -l) != 0 ]; then
  SCORE=$((SCORE+5))
fi

# +5 points if pw contains at least one alpha char (A-Z, a-z)
if [ $(grep "[A-Za-z]" $PASSWORD | wc -l) != 0 ]; then
  SCORE=$((SCORE+5))
fi

# -10 points if repetition of same alphanumeric char after another
if [ $(grep "\([a-z]\)\1" $PASSWORD) ]; then
  SCORE=$((SCORE-10))

elif [ $(grep "\([A-Z]\)\1" $PASSWORD) ]; then
  SCORE=$((SCORE-10))

elif [ $(grep "\([0-9]\)\1" $PASSWORD) ]; then
  SCORE=$((SCORE-10))
fi

# -3 points if pw contains 3 consecutive lowercase chars
if [ $(grep "[a-z][a-z][a-z]\+" $PASSWORD) ]; then
  SCORE=$((SCORE-3))
fi

# -3 points if pw contains 3 consecutive uppercase chars
if [ $(grep "[A-Z][A-Z][A-Z]\+" $PASSWORD) ]; then 
  SCORE=$((SCORE-3))
fi

# -3 points if pw contains 3 consecutive numbers
if [ $(grep "[0-9][0-9][0-9]\+" $PASSWORD) ]; then
  SCORE=$((SCORE-3))
fi

echo "Password Score: $SCORE"
