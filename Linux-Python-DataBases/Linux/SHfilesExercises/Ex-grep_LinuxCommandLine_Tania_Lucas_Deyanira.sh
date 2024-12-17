### PROCESSING AND MASSIVE DATA MANAGEMENT
## The Linux command line - Report of Exercises

## Authors:
# Lucas Mateos Pinilla    
# Tania Gonzalo Santana 
# Deyanira Borroto Alburquerque 


## Regular expressions exercises with `grep`

### Exercise 1: 
#### Write a grep regular expression to extract the lines that contain only numbers
grep -E "^[0-9][0-9]*$" <file-name>



### Exercise 2: 
#### Write a `grep` regular expression that matches strings in the file splice.data with no **T** and an odd number of **G**s.
# To check that it works use:
head -20 splice.data | grep -oE "[AC]*(G([AC]*G[AC]*G)*[AC]*)"

# To go through the whole file and obtain all matching lines use:
grep -E "[AC]*(G([AC]*G[AC]*G)*[AC]*)" splice.data



### Exercise 3:
#### Write a `grep` regular expression that matches email addresses in the form x.y@t.z, where:
# - **x** and **y** are non-empty strings that may contain lowercase letters, digits, or the underscore symbol (`_`), but must start with a letter.
# - **t** is a non-empty string that contains only lowercase letters.
# - **z** is either `es` or `com`.
cat emails.txt | grep -E "^[a-zA-Z][a-z_0-9]*\.[a-z_0-9]+@[a-z]+\.(com|es)$"



### Exercise 4: 
#### Write a single line command that, using brace expansion, creates the list of directories mmm-yy, where mmm is a month (jan, feb, ...) and yy is a year (16, 17, 18).
mkdir {jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec}-{16,17,18}

