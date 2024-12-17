#!/bin/bash

### PROCESSING AND MASSIVE DATA MANAGEMENT
## The Linux command line - Report of Exercises

## Authors:
# Lucas Mateos Pinilla    
# Tania Gonzalo Santana 
# Deyanira Borroto Alburquerque 


### Exercise 7: Write a shell script that accepts 3 arguments: f, a, b. 
#### The argument f is the name of a csv file; the arguments a and b are integer numbers. The script must display the list of values that appear in (both) columns a and b of file f.

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


