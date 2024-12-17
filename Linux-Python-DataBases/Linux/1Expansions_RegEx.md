# Expansions
## Arithmetic expansion
Expressions of the form `$((oper))` where oper is any operation with integer numbers, are expanded by the shell to their corresponding value. Examples:
```Nushell
echo $((4+3))
echo $((10/3))
```
## Brace expansion
Expressions of the form `{list}` where list is a comma separated list of strings, are expanded by the shell as follows:
```Nushell
echo {A,B,C}             # Print the list A B C
echo ho{rs,m,p,roscop}e  # Print the list horse home hope horoscope
```

Expressions of the form `{x..y}` where x and y are integer numbers or chars, are expanded by the shell in a similar way:
```Nushell
echo {a..z}
a b c d e f g h i j k l m n o p q r s t u v w x y z

echo {A..z}
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [  ] ^ _ ` a b c d e f g h i j k l m n o p q r s t u v w x y z

echo {a..Z}
a ` _ ^ ] [ Z

echo {3..7}
3 4 5 6 7
```

List expansions can be in reverse order:
```Nushell
echo {z..a}
echo {9..1}
```

Brace expansions can be nested
```Nushell
echo {X{1,2},Y{3,4}}
X1 X2 Y3 Y4

echo x{a..c}{1..3}
xa1 xa2 xa3 xb1 xb2 xb3 xc1 xc2 xc3

echo {X,Y}{1..4}
```

Exercise: A single line command that, using brace expansion,
creates the list of directories mmm-yy, where mmm is a month (jan,
feb,...) and yy is a year (16, 17, 18)
```Nushell

```


# Linux Regular expressions
- Special characters which help search data and matching complex patterns.
- Regular expressions are shortened as ‘regexp’ or ‘regex’.
- They are used in many Linux programs like grep, bash, rename, sed, etc.

## Basic Regular expressions

| Symbol | Description | 
| ------ | ----------- | 
| `.` | matches any character.<br> Example: `pepit.`→ Find anything that matches pepit- followed by any character: pepito, pepita, pepitos...|
| `^` | only match THOSE at the BEGINNING of a line.<br> Example: `^pepito`→ Lines that match pepito as the FIRST word | 
| `$` | only match THOSE at the END of a line. <br> Example 1: `pepito$`→ Lines that have pepito at the end of the line.<br> Example 2: `^pepito$`→ Lines that ONLY have the word pepito| 
|`[abc]`| match ANY character WITHIN the brackets.<br> Example 1: `pepit[aei]`→ Find pepita, pepite, pepiti. <br> Example 2: `[0-9]`→ Match one character from 0-9 (it finds all numbers, but counts them as individual matches; for example if there is 1996, it finds it as 1,9,9,6) | 
| `[^abc]` |match any character NOT in the group in the brackets.<br> Example: `[^0-9]`→ Find anything that is NOT a number |
| `*` | after a character or expression means zero or more repetitions.<br> Example 1: `[0-9]*`→ Match any number (from none to any number) of characters from 0-9 (here we do find all characters of 1996 together. Check it out with `grep -o "[0-9]*"`) <br> Example 2: "a*" → Match a or a with any-(but only one)-thing next to it | 

### Examples with files:
- Lines with... any character (.), starting with (^), ending with ($):
  ```Nushell
  head -n 100 adult.data | grep "^25"              # Display all lines starting with 25
  head -n 100 adult.data | grep "Mexico, <=50K$"   # Display all lines ending with “Mexico, <=50K”
  head -n 100 adult.data | grep ".th"              # Display all lines 
  ```
  
- Mixing with numbers within `[]`:
  ```Nushell
  containing “th” preceded by any character
  head -n 100 adult.data | grep "[0-9]th"
  # Lines containing "th" preceded by any numeric character

  head -n 100 adult.data | grep "[1-9][0-9]*th"
  # "th" preceded by any number from 1-9 of minimum 1 digit followed by any number with an unlimited amount of digits
  # All the followings will match the expression: 1th, 15th, 2th, 2333th

  head -n 100 adult.data | grep "^[1-9][0-9]*, Private"
  # Lines whose first field is a number and whose second field is “Private”

  head -n 100 adult.data | grep "[^0-9]*"
  # Lines containing non numerical data
  ```
  
### Deeper analysis into what is happening:
```Nushell
$ cat myfile.txt | grep "[^0-9]*"
```
  ![`cat myfile.txt | grep "[^0-9]*`](./imagesregex/Captura%20desde%202024-12-10%2020-44-35.png)
In this image we can see the result of using the regular expression `[^0-9]*` in a file with lines containing both letters and numbers. Whit this expression we remove lines with ONLY numbers, but those lines including both letters and numbers are shown.

On the other hand...
```Nushell
cat myfile.txt | grep "^[^0-9]*$"
```
![cat myfile.txt | grep "^[^0-9]*$"](./imagesregex/Captura%20desde%202024-12-10%2020-45-32.png)
In this we can se the result of using `^[^0-9]*$` instead. As observed only lines that DO NOT CONTAIN numeric characters are displayed.

The following expression extracts the opposite, **lines that contain only numbers**:
```Nushell
cat myfile.txt | grep "^[0-9]*$"
```

### Escaping Meta-characteres
If we want to search for a character that has a special meaning (such
as . or ∧), we have to precede it with a backslash \
```Nushell
head -n 100 adult.data | grep "^[A-Z].*\.$" # Lines starting with a capital letter and ending with a period/dot
head -n 100 adult.data | grep "^\^"         # Lines that start with the ∧ symbol
```

## Grouping
For the following examples you must download the splice.data file:
```Nushell
wget https://archive.ics.uci.edu/ml/machine-learning-databases/molecular-biology/splice-junction-gene-sequences/splice.data
```
Sometimes we may want to group expressions using parentheses. <br> If we want the `()` symbols to be interpreted as group delimiters, we must escape them like this `\( \)`

To understand why gouping is use we can see that whilst with... 
- `GTA` We obtain all the exact matches GTA separately. <br> This means: GTAGTAAAA, will be identified as the two matches GTA, GTA.
- `GTA*` We obtain matches that contain GT+anything (any number of times) and resets with the start of a new GT. <br> This means GTAGTAAAA = (will yield) GTA, GTAAAA.

With **grouping** we can:
- `\(GTA\)*` Obtain GTA an indeterminate number of times

And with these is something else...
- `[GTA]` We obtain anything that is G, T, or A, singly. <br> This means: CCAGCTGCACAGGAGG = A, G, T, G, A, A, G, G, A, G, G.
- `[GTA]*` We obtain anything that is G, T, or A, single or group together between C's. Said in another way: all nucleotides except C, or any unbroken (by C) combination of these. <br> This means: CCAGCTGCACAGGAGG = AG, TG, A, AGGAGG.

## Extended regular expressions
- The option **-E** allows grep to understand a more extensive set of regular expressions (egrep)
- Extended regular expressions include all the basic meta-characters plus additional ones
- For example, the `()` are group delimiters with the -E option (we don't need to escape them " \\")

`cat splice.data | grep -E "GTA(GTA)*"` = `cat splice.data | grep "GTA\(GTA\)*"` <br> The 1st expression with **-E** option is equal to the 2nd without -E option.

### Alternation
- The | symbol indicates alternative matches

- Lines containing either GACC or TCAG
  ```Nushell
  cat splice.data | grep -E "GACC|TCAG"
  ```

- Lines containing one or more consecutive pairs of equal letters
  ```Nushell
  cat splice.data | grep -E "(AA|GG|TT|CC)(AA|GG|TT|CC)*"
  ```

### Quantifiers
`*` means **zero or more** repetitions.
  ```Nushell
  cat splice.data | grep -E "(GACC)*"
  cat splice.data | grep -E "(AA|GG)(AA|GG|TT|CC)*"
    # Matches with one of the first group in brackets, ie
    #   matches starting with AA or GG and continuing with
    #   zero or any number of the second group in braquets
    # Meaning: groups of 2 or any
  ```

`?` means **zero or one** repetitions.
  ```Nushell
  cat splice.data | grep -E "(GACC)?"
  cat splice.data | grep -E "(AA|GG)(AA|GG|TT|CC)?"
    # Matches with one of the first group in brackets
    #   and zero or one of the second group
    # Meaning: groups of 2 or 4
  ```

`+` means **one or more** repetitions.
  ```Nushell
  cat splice.data | grep -E "(GACC)+"
  cat splice.data | grep -E "(AA|GG)(AA|GG|TT|CC)+"
    # Matches with one of the first group in brackets 
    #   and one or more of the second group
    # Meaning: groups of 4 or many
  ```
  
> **Mix and match:** Find the first group (0 or 1 reps) and the second group (0 or any rep):
> ```Nushell
> cat splice.data | grep -E "(GACC)?(GACC)*
> ```

`{N}`, where N is a number, means **exactly N** repetitions
  ```Nushell
  cat splice.data | grep -E "(GACC){3}"
  ```

`{N,M}`, where N<M, means **between N and M** repetitions
  ```Nushell
  cat splice.data | grep -E "(GACC){3,5}"
  ```
  
> **Mix and match:** Find the first group (from 1 to 3 reps) and the second group (exactly 4 reps):
> ```Nushell
> cat splice.data | grep -E "(G){1-3}(GC){4}*"
> ```

#### More examples:
```Nushell
grep - E "a(aa)*"            # an impair number of "a". Can only return: a, aaa, aaaaa
grep - E -o "a([^a][^a])*"
# groups of 2, where the first it's an "a",  
#   and the second group, from 0 to any number of:
#   anything that is not an "a" + anything that is not an "a"
```

## Command and process substitution
### Command substitution
With command substitution we can use the output of a command as an expansion:
```Nushell
$(command)
```
#### Examples:
```Nushell
echo $(ls)  # Print with echo the output of ls

mkdir $(cut -d "," -f 4 adult.data | sort | uniq)
# Make directories with the names of the unique values in the 4th
column of adult.data

rm -fr $(cut -d "," -f 4 adult.data | sort | uniq)
# To delete the directories recursively
```

### Process substitution
- Process substitution allows a process input or output to be referred to using a filename
- Executes all the commands in list saving the output to a file, which is then used as input to command
- Executes command saving the output to a file, which is then used as input to list
```Nushell
command <(list)
command >(list)
```
#### Examples:
Add a first column with the line number to file adult.data
```Nushell
paste -d "," <(seq 1 32562) adult.data > adult-nums.data
```
Display the difference in the output from two commands
```Nushell
diff <(command1) <(command2)
```
Display first 10 sorted rows (similar to a pipeline)
```Nushell
sort splice.data > >(head -n 10)
```
