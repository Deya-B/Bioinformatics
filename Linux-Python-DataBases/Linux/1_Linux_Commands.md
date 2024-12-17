# Table of Contents I <a name="contents1"></a>
1. [Basic Commands I](#basictitle)
    1. [`ls`](#ls)
    2. [`mkdir` [directory_name]](#mkdir)
    3. [`cd` [directory_name]](#cd)
    4. [`pwd`](#pwd)
    5. [Getting Help](#help)
2. [Basic commands II](#basic2) 
    1. [`cp` [file1 file2]](#cp)
    2. [`mv` [file1 file2]](#mv)
    3. [`rm` [file], `rmdir` [dir]](#rm)
    4. [`cat` [file]](#cat)
    5. [`less` [file]](#less)
    6. [`head` [file]](#head)
    7. [`tail` [file]](#tail)
    8. [`ln`](#ln)

[Table of Contents II](#contents2)<br>
[Table of Contents III](#contents3)

# Basic commands I <a name="basictitle"></a>
### `ls` (list): <a name="ls"></a>
The ls command lists the contents of your current working directory.
  * ```ls -a``` To list all files in your home directory
  * ```ls -l``` Access the file's information,including: location, type, size (adding the -h option, ls -lh, print files size in human readble format), who owns it and can accesss it, the inode and time last modified.
  * ```ls -t``` Sort the files by modification time
  * ```ls -p``` Append / indicator to directories

### `mkdir` [directory_name] (make directory) <a name="mkdir"></a>
  * ```mkdir directory_name``` This command creates [directory_name] in your current working directory

### `cd` [directory_name] (change directory) <a name="cd"></a>
  * ```cd directory_name``` To change to the directory you have just made. Or any subdirectory in your working directory
  * ```cd ..``` (..) means the parent of the current directory, therefore use this command to scale back one directory
  * ```cd path/to/directory``` To change to any directory add the full path

### `pwd` (print working directory) <a name="pwd"></a>
  * ```pwd``` display the path of the current directory
 
- clear (clear screen)
  * ```clear```

## Getting Help <a name="help"></a>
- `man` [command] (manual): Type man command to read the manual page for a particular command ```man ls > tempfile.txt```.

- `whatis` [command]: Gives a one-line description of the command, but omits any information about options etc ```whatis wc```.

- `apropos` [keyword]: When you are not sure of the exact name of a command, will give you the commands with keyword in their manual page header ```apropos copy```.

- [command] `--help`: Some commands also provide some built-in documentation if run with an option like -h or --help.

# Basic commands II <a name="basic2"></a>
### `cp` [file1 file2] (copy): <a name="cp"></a>
Makes a copy of file1 in the current working directory and calls it file2.
  * ```cp ~/tempfile.txt .``` Copy the file tempfile.txt to the current directory, keeping the name the same.
  * ```cp -r ~/linuxstaff ~/linuxstaff_backup``` To recursively copy all files and directories from ~/linuxstaff (downwards) to ~/linuxstaff_backup.
 
### `mv` [file1 file2] (move): <a name="mv"></a>
Moves (or renames) file1 to file2.
  * ```mv tempfile.txt backups/``` First, create an empty backups sub-directory in your linuxstaff directory, then change to your linuxstuff directory (can you remember how?). Then, inside the linuxstuff directory, type the given command in order to move the file tempfile.txt to your backups directory.
 
### `rm` [file], `rmdir` [dir] (remove file, directory) <a name="rm"></a>
  * ```rm tempfile.txt``` To delete (remove) a file, use the rm command
  * ```rmdir backups/``` to remove a directory (make sure it is empty first).
  
  With this command Linux will not let you remove a non-empty directory.

  To recursively remove directories use the `-r`:
  * ```rm -r ./backups/```

> CAUTION: It is possible to remove directories and their contents recursively using this option.

### `cat` [file] (concatenate): <a name="cat"></a>
- The cat (concatenate) command in Linux displays the file contents. 
- It reads one or multiple files and prints their content to the terminal. 
- cat is used to view file contents, combine files, and create new files ([very GOOD examples here](https://phoenixnap.com/kb/linux-cat-command#:~:text=The%20cat%20(concatenate)%20command%20in,files%2C%20and%20create%20new%20files.)) .
- Uses:
  * ```cat tempfile.txt```
  * ```cat unix1.html unix2.html unix3.html``` To display three files called unix1.html, unix2.html and unix3.html
  > When using cat the text will not pause between page breaks, it literally displays the whole file in one go.

### `less` [file]: <a name="less"></a>
The command less writes the contents of a file onto the screen a page at a time. <br>
Less is used for long files.
  * ```less tempfile.txt```
  > NOTE:
  > - Press the [space-bar] if you want to see another page
  > - [Enter] if you want to scroll the file line by line
  > - [q] to quit
  > Using less, you can search though a text file for a keyword (pattern). For example, to search through tempfile.txt for the word 'file'type a forward slash [/] followed by the word to search: ```/file```  less finds and highlights the keyword.
  > Type [n] to search for the next occurrence of the word.
 
### `head` [file]: <a name="head"></a>
```
SYNOPSIS
  head [OPTION]... [FILE]...

DESCRIPTION
  Print the first 10 lines of each FILE to standard output.
  -c, --bytes=[-]NUM
  print the first NUM bytes of each file; with the leading ’-’,
  print all but the last NUM bytes of each file
  -n, --lines=[-]NUM
  print the first NUM lines instead of the first 10; with the
  leading ’-’, print all but the last NUM lines of each file
```
  * ```head tempfile.txt```
  * ```head -15 tempfile.txt``` first 15 lines...
  * ```head -n 100 adult.data``` Display the first 100 lines of file adult.data
  * ```head -n -100 adult.data``` Display all the lines in file adult.data except the last 100

### `tail` [file]: <a name="tail"></a>
```
SYNOPSIS
  tail [OPTION]... [FILE]...
DESCRIPTION
  Print the last 10 lines of each FILE to standard output.
  -c, --bytes=[+]NUM
  output the last NUM bytes; or use -c +NUM to output starting
  with byte NUM of each file
  -n, --lines=[+]NUM
  output the last NUM lines, instead of the last 10; or use -n
  +NUM to output starting with line NUM
```
  * ```tail tempfile.txt```
  * ```tail -30 tempfile.txt``` last 30 lines...
  * ```tail -n 100 adult.data``` Display the last 100 lines of file adult.data
  * ```tail -n +100 adult.data``` Display the content in file adult.data starting in line 100
  * ```head -n 200 adult.data | tail -n +100``` Display lines 100 to 200
  * ```head -n 200 adult.data | tail -n 101```
  * ```tail -n +100 adult.data | head -n 101```
 
### `ln`: <a name="ln"></a>
- Symbolic links or soft link, is a special kind of file that points to another file (target file).
  > Unlike a hard link, a symbolic link does not contain the data of the target file. It simply points to another entry somewhere in the file system.
  > 
  > This difference gives symbolic links certain qualities that hard links do not have, such as the ability to link to directories, or to files on remote computers networked through NFS.
  * ```ln -s sort.txt symbolic.txt``` To create a symbolic link called *symbolic.txt* to your target file *sort.txt*
  > Also, when you delete a target file, symbolic links to that file become unusable, whereas hard links preserve the contents of the file.

# Table of Contents II <a name="contents2"></a>
[Table of Contents I](#contents1)

1. [Linux Commands I](#commands1)
    1. [`grep 'keyword' [file]`](#grep)
    2. [`wc [file]`](#wc)
    3. [`sort` I](#sort1)
    4. [`cat [file1] [file2] > [file0]`](#cat)
2. [Redirection](#redirection)
    1. [Redirecting the Output](#output)
    2. [Appending to a file](#appending)
    3. [Redirecting the Input](#input)
3. [Pipes `|`](#pipes)
4. [Linux Commands II](#commands2)
    1. [`gzip`](#gzip)
    2. [`tar`](#tar)
    3. [`zcat`](#zcat)
    4. [`cut`](#cut)
    5. [`tr`](#tr)
    6. [`date`](#date)
    7. [`file`](#file)
    8. [`stat`](#stat)
    9. [`basename` (and `dirname`)](#basename)
    10. [`diff`](#diff)
    11. [`sort` II](#sort2)
    12. [`find`](#find)
    13. [`xargs`](#xargs)

[Table of Contents III](#contents3)

# Linux Commands I <a name="commands1"></a>
### `grep 'keyword' [file]`: <a name="grep"></a>
grep searches files for specified words or patterns (regular expressions)
```
SYNOPSIS
    grep [OPTIONS] PATTERN [FILE...]

DESCRIPTION
    grep searches the named input FILEs for lines containing a match to
    the given PATTERN.

    -i, --ignore-case
        Ignore case distinctions in both the PATTERN and the input
        files.
    -n, --line-number
        Prefix each line of output with the 1-based line number
        within its input file.
    -c, --count
        Suppress normal output; instead print a count of matching
        lines for each input file.
```

  * ```grep If tempfile.txt``` grep prints each line with the word If. The grep command is case sensitive; it distinguishes between If and if.
  * ```grep -i If tempfile.txt``` To ignore case sensitivity use -i

  * Some other useful options of grep are:
      * -v 🡒 display those lines that do NOT match
      * -n 🡒 precede each matching line with the line number
      * -c 🡒 print only the total count of matched lines

```Nushell
grep -iwvc file tempfile.txt             # The number of lines without the words file or File
head -n 100 adult.data | grep -i "Married"  # Display lines that contain the string Married
head -n 100 adult.data | grep -in "Married" # Same showing line number
head -n 100 adult.data | grep -c "Married"  # Count number of appearances
```

- The grep patterns [(see regular expressions)](https://github.com/Deya-B/Linux_Python_DB/blob/main/Linux/Regular_expressions.md)

The grep command allows to searching in more than one file. If I wanted to search for the string file in my files tempfile.txt and .txt I would do this:
```Nushell
grep -ivc file tempfile.txt sort.txt
```
_Recursive use uf grep:_ <br>
If you have a bunch of text files in a directory hierarchy, e.g, in ~/ database/ and you want to find the file where a specific text is defined, then use the -r option of the grep command to do a recursive search. This will perform a recursive search operation trough files for the string "gmail" (as shown below) in the directory ~/database/ and all its sub-directories:
```Nushell
grep -rc gmail ~/database/
```

### `wc [file]` (word count): <a name="wc"></a>
Count number of lines/words/characters in file.
  * ```wc -w tempfile.txt``` To do a word count on tempfile.txt
  * ```wc -l tempfile.txt``` To find out how many lines the file has
  * ```wc tempfile.txt sort.txt``` To print how many lines, word and characters in files tempfile.txt and sort.txt

### `sort` I <a name="sort1"></a>
Refer to [`sort` II](#sort2) <br>
The command sort alphabetically or numerically sorts a list or lines of a file.
```
SYNOPSIS
    sort [OPTION]... [FILE]...

DESCRIPTION
    Write sorted concatenation of all FILE(s) to standard output.

    -b, --ignore-leading-blanks
        ignore leading blanks
    -d, --dictionary-order
        consider only blanks and alphanumeric characters
    -f, --ignore-case
        fold lower case to upper case characters
    -g, --general-numeric-sort
        compare according to general numerical value
    -r, --reverse
        reverse the result of comparisons
    -k, --key=KEYDEF
        sort via a key; KEYDEF gives location and type
    -t, --field-separator=SEP
        use SEP instead of non-blank to blank transition

    KEYDEF is F[.C][OPTS][,F[.C][OPTS]] for start and stop position,
    where F is a field number and C a character position in the
    field; both are origin 1, and the stop position defaults to the
    line’s end. If neither -t nor -b is in effect, characters in a
    field are counted from the beginning of the preceding whitespace.
    OPTS is one or more single-letter ordering options [bdfgiMhnRrV],
    which override global ordering options for that key. If no key
    is given, use the entire line as the key.
```

  * ```sort```
  Then type in the names of some animals. Press [Return] after each one. <br>
  dog cat bird ape; ^C (control c to stop)
  The output will be: ape bird cat dog

### `cat` [file1] [file2] > [file0]: <a name="cat"></a>
Concatenate file1 and file2 to file0.
  * ```cat list1.txt list2.txt > biglist.txt```<br>
  Example explained further down in "Appending to a file"


## Redirection <a name="redirection"></a>
Most processes initiated by UNIX commands write to the standard output (that is, they write to the terminal screen), and many take their input from the standard input (that is, they read it from the keyboard). <br>
There is also the standard error, where processes write their error messages, by default, to the terminal screen.

### Redirecting the Output <a name="output"></a>
Most command line programs send their output to the standard output. <br>
We can redirect the standard output to a file with the > symbol.

```command > file```

For example, to create a file called list1 containing a list of fruit, type 
```Nushell
cat > list1.txt
```
Then type in the names of some fruits. Press [Return/Enter] after each one.
```Nushell
pear banana apple
# ^C [this means press [Ctrl] and [c] to stop]
```
What happens is the cat command reads the standard input (the keyboard) and the > redirects the output, which normally goes to the screen, into a file called list1.txt <br>
To read the contents of the file, type:
```Nushell
cat list1.txt
```
>Exercise:
>
> Using the above method, create another file called list2.txt containing the following fruit: orange, plum, mango, grapefruit. Read the contents of list2.txt.

### Appending to a file <a name="appending"></a>
We can use >> to redirect the standard output appending to a file.

```command >> file``` 

So to add more items to the file list1, type
```Nushell
cat >> list1.txt
```
Then type in the names of more fruit, for ex. peach grape orange; ^C (Control C to stop).<br>
You should now have two files. One contains six fruits, the other contains four fruits.<br>
We will now use the **cat** command to *join* (concatenate) list1 and list2 into a new file called biglist.
```Nushell
cat list1.txt list2.txt > biglist.txt
```
What this is doing is reading the contents of list1.txt and list2.txt in turn, then outputting the text to the file biglist.txt

### Redirecting the Input <a name="input"></a>
Most command line programs read their input from the standard input.

```command < file``` 

Using < you can redirect the input to come from a file rather than the keyboard. For example, to sort the list of fruit, type <br>
  * ```sort < biglist.txt``` and the sorted list will be output to the screen.
 To redirect both the input and the output use both > and < in a single system call:
  * ```sort < biglist.txt > slist.txt``` To output the sorted list to a file. Use cat to read the contents of the file slist.txt

## Pipelines `|` <a name="pipes"></a>
Pipelines allow to redirect the output from a command to the input of another, without writing to files:<br>
```command1 | command2```: pipe the output of command1 to the input of command2.

Instead of doing this:
```Nushell
ls > list.txt
sort < list.txt
```
We can do
```Nushell
ls | sort
```

Suppose that we want to list in reverse order the strings included in the file biglist.txt that do not contain the character "a" <br>
One method to get a sorted list of names is to type,
```
grep -v a biglist.txt > names.txt
sort -r < names.txt
cat names.txt
```
This is a bit slow and you have to remember to remove the temporary file called names when you have finished. 

What you really want to do is connect the output of the grep command directly to the input of the sort command. This is exactly what pipes do. 

The symbol for a pipe is the vertical bar |
```
grep -vi a biglist.txt | sort -r
```
This command line will give the same result as above, but quicker and cleaner

Other examples:
  * ```ls -lp | grep /```
  * ```ls -lp | grep -v /```

# Linux Commands II <a name="commands2"></a>
### `gzip` <a name="gzip"></a>
This reduces the size of a file, thus freeing valuable disk space using the ZIP compressor. For example
  * ```gzip science.txt``` This will compress the file and place it in a file called science.txt.gz
To expand the file, use the gunzip command.
  * ```gunzip science.txt.gz```

### `tar` <a name="tar"></a>
In Linux, tar command is useful as it can combine several files into a single uncompressed (or compressed) file. Tar command, also called tape archiving. With the help of this command, the individual files in a directory can be unpacked and extracted from the archive file.

Most used tar options:
```
-c  create a archive file
-x  extract a archive file
-v  show the progress of archive file
-f  filename of archive file
-t  viewing content of archive file
-j  compress archive through bzip2
-z  compress archive through gzip
-r  append or update files or directories to existing archive file
```
Examples:
  * ```tar -cvzf tarPrueba.tar.gz ./tarPrueba/``` To create a compresseddd gzip archive file called tarPrueba.tar.gz of the directory ./tarPrueba
  * ```tar -tvzf tarPrueba.tar.gz``` To list contents of a tar archive
  * ```tar -xvzf tarPrueba.tar.gz``` To untar or extract a tar file
  * ```tar -xvzf tarPrueba.tar.gz -C ./tarPruebaNew``` To untar in a different directory: option -C [specified directory]
Some times, you may want to compress an entire directory, but excluding certain files or directories.
You can do so by appending an ```--exclude``` switch for each directory or file you want to exclude.

    * ```tar -czvf archive.tar.gz /home/ubuntu --exclude=*.mp4``` To compress /home/ubuntu excluding all .mp4 files
 
### `zcat` <a name="zcat"></a>
zcat will read gzipped files without needing to uncompress them first.
  * ```zcat science.txt.gz```
  * ```zcat rm.txt.gz | less``` If the text scrolls too fast, pipe the output though less
  
### `cut` <a name="cut"></a>
```
SYNOPSIS
    cut OPTION... [FILE]...
DESCRIPTION
    Print selected parts of lines from each FILE to standard output.

    -d, --delimiter=DELIM
        use DELIM instead of TAB for field delimiter
    -f, --fields=LIST
        select only these fields; also print any line that
        contains no delimiter character, unless the -s option
        is specified
    -s, --only-delimited
        do not print lines not containing delimiters
```
The cut command is used for text processing. 
You can use this command to extract portion of text from a file by selecting columns (fields) or characters.
For example, let's say you have a file (fruit.txt) which contains the following ASCII text, being the field delimiter the | character:
``` Nushell
$ cat fruit.txt
apples|Spain
oranges|Spain
pears|Israel
```
to extract the second column type,
```cut -d'|' -f2 fruit.txt```

When the field ```delimiter = tab``` you can omit the -d option. For example:
``` Nushell
$ cat fruit.txt
apples	Spain		red
oranges	Spain		juice
pears	Israel		galia
kiwis	SouthAfrica	green

$ cut -f 3 fruit.txt
red
juice
galia
green
```

  * ```cut adult.data -d "," -f 4``` Display the 4th column of file adult.data
  * ```cut adult.data -d "," -f 4-6``` Columns 4 to 6

Using a pipe you can connect the standard output of a process with the standard input of the cut command for example:
``` Nushell
ls -l | cut -d' ' -f2,4
```
To extract the fields 2 and 4 of the ls -l search.

### `tr` <a name="tr"></a>
```
SYNOPSIS
    tr [OPTION]... SET1 [SET2]
DESCRIPTION
    Translate, squeeze, and/or delete characters from standard input,
    writing to standard output.
    -c, -C, --complement
        use the complement of SET1
    -d, --delete
        delete characters in SET1, do not translate
    -s, --squeeze-repeats
        replace each sequence of a repeated character that is listed
        in the last specified SET, with a single occurrence of that
        character
```
* The **tr** command with the option `-s` is used to translate, delete or squeezing repeated characters. 
``` Nushell
ls -l | tr -s ' '
```

* A combination of **tr** and **cut**:
``` Nushell
ls -l | tr -s ' ' | cut -d' ' -f 4,5 –-output-delimiter='_'
```

* tr is an UNIX utility for translating, or deleting, or squeezing repeated characters. It will read from stdin and write to stdout. 
``` Nushell
echo “Get + and put -” | tr + -
```

* Although tr cannot accept the names of files as arguments, it can be used to modify copies of their contents by using the input/output redirection operators.
``` Nushell
tr '[]' '()' < file1 > file2
```
> This command will read each character from “file1”, translate if it is a brace, and write the output in the “file2”.

> [!CAUTION]
> Avoid using the same output file from the input, this will erase all the text in that file, including the outputted by tr. Thus, the following should not be used: `tr s S < file1 > file1`

* *When numerous characters need to be replaced*: tr can also replace characters in a specified range by their counterparts in another specified range:
> A range is indicated by inserting a hyphen between the first and last characters and then placing all of this in square brackets.
``` Nushell
cat file2 | tr '[A-Z]' '[a-z]' > file3
```
> This will replace every upper case letter in a file named file2 by its lower case counterpart and write the result to a file called file3

* tr can also be used to remove particular characters using -d option:
``` Nushell
echo “eduardo serrano” | tr -d 'dn'
```

* `-s` option replaces each sequence of repeated characters that is listed in the last specified set, with a single instance. The following command translates all newlines in the file data.txt into spaces yielding a **single line**.
```Nushell
tr -s '\n' ' ' < data.txt
```

* More examples:
  - Use the standarized argument [:digit:] to remove all the digits:
    ```Nushell
    echo “Bank account: 0001 00 12345678” | tr -d [:digit:]
    ```
  - To remove all the characters except digits:
    ```Nushell
    echo “Bank account 0001 00 12345678” | tr -cd [:alpha:]
    ```
  - The option `-c` (complement) causes tr to work on the characters that are NOT in the given set:
    ```Nushell
    echo “Bank account: 0001 00 12345678” | tr -cd [:digit:]
    ```
  - To remove the punctuation characteres you can replace all the punctuation characters by spaces: 
    ```Nushell
    cat file2 | tr '[:punct:]' ' ' > file3
      # replace all the punctuation characters in file2 and redirect output to file3
    ```
* Even more examples:
  ```Nushell
  head -n 100 adult.data | tr ’,’ ’;’             # Replace ’,’ by ’;’
  head -n 100 adult.data | tr ’a-z’ ’A-Z’         # Capitalize all letters
  head -n 100 adult.data | tr ’0-9’ ’$’           # Replace all numeric characters by $
  head -n 100 adult.data | tr -c ’0-9a-zA-Z’ ’-’  # Replace all non alphanumeric characters by -
  head -n 100 adult.data | tr -d ’0-9’            # Delete all numbers
  head -n 100 adult.data | tr -s ’ ’              # Eliminate repeated spaces
  ```

### `date` <a name="date"></a>
Prints or sets the system date and time.
```Nushell
$ date
jue sep 7 21:50:32 CEST 2017

$ date +%y-%m-%d
17-09-07

$ date +%T
21:50:43
```

### `file` <a name="file"></a>
Prints information from the files. <br>
**file** tests each argument in an attempt to classify it. <br>
There are three sets of tests, performed in the following order: file-system tests, magic tests, and language tests. The first test that succeeds causes the file type to be printed.

```Nushell
$ file rm.txt
rm.txt: UTF-8 Unicode English text
```
It is possible to use the wild-card * to access the information of several files together. For example:
```Nushell
$ file *csv
uk-500.csv: ASCII English text, with CR line terminators
uk-500_tab.csv: ASCII English text
```

### `stat` <a name="stat"></a>
Display a file or file system status
```Nushell
$ stat rm.txt
$ stat *csv    # use * to access the status of several files together
```
* To access to the file meta-information individually use the -c command option. For example:
  * ```stat -c %A rm.txt``` - Print file access rights in human readable format - %A
  * ```stat -c %U rm.txt``` - Get user name of the owner - %U
  * ```stat -c %y rm.txt``` - Time of the last modification - %y 
  * ```stat -c %s rm.txt``` - Print the size in bytes - %s

### `basename` (and `dirname`) <a name="basename"></a>
The basename command strips any "path" name components from a filename, leaving the "pure" filename.
```Nushell
$ basename /usr/bin/sort
sort

$ basename include/stdio.h
stdio.h

$ basename /home/mikel/bin/stdio.h .h     # strip a suffix from a filename
stdio
```
The dirname command strips the filename itself, giving you the "directory" part of the pathname:
```Nushell
$ dirname /home/mikel/bin/stdio.h
/home/mikel/bin
```

### `diff` <a name="diff"></a>
This diff command compares the contents of two files and displays the differences.

```diff file1 file2``` To see the differences between file1 and file2
> Lines beginning with a < denotes file1, while lines beginning with a > denotes file2.

### `sort` II <a name="sort2"></a>
Refer to [`sort` I](#sort1) <br>
* ```sort data.txt``` - To sort the lines in this file alphabetically
* ```sort -ru data.txt``` - The option `-u` filters out repeated lines in a file and `-r` prints the output in reverse order

Normally, sort decides how to sort lines based on the entire line: it compares every character from the first character in a line, to the last one.

If, on the other hand, you want sort to compare a limited subset of your data, you can specify which fields to compare using the `-k` option. The column separator is, by default, any blank character (however you can specify your own using the `-t` option).
```Nushell
sort -k 2 data.txt
sort -t "," -k 6,6 adult.data   # Sort by the 6th field
shuf -i 0-29 | sort             # Sort a random permutation
shuf -i 0-29 | sort -g          # Sort random permutation (numeric)
```

> [!WARNING]  
> Beware!!
> Note the output difference of the following two commands
> ```Nushell
>     sort -u data.txt | sort -k 2
>     sort -uk 2 data.txt
> ```


### `find` <a name="find"></a>
This searches through the directories for files and directories with a given name, date, size, or any other attribute you care to specify. 
It is a simple command but with many options - you can read the manual by typing man find. 
* ```find . -name "*.txt" -print``` - To search for all files with extension .txt, starting at the current directory (.) and exploring through all sub-directories
* ```find . -name "[a-z][a-z][0-9][0-9].txt"``` - To find all files that begin with two lower case characters, followed by two numbers followed by .txt
* ```find . -type d``` - `[ -type d ]` To find all directories in your working directory (`-type e` for files)
* ```find . -size +1M -ls``` - To find files over 1Mb in size
* ```find /var/adm -mtime +3``` - To find all files that have not been modified in the last three days
* ```find / -mmin -30``` - To find all directories that have been modified in the last 30 minutes
* ```find . -maxdepth 1 -type f``` - To find all the files in the working directory descending until at most one level (be careful with the order of the options in the command)
There are many other options(for example finding files that are newer or older than other files), consult the manual.

### `xargs` <a name="xargs"></a>
The command xargs is used mainly to combine with other commands.
* ```find . -maxdepth 1 -name "*.html" -mmin -10 | xargs cp -t kk/``` - to copy files to the kk/ directory
* ```find -type f | xargs file``` - Get information from files

* Delete files that have white-spaces in their filenames:
```Nushell
$ touch "The Geek Stuff.txt" #this creates a empty file
$ ls
The Geek Stuff.txt
$ find . -name "*.c" | xargs rm -rf
$ ls
one.h two.h The Geek Stuff.c

# To delete files including those that have spaces in the filenames
use the -print0 option with find command and -0 option with xargs command:
$ find . -name "*.txt" -print0 | xargs -0 rm -i
```
> The option `print0` indicates `find` to print all results to the standard output (separated with the ASCII NUL character ‘\000’)
>  
> The option `-0` tells `xargs` that the input will be separated with the ASCII NUL character ‘\000’

* We can force the output of the xargs into multiple lines using `-n`. In the following examples, we used -n option to adjust the items per line displayed in the xargs output:
```Nushell
echo "a b c d e f"| xargs -n 1
echo "a b c d e f"| xargs -n 3
```

* As we have shown the sort command is used to order file lines. To order sequences use the xargs command pipelined. For example:
```Nushell
echo "f d c b e a"| xargs -n 1 | sort
```

* Note that `-n` will be mandatory when xargs is combined with commands with a fixed number of arguments.<br>
  For example, because basename only admits one argument you must type:
> ```Nushell
> find . -name "*.html" | xargs -n 1 basename
> ```
> or to concanate several files located on different directories and redirecte the output you can type:
> ```Nushell
> find . -name "*.html" | xargs -n 1 cat > all.file
> ```



# Table of Contents  <a name="contents3"></a>
[Table of Contents I](#contents1)<br>
[Table of Contents II](#contents2)

1. [Linux Commands ](#commands3)
    1. [ `wget`](#wget)
    2. [Filters](#filters)
        1. [`fmt`](#fmt)
        2. [`split`](#split)
        3. [`paste`](#paste)
        4. [`shuf`](#shuf)
        5. [`uniq`](#uniq)
        6. [`join`](#join)
        7. [Summary](#summary)
        8. [`comm`](#comm)


# Linux Commands III <a name="commands3"></a>

### `wget`: <a name="wget"></a>
GNU Wget is a free utility for non-interactive download of
files from the Web. It supports HTTP, HTTPS, and FTP
protocols, as well as retrieval through HTTP proxies.
```Nushell
wget archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
``` 

## Filters <a name="filters"></a>
- A filter is a program that reads the standard input, performs some operation on it, and writes the result to the standard output.
- Filters are usually combined using pipelines.
- Some programs that can be used as filters: ``head, tail, tr, fmt, grep, sort``.
```Nushell
ls -la | grep 2016 | sort | head | tr ’[0-9]’ ’*’
``` 

See `head` and `tail` in [Linux_BasicCommands](https://github.com/Deya-B/Linux_Python_DB/blob/main/Linux/Linux_BasicCommands.md)

See `tr`, `grep` and `sort` in [Linux_AdvancedCommands](https://github.com/Deya-B/Linux_Python_DB/blob/main/Linux/Linux_AdvancedCommands.md)


### `fmt`: <a name="fmt"></a>
```
SYNOPSIS
    fmt [-WIDTH] [OPTION]... [FILE]...

DESCRIPTION
    Reformat each paragraph in the FILE(s), writing to standard output.
    The option -WIDTH is an abbreviated form of --width=DIGITS.

    -s, --split-only
        split long lines, but do not refill
    -t, --tagged-paragraph
        indentation of first line different from second
    -u, --uniform-spacing
        one space between words, two after sentences
    -w, --width=WIDTH
        maximum line width (default of 75 columns)
```

```Nushell
# Display the first lines of file adult.data cropping lines to 70 characters
head -n 100 adult.data | fmt -70 -s

#  Cropping lines to 70 characters, indenting each first line and using uniform spacing
head -n 100 adult.data | fmt -70 -tu
```

### `split`: <a name="split"></a>
Split a file into pieces.
```
SYNOPSIS
    split [OPTION]... [FILE [PREFIX]]

DESCRIPTION
    Output pieces of FILE to PREFIXaa, PREFIXab, ...; default size
    is 1000 lines, and default PREFIX is ’x’.

    -b, --bytes=SIZE
        put SIZE bytes per output file
    -l, --lines=NUMBER
        put NUMBER lines/records per output file
    -n, --number=CHUNKS
        generate CHUNKS output files; see explanation below
```

```Nushell
# Split the file adult.data into pieces with 10000 lines each (last piece is probably smaller)
split -l 10000 adult.data adult_part_

# Split the file adult.data into 4 pieces of approximately equal size, without breaking lines
split -n 4 adult.data adult_part_
```

### `paste`: <a name="paste"></a>
Merge lines of files. It's complementary to cut.
```
SYNOPSIS
    paste [OPTION]... [FILE]...

DESCRIPTION
    Write lines consisting of the sequentially corresponding lines
    from each FILE, separated by TABs, to standard output.

    -d, --delimiters=LIST
        reuse characters from LIST instead of TABs
```

```Nushell
# Create files f2.txt and f6.txt from adult.data
cut adult.data -d "," -f 2 > f2.txt 
cut adult.data -d "," -f 6 > f6.txt

# Paste files f2.txt and f6.txt
paste -d "," f2.txt f6.txt

# Extract columns 6 and 4 from adult.data to a new file separated with "|":
adult.data -d "," -f 4 > columna4.txt
cut adult.data -d "," -f 6 > columna6.txt
paste -d "|" columna6.txt columna4.txt > columns6and4.txt`
```

```Nushell
# Add a first column with the line number to file adult.data
echo {1..32562} | tr " " "\n" > nums.txt
paste -d "," nums.txt adult.data > adult-nums.data

# Without a temporary file (Para crear un fichero con las filas numeradas)
echo {1..32562} | tr " " "\n" | paste -d "," /dev/stdin adult.data > adult-nums.data
echo {1..32562} | tr " " "\n" | paste -d "," - adult.data > adult-nums.data
```

### `shuf`: <a name="shuf"></a>
Generate random permutations.
```
SYNOPSIS
    shuf [OPTION]... [FILE]
DESCRIPTION
    Write a random permutation of the input lines to standard output.

    -i, --input-range=LO-HI
        treat each number LO through HI as an input line
    -n, --head-count=COUNT
        output at most COUNT lines
    -r, --repeat
        output lines can be repeated
```

```Nushell
# Create a random permutation of numbers 2 to 9
shuf -i 2-9

# Shuffle the first 10 rows of adult-nums.data
head adult-nums.data | shuf
head adult-nums.data | cut -d, -f 1-4 | shuf

# Get only the first 5 shuffled rows
head adult-nums.data | shuf -n 5

# Generate 15 shuffled rows (with repetition)
head adult-nums.data | shuf -n 15 -r
head adult-nums.data | cut -d, -f 1-4 | shuf -r -n 10

# Sort random permutation (numeric)
shuf -i 0-29 | sort -g
```
Create a script that takes 3 variables as arguments: csv file name, a (number 1) and b (number 2).
The script must produce a new file with columns a and b of csv file.
```Nushell
#!/bin/bash
# ------------------------------------------------------
# 	    Arguments
# ------------------------------------------------------
file=$1	# csv file-name (input file)
a=$2	# number 1
b=$3	# number 2
# ------------------------------------------------------
# 	    Checkpoints
# ------------------------------------------------------
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
# ------------------------------------------------------
#       Script
# ------------------------------------------------------
# Get total number of lines, number them and create a temp file:
lines="$(wc -l $file | cut -d " " -f 1)"
		# wc -l: count number of lines in the given file
		# cut -d "" -f 1: keep from the result of wc -l 
		# (num-lines + filename) only the total number of lines.
shuf -i 1-$lines | sort -g | tr " " "\n" | paste -d "," - $file | tr -d " " > file-nums.tmp
		# Create numbers ranging (-i) from 1-total lines
		# Sort them
		# Change empty spaces for line break
		# Create a new column in the file with the numbers	
		# Remove all empty spaces from the final result
		# Create a new temporary file with results

# Extract column $a and column $b from the temp. file and sort the results:
cut file-nums.tmp -d "," -f 1,$a | sort -g > a.tmp
cut file-nums.tmp -d "," -f 1,$b | sort -g > b.tmp

# Join and Display results:
join -t "," -1 1 -2 1 a.tmp b.tmp > joinedData.csv
   # -t: to separate by ","; [-1 1 -2 1]: Join by field 1 files a.tmp and b.tmp
echo "**A file called joinedData.csv with the extracted columns was just created.**"
echo "These are the 10 first lines of that file:"
head joinedData.csv

# ------------------------------------------------------
```

### `uniq`: <a name="uniq"></a>
Report or omit repeated adjacent lines.
```
SYNOPSIS
    uniq [OPTION]... [INPUT [OUTPUT]]

DESCRIPTION
    Filter adjacent matching lines from INPUT (or standard input),
    writing to OUTPUT (or standard output).

    -c, --count
        prefix lines by the number of occurrences
    -i, --ignore-case
        ignore differences in case when comparing
    -u, --unique
        only print unique lines

    Note: ’uniq’ does not detect repeated lines unless they are
    adjacent.
```
Combined with sort, is possible to gather repeated lines together, then with uniq we remove repeated lines.
```Nushell
# Display the unique values of field 6 in adult.data
cut -d "," -f 6 adult.data | sort | uniq

# Same counting the number of occurrences of each value
cut -d "," -f 6 adult.data | sort | uniq -c
``` 

### `join`: <a name="join"></a>
Join lines of two files on a common field.
```
SYNOPSIS
    join [OPTION]... FILE1 FILE2

DESCRIPTION
    For each pair of input lines with identical join fields, write
    a line to standard output. The default join field is the first,
    delimited by blanks.

    -a FILENUM
        also print unpairable lines from file FILENUM, where
        FILENUM is 1 or 2, corresponding to FILE1 or FILE2
    -j FIELD
        equivalent to ’-1 FIELD -2 FIELD’
    -t CHAR
        use CHAR as input and output field separator
    -v FILENUM
        like -a FILENUM, but suppress joined output lines
    -1 FIELD
        join on this FIELD of file 1
    -2 FIELD
        join on this FIELD of file 2
    -i, --ignore-case
        ignore differences in case when comparing fields
    -o List
		Constructs an output line to comprise the fields specified in the List variable.
		One of the following forms applies to the List variable:
			FileNumber.Field
				Where FileNumber is a file number and Field is a decimal-integer
				field number.
				Separate multiple fields with a , (comma) or space characters
				with quotation marks around the multiple fields.
			0 (zero)
				Represents the join field.
				The -o 0 flag essentially selects the union of the join fields.
    Important: FILE1 and FILE2 must be sorted on the join fields.
```
1. Create files f13.txt and f17.txt from adult-nums.data
```Nushell
cut adult-nums.data -d "," -f 1,3 | shuf -n 1000 | sort -t "," -k 1,1 > f13.txt
cut adult-nums.data -d "," -f 1,7 | shuf -n 1000 | sort -t "," -k 1,1 > f17.txt
```
2. Join them on the first field
```Nushell
join -t "," -1 1 -2 1 f13.txt f17.txt

# Same but showing all lines of file 1
join -t "," -1 1 -2 1 -a 1 f13.txt f17.txt
```
> `-1`    indicates the table of the left<br>
> `1`     is the value from which you want to join

> `-2`    is the table on the right<br>
>`1`     is the value from which you want to join<br>

- JOIN » joins columns/fields using the keys in common, if a key is not present in one of the sides it desapears. 
- Left JOIN »  joins fields keeping all the keys on the left
- Right join » joins fields keeping all the keys on the right
- Full outer join » joins fields keeping ALL the keys

3. Display only the key and the field 2 of the second file:
```Nushell
join -t "," -1 1 -2 1 -o 2.1 2.2 f13.txt f17.txt
```

#### Summary <a name="summary"></a>
| command | function |
|------|---------------------|
| `split`<br> [options] [file] [prefix]<br> Ex: Split the text into 500-line files with: `split -l500 tiny_text --verbose` |  Divide big files into smaller files of 1000-line chunks |
| `cut` <br> [option] [file]<br> Ex: Extract just the second column: `cut -d',' -f2 example.csv` | Extracts fields or specific sections of a file/piped data.<br> It separates based on: fields, delimiters, byte positions or character positions |
| `paste`<br> [options] [file1-name] [file2-name]<br> Ex: Contents of two files separated by a comma `paste -d "," file1.txt file2.txt` | Join by columns/fields (without order)<br> Merging multiple files or lines of text into a single file or output |
| `join`<br> [options] [file1-name] [file2-name]<br> Ex: Join two files based on second field in each file  `join -1 2 -2 1 file1 file2`| Join by columns/fields<br> Merge two different files based on a common field |
| `grep`<br> '[search_pattern]' [file_name]<br> Ex: Search for a String in Files with Specific Extensions `grep 'ransomware' *.txt` | Search files for a specified textual pattern. Select rows with a given criteria... |
| `cat`<br> [options] [file_name]<br> Ex: Redirect Contents of Multiple Files `cat test1.txt test2.txt > test3.txt` | Joins by rows. Concatenates or Reads one or multiple files and prints their content row by row to the terminal.<br> `cat` is used to view file contents, combine files, and create new files.  |


### `comm`: <a name="comm"></a>
Compare sorted files FILE1 and FILE2 line by line.
```
SYNOPSIS
    comm [OPTION]... FILE1 FILE2

DESCRIPTION
    With no options, produce three-column output. Column one contains
    lines unique to FILE1, column two contains lines unique to FILE2,
    and column three contains lines common to both files.

    -1 suppress column 1 (lines unique to FILE1)
    -2 suppress column 2 (lines unique to FILE2)
    -3 suppress column 3 (lines that appear in both files)
```
Create files a.txt and b.txt
```Nushell
cut adult.data -d "," -f 1-5 | shuf -n 1000 | sort > a.txt
cut adult.data -d "," -f 1-5 | shuf -n 1000 | sort > b.txt
```

```Nushell
# Display lines that appear only in file a.txt
comm -23 a.txt b.txt

# Display lines that appear in both files
comm -12 a.txt b.txt
```
**Shell script - Exercise 7**: Write a shell script that accepts 3 arguments: f, a, b.  The argument f is the name of a csv file; the arguments a and b are integer numbers. The script must display the list of values that appear in (both) columns a and b of file f.

```Nushell
#!/bin/bash
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

```
