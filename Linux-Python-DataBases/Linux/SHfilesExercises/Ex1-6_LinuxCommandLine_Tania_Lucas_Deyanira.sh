### PROCESSING AND MASSIVE DATA MANAGEMENT
## The Linux command line - Report of Exercises

## Authors:
# Lucas Mateos Pinilla    
# Tania Gonzalo Santana 
# Deyanira Borroto Alburquerque 


### Exercise 1: 
#### Using ps, list all the processes on the system
ps -ef
# -e     Select all processes. 
# -f     Do full-format listing.

#### Using ps and grep, list all the processes for the current user
ps -ef | grep $(whoami) 

#### List the 10 newest processes for the current user
ps -ef | grep $(whoami) | tail -10

#### Display the manual pages for the grep command using at most 100 chars per line
man grep | fmt -100 -s

#### Same as before but substituting any digit by an asterisk (*)
man grep | fmt -100 -s | tr '[0-9]' '*'

#### Same as before but sending the result to a file
man grep | fmt -100 -s | tr '[:digit:]' '*' > grep_noDigits.txt



### Exercise 2: 
#### Extract the columns 6 and 4 (in this order) of file adult.data, not necessarily with a single line command
cut adult.data -d "," -f 6 > f6.txt
cut adult.data -d "," -f 4 > f4.txt 
paste f6.txt f4.txt > paste_f6_f4.txt
tr -d '\t' < paste_f6_f4.txt > trd_paste_f6_f4.txt
    # tr -d '\t' to remove space made by paste by defect



### Exercise 3: 
#### Extract a sorted list of the possible values of the field marital status (field 6) in the file adult.data
cut -d "," -sf 6 adult.data | sort | uniq 

# -d (indicate the delimiter is ",")
# -s (do not print lines not containing delimiter = empty fields)
# -f (indicate the field that we want to extract)



### Exercise 4: 
#### Display the previous list in a single line with the different values separated by commas
cut -d "," -s -f 6 adult.data | sort | uniq | paste -sd ","



### Exercise 5: 
#### Repeat the first example of previous slide, but display only the key and the field 2 of the second file (f17.txt)
# *The first example of previous slide:*
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


#### Exercise 5 SOLUTION: Display only the key and the field 2 of the second file:
join -t "," -1 1 -2 1 -o 2.1 2.2 f13.txt f17.txt
  # -o to get the output of the specified fields (FileNumber.Field)



### Exercise 6: Write shell commands to perform the following actions:
#### Create a file a.txt with 20 random numbers between 0 and 100, without repetition; each number must be in a different line
shuf -n20 -i 0-100 | sort > a.txt 

#### Create a second file b.txt also with 20 random numbers between 0 and 100, without repetition; each number must be in a different line
shuf -n20 -i 0-100 | sort > b.txt 

####  Display the numbers that appear in both files
comm -12 a.txt b.txt
# -12 option: to suppress lines unique to file1 and 2
