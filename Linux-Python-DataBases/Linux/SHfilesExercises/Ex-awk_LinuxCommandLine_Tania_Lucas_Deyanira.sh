### PROCESSING AND MASSIVE DATA MANAGEMENT
## The Linux command line - Report of Exercises

## Authors:
# Lucas Mateos Pinilla    
# Tania Gonzalo Santana 
# Deyanira Borroto Alburquerque 


## Exercises with `awk`
### Exercise 1: 
#### Write an awk program that prints the age (field 1), education (field 4), gender (field 10), marital status (field 6) and working hours per week (field 13) for all records in the file adult.data where the country (field 14) is United-States:
# The fields must be displayed in the previous order
# They must be separated by a semicolon (;)
awk 'BEGIN { FS = ", "; OFS = ";" } 
    $14 ~ /United-States/ { print $1, $4, $10, $6, $13 }' adult.data



### Exercise 2:
#### Modify the previous program so that it prints the following header before any other output:
# Age;Education;Gender;Marital-status;Hours-per-week

awk 'BEGIN { FS = ", "; OFS = ";" } 
     NR == 1 { print "Age;Education;Gender;Marital-Status;Hours-per-week" }
     $14 ~ /United-States/ { print $1, $4, $10, $6, $13 }' adult.data



## Exercises with `awk` part II

### Exercise 1:
#### Write an `awk` program that processes the file `adult.data` and prints the mean number of hours worked by men and women.
awk -F',' '{if ($10 == " Male") {male_hours += $13; male_count++}
           else if ($10 == " Female") {female_hours += $13; female_count++}}
           END {if (male_count > 0) print "Mean hours worked by men: " male_hours / male_count; 
           if (female_count > 0) print "Mean hours worked by women: " female_hours / female_count}' adult.data



## Exercises with `awk` and `sed`
### Exercise 2: 
#### Use `awk` or `sed` to process the file `splice.data` and print all the records where the sequence contains a string that: starts with `GAA`, ends with `CTA` and is longer than 10 characters.
awk -F "," '/GAA[ACGT]{4,}CTA/ { print $0 }' splice.data


