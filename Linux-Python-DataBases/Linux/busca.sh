#!/bin/bash

# Authors (alphabeticaly, by surname):
# Deyanira Borroto Alburquerque, 
# Guillermo Cerrillo Sánchez,
# Luis García Aguirre,
# Tania Gonzalo Santana,
# Lucas Mateos Pinilla.

#-------------------------------------------------------------
#	MANUAL 	~BUSCA.SH~
#-------------------------------------------------------------

# Parameter 1:	
# The directory from which we want to start the search.
# Give an absolute path. 	Ex: /home/paco
# or a relative path. 		Ex: (from home) ./paco

# Parameter 2:
# Strings that we want to search in our files.
# Give the strings you want to find inside quotation marks separated by spaces. 		Ex: "banana apple"

# Parameter 3:
# Name of the file that will be created to store the results.

#-------------------------------------------------------------

# RUNNING the search: 

# chmod +x busca.sh
# ./busca.sh /home/paco "banana apple" fruits.txt
# cat fruits.txt

# Note: busca.sh must be in your working directory, otherwise specify the absolute pathway.

#-------------------------------------------------------------
#	ARGUMENTS
#-------------------------------------------------------------

DIR=$1	# The directory from which we want to start the search.
LIST=$2	# Strings that we want to search in our files.
OUT_FILE=$3	# Name of the file that will be created to store the results.

#-------------------------------------------------------------
#	CHECKPOINTS
#-------------------------------------------------------------

## Check number of arguments is correct (3):
if [ $# != 3 ]; then
    echo "ERROR: Missing arguments..."
    echo "Number of arguments passed to the script: $# 
    Provide 3 arguments as follows: 
    /Path/to/directory \"list of things to find\" Output_File_name" >&2
  exit
fi

# Check if search directory (1st arg) is correct.
## Check directory exists:
if [ ! -d "$DIR" ]; then
    echo "ERROR: Directory does not exist." >&2
    exit 123
fi

## Check if we can read it:
if [ ! -r "$DIR" ]; then
    echo "ERROR: Directory exists but is not readable." >&2
    exit 123
fi

# Test if output file (3rd arg) already exists. If so, delete it after confirmation:
if [ -f $OUT_FILE ]; then
    echo -e "> File /""$OUT_FILE" "already exists, do you want to overwrite it? (y/n): " 		
    read confirmation
    if [[ "$confirmation" = "y" || "$confirmation" = "Y" ]]; then
	rm "$OUT_FILE"
    else
        echo "Operation cancelled, use another output file..."
	exit; fi
fi


#-------------------------------------------------------------
#	MAIN SCRIPT
#-------------------------------------------------------------

echo "
	You are using the AMAZING script \"$0\"
	
Be patient... 

We are on the process to find >> $2 << 
...inside the folders under $1

You will obtain a FILE called $3 with all the results of the search...


*********************************************************************"

# Find files in the directory
FILES=$( find "$DIR" -type f )

# Search for the strings
for file in $FILES; do
    # Check if each file has read permissions ** SI NO VA BIEN QUITAR **
    if [ ! -r "$file" ]; then
        echo "ERROR: File '$file' is not readable. Skipping..." >&2
        continue
    fi
    
    # Count strings in files
    total_count=0
    for word in $LIST; do
    	count=$( grep -c "$word" "$file")
    	(( total_count += count ))
    done
    
    # Add strings to the output
    if [ $total_count -gt 0 ]; then
    	basename_file=$(basename "$file")
    	dirname_file=$(dirname "$file")
    	echo -e "$basename_file \t $dirname_file \t $total_count" >> "$OUT_FILE"
    fi
done    

echo "*********************************************************************
Search Results:"


# Results and displaying:
if [ -s "$OUT_FILE" ]; then
    sort -t$'\t' -k3,3nr "$OUT_FILE"
    echo -e "\nResults written to ""$PWD"/"$OUT_FILE"
else
    echo "No matches found. Output file not created."
fi

echo "
	      		- SCRIPT ENDED -
		  Thanks to all the creators!
"
