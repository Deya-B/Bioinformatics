# PROCESSING AND MASSIVE DATA MANAGEMENT
## The Linux command line - Report of Exercises

### File to load:
```Nushell
mkdir Adult
cd Adult
wget archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
```

---
## Filters I

### Exercise 1: 
#### Using ps, list all the processes on the system
```Nushell
ps -ef

# -e     Select all processes. 
# -f     Do full-format listing.
```

#### Using ps and grep, list all the processes for the current user
```Nushell
ps -ef | grep $(whoami) 
```

#### List the 10 newest processes for the current user
```Nushell
ps -ef | grep $(whoami) | sort -r -k5 | tail -10
```

#### Display the manual pages for the grep command using at most 100 chars per line
```Nushell
man grep | fmt -100 -s
```

#### Same as before but substituting any digit by an asterisk (*)
```Nushell
man grep | fmt -100 -s | tr '[0-9]' '*'
```

#### Same as before but sending the result to a file
```Nushell
man grep | fmt -100 -s | tr '[:digit:]' '*' > grep_noDigits.txt
```

---
## Incorporate Filters II (split, cut, paste)

### Exercise 2: 
#### Extract the columns 6 and 4 (in this order) of file adult.data, not necessarily with a single line command
```Nushell
cut adult.data -d "," -f 6 > f6.txt
cut adult.data -d "," -f 4 > f4.txt 
paste f6.txt f4.txt > paste_f6_f4.txt
tr -d '\t' < paste_f6_f4.txt > trd_paste_f6_f4.txt
    # tr -d '\t' to remove space made by paste by defect
```

---
## Incorporate Filters III (paste, shuf, sort, uniq)

### Exercise 3: 
#### Extract a sorted list of the possible values of the field marital status (field 6) in the file adult.data
```Nushell
cut -d "," -s -f 6 adult.data | sort | uniq 

# -d (indicate the delimiter is ",")
# -s (do not print lines not containing delimiter = empty fields)
# -f (indicate the field that we want to extract)
```

### Exercise 4: 
#### Display the previous list in a single line with the different values separated by commas
```Nushell
cut -d "," -s -f 6 adult.data | sort | uniq | paste -sd ","
```

---
## Incorporate Filters IV (join)

### Exercise 5: 
#### Repeat the first example of previous slide, but display only the key and the field 2 of the second file (f17.txt)
*The first example of previous slide:*
```Nushell
# Add a first column with the line number to file adult.data:
echo {1..32562} | tr " " "\n" | paste -d "," - adult.data > adult-nums.data


# Create files f13.txt and f17.txt from adult-nums.data
# (this is the first example the exercise refers to):
cut adult-nums.data -d "," -f 1,3 | shuf -n 1000 | sort -t "," -k 1,1 > f13.txt
cut adult-nums.data -d "," -f 1,7 | shuf -n 1000 | sort -t "," -k 1,1 > f17.txt

# Join them on the first field:
join -t "," -1 1 -2 1 f13.txt f17.txt

# Same, but showing all lines of file 1 (f13.txt):
join -t "," -1 1 -2 1 -a 1 f13.txt f17.txt 
```
#### Exercise 5 SOLUTION: Display only the key and the field 2 of the second file:
```Nushell
join -t "," -1 1 -2 1 -o 2.1 2.2 f13.txt f17.txt
  # -o to get the output of the specified fields (FileNumber.Field)
```

---
## Incorporate the `comm` command

### Exercise 6: Write shell commands to perform the following actions:
#### Create a file a.txt with 20 random numbers between 0 and 100, without repetition; each number must be in a different line
```Nushell
shuf -n20 -i 0-100 | sort > a.txt 
```

#### Create a second file b.txt also with 20 random numbers between 0 and 100, without repetition; each number must be in a different line
```Nushell
shuf -n20 -i 0-100 | sort > b.txt 
```

####  Display the numbers that appear in both files
```Nushell
comm -12 a.txt b.txt
# -12 option: to suppress lines unique to file1 and 2
```

---
## Shell scripts
### Exercise 7: Write a shell script that accepts 3 arguments: f, a, b. 
#### The argument f is the name of a csv file; the arguments a and b are integer numbers. The script must display the list of values that appear in (both) columns a and b of file f.
```Nushell
#!/bin/bash
# -----------------------------------------------------------------------
# 	Arguments
# -----------------------------------------------------------------------

f=$1	# csv file-name (input file)
a=$2	# number 1
b=$3	# number 2

# -----------------------------------------------------------------------
#	Checkpoints
# -----------------------------------------------------------------------

# Check number of arguments is correct (3):
if [ $# != 3 ]; then
  echo "ERROR: Missing arguments..."
  echo "Number of arguments passed to the script: $#
  Provide 3 arguments as follows:
  filename.csv number1 number2" >&2
  exit
fi

# Check if .csv file exists:
if [ ! -f $f ]; then
  echo "ERROR: \"$f\" does not exist" >&2
  exit 123
fi

# -----------------------------------------------------------------------
#	Script
# -----------------------------------------------------------------------

# Extract column $a and column $b from $f and sort the results:
cut $f -d "," -f $a | sort -g > a.tmp
cut $f -d "," -f $b | sort -g > b.tmp

# Display, if there are, the values that appear in both columns:
comparison="$(comm --nocheck-order -12 a.tmp b.tmp)"
    # --nocheck-order: to remove the prompts of order produced by comm
if [[ $comparison ]]; then
  echo "The values that appear in both indicated columns are:"
  echo "$comparison"
else
  echo "No values in common."
fi

# Clean up temporary files
rm -f a.tmp b.tmp
```

---
## Text Editors

### Exercises: The vi editor
### Exercise 8: 
Follow the tutorial in this [link](https://nsrc.org/workshops/2017/afnog-bootcamp/exercises/exercises-editing.md.htm). Then answer the following questions:

#### How can you open the vi editor placing the cursor at the end of the file?
```Nushell
vi + <file_name>
```

### Exercise 9: 
#### How can you undo the last change in the vi editor?
```Nushell
u
```

### Exercise 10: 
#### What is the meaning of the command: %s/hola/adios/gc in the vi editor?

The command replaces "hola" with "adios" throughout the file and asks for confirmation for each replacement.


### Exercise 11: 
#### In vi, which commands do you use to copy the current line just below?
From the line you want to copy, you must follow these steps:
 1. Press "ESC"
 2. Press "1yy" (to "yank" one line and place in copy buffer)
 3. Press "p" (place the contents of the copy buffer below)

### Exercise: The emacs editor
Start emacs with the command:
```Nushell
emacs
```
Launch the emacs tutorial by typing:
```Nushell
Ctrl+h t
```
Follow the tutorial to learn the basic usage.


---
## Regular expressions exercises with `grep`

### Exercise 1: 
#### Write a grep regular expression to extract the lines that contain only numbers
```Nushell
grep -E "^[0-9][0-9]*$" <file-name>
```


### File to load: 
#### For the following exercises download the splice.data file: 
```Nushell
wget https://archive.ics.uci.edu/ml/machine-learning-databases/molecular-biology/splice-junction-gene-sequences/splice.data
```


---
### Exercise 2: 
#### Write a `grep` regular expression that matches strings in the file splice.data with no **T** and an odd number of **G**s.
```Nushell
# To check that it works use:
head -20 splice.data | grep -oE "[AC]*(G([AC]*G[AC]*G)*[AC]*)"

# To go through the whole file and obtain all matching lines use:
grep -E "[AC]*(G([AC]*G[AC]*G)*[AC]*)" splice.data
```
<!--- grep -E "^[ACG]*$" splice.data | grep -E "G[^G]*G[^G]*G*" --->

### Exercise 3:
#### Write a `grep` regular expression that matches email addresses in the form x.y@t.z, where:
- **x** and **y** are non-empty strings that may contain lowercase letters, digits, or the underscore symbol (`_`), but must start with a letter.
- **t** is a non-empty string that contains only lowercase letters.
- **z** is either `es` or `com`.

```Nushell
cat emails.txt | grep -E "^[a-zA-Z][a-z_0-9]*\.[a-z_0-9]+@[a-z]+\.(com|es)$"
```

---
### Exercise 4: 
#### Write a single line command that, using brace expansion, creates the list of directories mmm-yy, where mmm is a month (jan, feb, ...) and yy is a year (16, 17, 18).

```Nushell
mkdir {jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec}-{16,17,18}
```

---
## Exercises with `sed`
#### Which is the output of the following commands?

```Nushell
# 1
sed '/^$/d' input.txt
    # /^$/  this part of the command matches lines with no content
    # /d deletes those lines

## Output: Removes all empty lines from input.txt, leaving the rest unchanged.
```

```Nushell
# 2
seq 1 20 | sed -n '3,10p'
    # sed -n suppresses automatic printing of lines
    # '3,10p' prints lines from the 3rd to the 10th

## Output:
3 4 5 6 7 8 9 10
```

```Nushell
# 3
seq 1 20 | sed -n '/[26]/{s/1/5/;p}'

    # /[26]/ matches lines containing the digit `2` or `6`
    # {s/1/5/;p} for matching lines:
      # s/1/5/ replaces the first occurrence of 1 with 5
      # and p prints the modified line

## Output:
5 6 52 56 20
```

---
### Exercise 1: 
#### What is the output of the last command if we remove the braces?
```Nushell
seq 1 20 | sed -n '/[26]/s/1/5/;p'

## Output: A sequence of numbers from 1 to 20 is generated, 
##         then with sed, only in the lines 12 and 16
##         the first occurrence of 1 is replaced with 5
##         yielding 52 and 56 instead.
```

---
### Exercise 2:
#### Write a `sed` command to display lines from 100 to 200 (inclusive) of the file `adult.data`.
```Nushell
sed -n '100,200p' adult.data
```

---
## Exercises with `awk`
### Exercise 1: 
#### Write an awk program that prints the age (field 1), education (field 4), gender (field 10), marital status (field 6) and working hours per week (field 13) for all records in the file adult.data where the country (field 14) is United-States:
- The fields must be displayed in the previous order
- They must be separated by a semicolon (;)

```Nushell
awk 'BEGIN { FS = ", "; OFS = ";" } 
    $14 ~ /United-States/ { print $1, $4, $10, $6, $13 }' adult.data
```

### Exercise 2:
#### Modify the previous program so that it prints the following header before any other output:
```
Age;Education;Gender;Marital-status;Hours-per-week
```
```Nushell
awk 'BEGIN { FS = ", "; OFS = ";" } 
     NR == 1 { print "Age;Education;Gender;Marital-Status;Hours-per-week" }
     $14 ~ /United-States/ { print $1, $4, $10, $6, $13 }' adult.data
```
---
## Exercises with `awk` part II
### Exercise 1:
#### Write an `awk` program that processes the file `adult.data` and prints the mean number of hours worked by men and women.

```Nushell
awk -F',' '{if ($10 == " Male") {male_hours += $13; male_count++}
           else if ($10 == " Female") {female_hours += $13; female_count++}}
           END {if (male_count > 0) print "Mean hours worked by men: " male_hours / male_count; 
           if (female_count > 0) print "Mean hours worked by women: " female_hours / female_count}' adult.data
```

## Exercises with `awk` and `sed`
### Exercise 2: 
#### Use `awk` or `sed` to process the file `splice.data` and print all the records where the sequence contains a string that: starts with `GAA`, ends with `CTA` and is longer than 10 characters.

```Nushell
awk -F "," '/GAA[ACGT]{4,}CTA/ { print $0 }' splice.data
```

---
