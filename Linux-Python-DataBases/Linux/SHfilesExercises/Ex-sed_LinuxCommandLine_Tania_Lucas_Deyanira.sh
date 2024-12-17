### PROCESSING AND MASSIVE DATA MANAGEMENT
## The Linux command line - Report of Exercises

## Authors:
# Lucas Mateos Pinilla    
# Tania Gonzalo Santana 
# Deyanira Borroto Alburquerque 


## Exercises with `sed`
#### Which is the output of the following commands?

# 1
sed '/^$/d' input.txt
    # /^$/  this part of the command matches lines with no content
    # /d deletes those lines
    
## Output: Removes all empty lines from input.txt, leaving the rest unchanged.



# 2
seq 1 20 | sed -n '3,10p'
    # sed -n suppresses automatic printing of lines
    # '3,10p' prints lines from the 3rd to the 10th
    
## Output:
# 3 4 5 6 7 8 9 10



# 3
seq 1 20 | sed -n '/[26]/{s/1/5/;p}'

    # /[26]/ matches lines containing the digit `2` or `6`
    # {s/1/5/;p} for matching lines:
      # s/1/5/ replaces the first occurrence of 1 with 5
      # and p prints the modified line

## Output:
# 5 6 52 56 20




### Exercise 1: 
#### What is the output of the last command if we remove the braces?
seq 1 20 | sed -n '/[26]/s/1/5/;p'

## Output: A sequence of numbers from 1 to 20 is generated, 
##         then with sed, only in the lines 12 and 16
##         the first occurrence of 1 is replaced with 5
##         yielding 52 and 56 instead.



### Exercise 2:
#### Write a `sed` command to display lines from 100 to 200 (inclusive) of the file `adult.data`.
sed -n '100,200p' adult.data

