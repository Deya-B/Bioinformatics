## Accessing Ensembl database
Entrega: 16 de diciembre de 2024

In this assignemnt you will work with the Ensembl database and its access API.

1. Write a program that processes a text file (the name of the file has to be asked by keyboard to the user) containing identifiers of various database elements, such as:

...

ENST00000288602

ENSG00000157764

...

2. Only in case one of the identifiers corresponds to a human gene (i.e. its species is 'homo_sapiens'), you must write in a separate file (with the name of the identifier and extension 'txt', e.g. ENST00000288602.txt), the complete DNA sequence for that gene.
3. In addition, it must print on screen (only on screen, not in the output file), the positions of all subsequences of length 4 of the base 'T'. For each one, it must print its position from the beginning of the sequence. For example:

```
Subsequences of lenght 4:

POS: 352

POS: 353

POS: 438
```
A sequence of length five must be considered two times. For example, if a subsequence of lenght 5 starts at position 50, it should considered as two subsenqueces of length 4 starting at positions 50 and 51.

The program has to be robust, and take into the account the different possible errors (no network connectivity, malformed input from the user, etc)
