# Python for Bioinformatics:
> While using *VS Code or Codium* to **comment** and **uncomment** a block of code you can:
> 1. Select the block of code
> 2. Press `Ctrl+K c` to comment
> 3. Press `Ctrl+K u` to uncomment


## Strings
#### Create a string:
```py
dna = "ACCGTCTAATTTAC"
print(type(dna)) # Check what is it

#[OUT] <class 'str'>
```

### Combine strings/sequences or Concatenate
#### No spaces:
```py
dna1 = "ACCGTCTAATTTACGCGC"
dna2 = "ACCATCAAAA"

combined = dna1+dna2
print(combined)

#[OUT] ACCGTCTAATTTACGCGCACCATCAAAA
```

#### Creating spaces:
```py
name = "Istar"
surname = "Toledo"

combine = name + " " + surname
print(combine)

#[OUT] Istar Toledo
```

#### Using string formatting:
```py
name = "Istar"
surname = "Toledo"

fullname = "%s %s" % (name, surname)
print(fullname)

#[OUT] Istar Toledo
```

#### Using **f-strings**:
These are very usefull to combine text with variables.
```py
print(f"{name} {surname}")
print(f"El valor de la variable es {variable}")
```

### Indexing and Slicing
This is used to access substrings / characters / nucleotides of a string by specifying an **index** or a range of indexes (start and end) and in some cases a step value.

In the world of programming, indexing starts at 0, and Python also follows 0-indexing what makes Python different is that Python also follows negative indexing which starts from -1. -1 denotes the last index, -2, denotes the second last index, -3 denotes the third last index, and so on.

![image](https://github.com/user-attachments/assets/bce3e643-b4e4-468a-a6d9-efff0c2c1cad)

#### Sintax
`string [start:end:step]`

```py
dna = "ACCGTCTAATTTACGCGC"
print(dna[3])         # To print out position 4
#[OUT] G
```

#### Slicing
To access a fragment of the string.
```py
print(dna[0:3])       # To print out a STRING from position 1 to 3 [index 2]
#[OUT] ACC

print(dna[0:10:2])    # To print from position 1 to 10, in steps of 2
#[OUT] ACTTA
```
Because from ACCGTCTAATTTACGCGC

#### Short-hand indexing
This is done by omitting either the first and/or last index.
- `string[:end]` A slice of the sequence from the beginning to the index just before `end pos`
- `string[start:]` A slice of the sequence from `start pos` till the end of the sequence
- `string[:]` Returns the entire string/sequence
- `string[::-1]` Returns a reversed copy of the string/sequence

```py
dna = "ACCGTCTAATTTAC"

```

```py


```

### Some useful string's methods
#### Convert string to **lower** or **upper case**: 
```py
dna = "ACCGTCTAATTTAC"
dna.lower()
dna.upper()
```

#### Find **characters/substring** in string:
```py
"T" in dna
# Returns TRUE
```

The `find` method:
```
dna.find("T")
# Returns 4, because in ACCGTCTAATTTAC, the first appearance of T is in index
# position number 4  >  01234|
```

#### Count number of **characters/substring**:
```py
dna.count("T")
# Returns 5, because there are 5 T's in ACCGTCTAATTTAC
dna.count("C")
dna.count("G")
dna.count("A")

GC_count = dna.count("GC")
```
#### Exercise: Get GC content
```py
dna = "ACCGTCTAATTTACGCGC"

GC_count = dna.count("GC")
GC_perc = (GC_count/len(dna))*100
print(GC_perc)
```

#### Replace **characters/substrings**:
`string.replace("1", "2")` with this method we take string and replace 1 by 2
```py
dna.replace("A", "G")
```

### Some useful string's functions:
#### Get the length:
`len(string)`

```py
len(dna)
length_of_sequence = len(dna) # to make the result into a variable
```


### Easy exercises:
#### 
```py


```

```py

```
 


### Easy to medium level exercises:
#### 1. FOR loop:

```py

```


```py

```
```py

```

### Advanced exercises
#### 1.1 Create a code to compare two DNA sequences and calculate the percentage of resemblance:
```py
seq1 = "ACCGTCT"
seq2 = "ACCATCA"

# Initiate required variables for counting:
matches = 0
missmatches = 0
baseseq2 = 0 # Index of seq2

for base in seq1:
    if seq2[baseseq2] == base:  # If sequence2[base position changing from 0 to the length of seq1]
                                # is the same as base in sequence1...
        matches+=1                # increment matches
        baseseq2+=1                  # increment seq2 index
    else:                       # If not the same...
        missmatches+=1            # increment missmatches
        baseseq2+=1                  # increment seq2 index

# Calculate the percentage of resemblance:
total = (matches*100)/(matches+missmatches)

# Output:
print(f"""Matches: {matches}
Missmatches: {missmatches} 
Calculation: {"{:.2f}".format(total)}%""")  # The expression {:.2f}".format(x) 
                                            # limits float output to two decimal points
```

Results:
```
    Matches: 5
    Missmatches: 2 
    Calculation: 71.43%
```

The previous would work well for sequences of the same length. However, if the seq1 is longer than the seq2 we get an error:
```
    IndexError: string index out of range
```

This happens when the program tries to index seq2 further than it can reach the seq2 length.<br>
Therefore, if we modify the code to make the iteration with the length of the shortest sequence it should be:
```py
seq1 = "ACCGTCTAATTTAC"
seq2 = "ACCATCAAAA"

# Calculate longest sequence (for sequences of different lengths 
#                             to iterate using the shorter one):
# Initialize variables:
shortestseq = seq1
otherseq = seq2

# Compare lengths and reassign variables if needed:
if len(seq1) > len(seq2):
    shortestseq = seq2
    otherseq = seq1
```

> NOTE! It's important to change the variable names in the rest of the code:
>- `seq1 > shortestseq`
>- `seq2 > otherseq`
>```
>for base in shortestseq:
>    if otherseq[baseseq2] == base:
>```

#### 1.2. Turn the previous into two functions and the seq1 and seq2 are given by the user:
Function to calculate the longest sequence:
```py
def longestseq (sequence1, sequence2):
    """Calculate longest sequence (for sequences of different lengths
                                    to iterate using the shorter one)
    Args:
        sequence1: Sequence number 1 
        sequence2: Senquence number 2
    
    Returns:
        shortestseq: the shorter sequence
        otherseq: the longer sequence
    """

    # Initialize variables:
    shortestseq = sequence1
    otherseq = sequence2

    # Compare lengths:
    if len(sequence1) > len(sequence2):
        shortestseq = sequence2
        otherseq = sequence1

    return shortestseq, otherseq
```

Function to calculate the resemblance:
```py
def resemblanceCalc (seq1, seq2):
    """Calculate the percentage of resemblance between the two sequences
    
    Args: sequences 1 and 2.

    Returns: Results of calculation.
    """

    # Use the function created previously to obtain sequences by length
    shortestsequence, othersequence = longestseq(seq1, seq2)   

    # Initiate required variables for counting:
    matches = 0
    missmatches = 0
    baseseq2 = 0 # Index of seq2

    for base in shortestsequence:
        if othersequence[baseseq2] == base:  
            matches+=1                
            baseseq2+=1                 

        else:                       
            missmatches+=1           
            baseseq2+=1              

    # Calculate the percentage of resemblance:
    total = (matches*100)/(matches+missmatches)

    # Output:
    print(
f"""Matches: {matches}
Missmatches: {missmatches} 
Calculation: {"{:.2f}".format(total)}%""")  # The expression {:.2f}".format(x) 
                                            # limits float output to two decimal points
```

Change `seq1` and `seq2` for the user input and use the `resemblanceCalc` function with the sequences as parameters:
```py
seq1 = input("Enter the first sequence to compare: ")
seq2 = input("Enter the second sequence to compare: ")

resemblanceCalc(seq1, seq2)
```

Results:
```
    Enter the first sequence to compare: ACCGTCTAATTTAC
    Enter the second sequence to compare: ACCATCAAAA
    Matches: 7
    Missmatches: 3 
    Calculation: 70.00%
```

#### 2. Create a DNA Class
```py

```
