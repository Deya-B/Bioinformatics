## Table of Contents I <a name="contents1"></a>
1. [The sed command](#sed)
2. [The awk command](#awk)

  
## The sed command <a name="sed"></a>
[sed](https://www.gnu.org/software/sed/) (stream editor) is a non-interactive command-line text editor
```Nushell
sed OPTIONS... [SCRIPT] [INPUTFILE...]
```
- Performs basic text transformations (substitutions, deletions, etc.) on the input stream
- Very useful to make changes in very large files without the need for opening them
- Makes only one pass over the input, processing the text line by line
- Able to filter text in a pipeline

For example:

```Nushell
sed 's/dog/cat/g' input.txt
```

-  Replaces every appearance of dog with cat.
-  `s` command means substitute/replace and
-  `g` indicates to change all the ocurrences in the line


```Nushell
sed 's/dog/cat/' input.txt        # Changes only the first ocurrence of dog with cat
sed '10,20s/dog/cat/g' input.txt  # From line 10 to 20, replace dog by cat
```

By default sed writes to the standard output. This behavior can be changed with the -i option to edit the file “in place”: `sed -i 's/dog/cat/g' input.txt`

### sed scripts
A sed script is a set of commands separated by semicolons (;) or newlines.

A sed command has the following syntax:
```Nushell
[addr]X[options]
```
- **`[addr]`** is an optional address that can be a line number, a range of lines or a regular expression
- **`X`** is a single-letter command to be executed on the lines that match the address pattern
- Some commands have **`[options]`** that modify their default behavior

Examples:
```Nushell
sed '10,20s/dog/cat/g' input.txt
```
- `10,20` is the address: lines 10 to 20
- `s/dog/cat/` is the command: replace dog by cat
- `g` is an option to the s command: replace all appearances in each line

```Nushell
sed 's/dog/cat/' input.txt
```
- No address: perform substitution in all lines
- No options: replace only the first ocurrence in each line

### Basic sed commands
```Nushell
s/regexp/string/[flags]
```
- Substitute regular expression regexp by string, flags are optional:
    - `g`, replaces all matches, not just the first.
    - `N`, where N is a number, replace only the Nth match
    - `p`, prints the new line after replacement

- `q[exit_code]` EXIT sed without processing any more commands or input.
- `d` Delete the current line and start next cycle ignoring any other commands
- `p` Print the current line, usually used together with the -n option
- `n` If automatic output is not disabled, print the current line and replace it with the next input line; useful to skip lines
- `a \ newline` Insert the text given in a newline - 'a' appends after the text
- `i \ newline` Insert the text given in a newline - 'i' appends before the text <br> `sed '1i\Header' input.txt`


### sed addresses
- The address determines the line or lines on which a sed command will be executed
- If the address is missing, the command is run on all lines
- The address can be a line number, a line range or a regular expression
- The symbol `!` at the end of an address means complement: all lines except those matching the address pattern

#### Numeric addresses
- `sed '125s/dog/cat/' input.txt` A **single number** indicates the line where the command should be executed. Meaning: in line 125 replace...
- `sed '$s/dog/cat/' input.txt` The **$** symbol means: replace in the last line...
- `sed '1i\Header' input.txt` Insert the text 'Header' before the first line

#### Range addresses
1. `N,M`
Where N an M are integers, matches all lines between N and M (inclusive). <br>
`sed '30,40s/dog/cat/' input.txt` Replace dog by cat in lines from 30 to 40

2. `N~M`
Where N and M integers, matches lines N, N+M, N+2M, ... <br>
`sed '2~2s/dog/cat/' input.txt` Replace dog by cat in all even lines

#### Regular expression addresses
- `/regexp/` Where regexp is a regular expression. Refers to all lines that match regexp.
- sed accepts the same regular expressions as grep
- Option -E for extended regular expressions

### Examples including everything:
- `sed '/^[A-Z]/s/dog/cat/' input.txt` Replace dog by cat in all lines starting with a capital letter
- `sed '/dog/a\previous line has a dog' input.txt` Append line 'previous line has a dog' after each line containing 'dog'
- `sed '10,20d' input.txt` Delete lines 10 to 20
- `sed -nE '/@[a-z]*(.com)/p' emails.txt` Print all lines containing the regular expression
- `sed '10,20!/s/dog/cat/' input.txt` Replace dog by cat in all lines except 10-20
- `sed '/regexp/!/s/dog/cat/' input.txt` Replace dog by cat in all lines not matching regexp
- `sed -n '10,12{s/.com/.org/ ; p}' emails.txt` In lines 10 to 12 replace .com por .org and print those lines

#### Command grouping
`{ commands }` A group of commands enclosed in braces {} may be triggered by a single address
```Nushell
sed -n '10,20{s/dog/cat/ ; p}'
sed -n '10,12{s/.com/.org/ ; p}' emails.txt
```
- The -n option disables automatic printing
- The two commands s/dog/cat/ and p are executed on matching lines
- s/dog/cat/ replaces dog by cat (only the first occurrence)
- After that, p prints the lines changed

### Exercises:
#### Which is the output of the following commands? 
- `sed '/^$/d' input.txt > non_empty_lines_input.txt` 
    > Deletes all empty lines from input.txt and sends the result to non_empty_lines_input.txt
- `seq 1 20 | sed -n '3,10p'`
    > (seq)Make a sequence from 1-20, (sed)print from line 3 to 10.
- `seq 1 20 | sed -n '/[26]/{s/1/5/;p}'`
    > 1. seq generates a sequence of numbers from 1 to 20 (one per line)
    > 2. sed -n prevents sed from printing lines unless explicitly instructed
    > 3. `/[26]/` is a pattern match, it matches line containing either `2` or `6`, lines matching this pattern are processed further (within the `{}` block)
    > 4. `{s/1/5/;p}` This is the **action block**: <br>
    s/1/5/ substitutes the first ocurrence of 1 with 5 on each matching line;<br>
    and `p` prints the modified line.<br>
    > 6. The printing outcome is:

          2
          6
          52
          56
          20  
         
#### What is the output of the last command if we remove the braces?
If the command is changed to `seq 1 20 | sed -n '/[26]/s/1/5/;p'`<br>
`!` Only the line 26 is changed
#### Write a sed command to display lines from 100 to 200 (inclusive) of file adult.data
```Nushell
# Option 1: cat -n (shows the line number)
cat -n adult.data | sed -n '100,200p'

# Option 2: (use number line command)
nl adult.data | sed -n '100,200p'

# Option 3: (using only sed, `=` prints the line number, `p` prints the actual line)
sed -n '100,200{=;p}' adult.data
```

## The awk command <a name="awk"></a>
[Awk](https://www.gnu.org/software/gawk/manual/gawk.html) is a programming language designed for text processing.
- Awk processes text files line by line
- It is used to work with csv like files 
- It searches for lines that contain certain patterns
- When a line matches a pattern, awk performs some actions on that line
```Nushell
awk OPTIONS... [PROGRAM] [INPUTFILE...]
```
### Running awk
- Short awk programs are usually included in the command line call to awk
    ```Nushell
    awk 'program' input-file
    ```
- Longer programs are better placed in a separate file and run as
    ```Nushell
    awk -f program-file input-file
    ```
    
### Awk programs
- A program in awk is a set of rules of the form:
    ```Nushell
    pattern {action}
    ```
- Where the action is performed on all the lines than match the pattern.

- Rules can be separated by semicolons (;) or line breaks:
    ```Nushell
    pattern1 {action1}; pattern2 {action2}; ...
    ```
- The # character is used for comments
    ```Nushell
    # This is a comment
    ```

> [!NOTE]
> - Either the pattern or the action can be omitted, but not both
> - If the pattern is omitted, the action is performed on all lines
> - If the action is omitted, lines that match the pattern are printed.

#### Simple examples
1. `awk 'BEGIN {print "Hello world"}'` Hello world
2. `awk '/regexp/ { print $0 }' input-file` If the regexp matches it, prints the lines, equivalent to:
3. `awk '/regexp/' input-file`
    - There is a **pattern but no `{action}`**
    - Turns to the default action of awk, which is to print the line
4. `awk '/regexp/ {}' input-file` **An empty action** `{}` means to do nothing
5. `awk 'length($0) > 50' input-file` Print lines longer than 50 characters (**no action**)
6. `awk '{ print $0 }' input-file` Print all lines (**no pattern**)

### The awk cycle
1. Awk reads the input file line by line
2. For each line, awk tries the patterns of each rule
3. For any matching pattern, awk runs the actions in that pattern's rule
    - If several patterns match, then several actions are run
    - If there are no matches, then no actions are run

In the following example, any line that matches both regexp1 and regexp2 is printed twice:
```Nushell
awk '/regexp1/ {print $0}; /regexp2/ {print $0}' input-file
```

### Command line options
|Option|Function|
|----|----|
|`-F fs` |Set the FS variable (field separator) to the string fs|
|`-f source-file`| Read the awk program from source-file|
|`-v var=val`| Set the variable var to the value val before execution begins; <br> use one -v option for each variable|

### Awk patterns
1. `/regexp/` <br>
    A regular expression as in sed.

2. `expression` <br>
    An expression is matched when its value is nonzero (numbers) or non-null (strings) <br>
    The operators **~** and **!~** can be used to compare regular expressions <br>
   
3. `begpat,endpat` <br>
    A pair of patterns separated by a comma specify a range of consecutive lines (records); the range starts with the first line that matches begpat and ends when endpat is matched after that 

4. `BEGIN` <br>
    This pattern is matched at the beginning, before reading any input lines; used for startup actions
   
5. `END` <br>
    This pattern is matched at the end, after all input lines have been processed; used for cleanup actions

### Awk actions
- An action is a set of one or more statements, enclosed in braces `{ }` and separated by semicolons (`;`) or newlines 
- A missing action is equivalent to `{print $0}`

> [!NOTE]
> **Basic statements in awk**: <br>
> - **Expressions:** assignments, arithmetic operations, comparisons<br>
> - **Control:** C-like constructs (if, for, while, do)<br>
> - **Output:** print<br>

### Awk records and fields
|Records term|Meaning|
|----|----|
| `records` |inputs, usually lines, separated by fields (see below)|
|`RS`|Record Separator (character that separates the records, `\n` by default) <br> Can be changed by assigning a new value to **RS**|
|**`NR`**|number of records (represents the actual lines; <br> Ex `NR == 4` is line 4; `NR > 4` is from line 4 till the end)|

|Fields term|Meaning|
|----|----|
|`fields`|divides records into pieces|
|`FS`<br>`OFS`<br>`-F`|Field Separator; Output Field Separator <br> Character that separates the records, whitespace (one or more spaces, TABs or newlines) by default <br> Can be changed by assigning a new value to **FS**/OFS or with **-F** (in the command line)|
|`NF`|number of fields|
|**`$i`**|is used to refer to the actual fields ($1 refers to field/column 1; Ex `{ print $1 }`)|
|**`$0`**| refers to the entire current line (in loops), containing the full text of this line, from the start till the end, including all fields and spaces|
|**`$NF`**|is the last field|

### The print statement
```Nushell
print item1, item2, ...
```
- Prints each of the items in the list separated, by default, with single spaces
- The *output field separator* can be changed by modifying the variable **OFS**


### Examples:
#### ... with fields ($ ,NF):
```Nushell
ls -l | awk '{ print $5, $6, $7, $7 + $5 }'
  # Print fields 5, 6, 7 and the sum of field 7 + 5 in a new field
```

- Print lines that have a - sign in the 14th field:
    ```Nushell
    awk '$14~/-/' adult.data
      # ~ is a comparative operator that checks if we find the regexp /-/ in line 14
    ```
    
- Print the length of the longest line in adult.data
    ```Nushell
    awk 'BEGIN { max = 0}
        { if (length($0) > max) max = length($0) }
    
          # 1) If the length of the line is larger that the max (first set to 0)
          # 2) The new max is the new length
          # This is repeated for every line in the file
    
        END { print max }' adult.data
          # Print the length, that will result in the longest
          # Since the action is every time comparing to the max
    ```
    
- Print the accumulated size of the files of user pepe:
    ```Nushell
    ls -l | awk 'BEGIN { sum = 0 }
           $3 == "pepe" { sum += $5 }
    
              # $3 is the field/column 3 (user)
              # and $5 is column 5 (file size)
              # For each line it checks user is pepe and if true
                  # it adds file size to sum = it sums the ammount in the field
    
           END { print sum }'
              # After processing all lines, prints the total sum
    ```

- Which is the output of this program?
    ```Nushell
    echo a b c d | awk '{ OFS = ":"; $2 = "";
                        $6 = "new"; print $0;
                        print NF }'
    ```
    The output is:
    ```
      a::c:d::new
      6
    ```
    Explanation:
    > **echo** creates a string `a b c d` that is piped to awk
    > 
    > **awk** sets `OFS`, output field separator to `:` <br>
    > `$2 = ""` Sets the second field to an empty string (removing it) <br>
    > `$6 = "new"` Assigns new to the 6th field, even though the input has 4 fields... <br>
    > Thefore an empty 5th field is added <br>
    >
    > `print $0` Prints the entire modified record
    >
    > `print NF` Prints the total number of field at the end (which is 6)
    > 
    > . . .
           
- Which is the output of this program?
    ```Nushell
    echo a b c d e f | awk '{ print "NF =", NF; NF = 3;
                              $1 = $1; print $0 }'
    ```
    The output is:
    ```
      NF = 6
      a b c
    ```
    Explanation:
    > **echo** produces the string `a b c d e f`
    > 
    > **awk** processes the previous as ($1 = a, $2 = b,...$6 = f) <br>
    > The total number of fields `NF` is initially 6 <br>
    > Then, the action prints "NF =", NF: `NF = 6` <br>
    > `NF = 3` Changes NF to 3, removing fields 4-6 <br>
    > `$1 = $1` Tells awk to rebuild $0 so that only contains fields up to the new `NF` value <br>
    > `print $0` Prints the modified line, which now contains only the first 3 fields
    > 
    > . . .
    
- And this?
    ```Nushell
    echo a b c d | awk '{ OFS = "|"; $1 = 1; $2 = "2";
                                     $3 = 3; $4 = 4;
                                     $5 = 5;  $6 = "new"; print $0;
                                     print NF }'
    ```
    1. Sets the field separator to `|`
    2. Replaces every field `a b c d` with the new values `1 2 3 4` and creates `5 new`
    3. Prints the modified line and the number of fields `NF`
    4. The output is:
        ```
          1|2|3|4|5|new
          6
        ```
  
#### ... with records (NR):
- Print the number of lines in file (eq. to wc -l)
```Nushell
awk 'END { print NR }' adult.data
```

- Print lines:
```Nushell
ls -l | awk 'NR == 4'  # print LINE 4
ls -l | awk 'NR <= 4'  # print line 4 and lower (from 1-4) 
```

#### Exercises
1. Write an awk program that prints the age (field 1), education (field
4), gender (field 10), marital status (field 6) and working hours per
week (field 13) for all records in the file adult.data where the country
(field 14) is United-States
- The fields must be displayed in the previous order
- They must be separated by a semicolon (;)

```Nushell
awk 'BEGIN { FS = ","; OFS = ";" } 
     $14 ~ /United-States/ { print $1, $4, $10, $6, $13 }' adult.data
```

2. Modify the previous program so that it prints the following header
before any other output
```
Age;Education;Gender;Marital-status;Hours-per-week

awk 'BEGIN { FS = ","; OFS = ";" } 
     NR == 1 { print "Age;Education;Gender;Marital-Status;Hours-per-week" }
     $14 ~ /United-States/ { print $1, $4, $10, $6, $13 }' adult.data
```
> BEGIN Block:
> - FS = "," specifies that the input is a comma-separated file.<br>
> - OFS = ";" ensures that the output fields are separated by semicolons.<br>
>
> Header:
> - The header is printed only once for the first record using NR == 1.
>
> Filter for United States:
> - $14 ~ /United-States/ checks if the 14th field contains "United-States".


3. Write an awk program that processes the file adult.data and prints
the mean number of hours worked by men and women
```Nushell
awk 'BEGIN { FS = ", "; fsum = 0; fhours = 0; msum = 0; mhours = 0 }
      $10 ~ /Female/ { fsum += 1;  fhours += $13 }
      $10 ~ /Male/ { msum +=1; mhours += $13 }
    END { print "Total women =", fsum; print "Total hours =", fhours;
      print "Mean hours Females =", fhours/fsum;
      print "Total men =", msum; print "Total hours =", mhours;
      print "Mean hours Males =", mhours/msum }' adult.data
```

5. Use awk or sed to process the file splice.data and print all the records
where the sequence contains a string that starts with GAA, ends with
CTA and is longer than 10 characters
```Nushell
grep -E -o 'GAA[ACGT]+[ACGT]+[ACGT]+[ACGT]CTA' splice.data
head -50 splice.data | awk -F ","
                      '/GAA[ACGT]+[ACGT]+[ACGT]+[ACGT]CTA/
                      { print $2 }'  # print field 2

awk -F "," '/GAA[ACGT]+[ACGT]+[ACGT]+[ACGT]CTA/
           { print $0 }' splice.data   # All fields
```
