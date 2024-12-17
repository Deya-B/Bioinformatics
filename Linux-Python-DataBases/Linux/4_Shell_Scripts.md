## Shell scripts
A shell script is a text file that contains a list of commands to be run by
the shell in order, as if they had been entered on the command line.

### Running the script
#### A simple first script (hello-world):
```sh
#!/bin/bash

# Hello world script
echo "Hello World!"
```
#### Set permissions to execute:
```sh
chmod +x hello-world
```
#### Execute the script:
```sh
./hello-world
```
#### A more complex script
```sh
#!/bin/bash

# Remove spaces and get fields 5-7 from adult.data
cat adult.data | tr -d " " | cut -d "," -f 5-7 > tmp.txt

# Insert line number as field 1:
echo {1..32562} | tr " " "\n" > nums.txt
paste -d "," nums.txt tmp.txt > adult5-7nums.data

# Remove temporary files:
rm tmp.txt nums.txt

# Show head of new file:
head -n 20 adult5-7nums.data
```

#### [Variables](https://github.com/Deya-B/Linux_Python_DB/blob/main/Linux/Linux_Variables.md)
```sh
# Setting a variable:
the_title="This is the title"

# Calling a variable:
echo $the_title
```

Positional parameters:
```sh
./my_script adult.data adult5-7.data 5-7
```
* $0 is my script
* $1 is adult.data
* $2 is adult5-7.data
* $3 is 5-7
  
#### A script that uses variables
```sh
#!/bin/bash

# Variables:
input_file="adult.data"
output_file="adult5-7.data"
fields="5-7"

# Remove spaces and get selected fields:
cat $input_file | tr -d " " | cut -d "," -f $fields > tmp.txt

# Sort and get unique lines:
sort tmp.txt | uniq > $output_file

# Remove temporary file:
rm tmp.txt
```

#### A script that uses positional parameters
```sh
#!/bin/bash

# Remove spaces and get selected fields:
cat $1 | tr -d " " | cut -d "," -f $3 > tmp.txt

# Sort and get unique lines:
sort tmp.txt | uniq > $2

# Remove temporary file:
rm tmp.txt

# Show head of new file:
head -n 20 $2
```

Running the script option 1: Select fields 5-7, sort and get unique lines, saving to adult5-7.data
```sh
./my_script adult.data adult5-7.data 5-7
```
Running the script option 2: Same with fields 1-4, saving to adult1-4.data
```sh
./my_script adult.data adult1-4.data 1-4
```
