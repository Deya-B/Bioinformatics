Some references: [Variables](https://ryanstutorials.net/bash-scripting-tutorial/bash-variables.php)

# Variables
Bash variables provide temporary storage for information that will be needed during the lifespan of the program. 
There are two actions we may perform with variables:
- **Setting a value** for a variable: Variables may have their value set in a few different ways. 
The most common is to set it directly or to set it as the result of processing a command or a program.
- **Reading the value** for a variable: To read the variable we place its name (preceded by a $ sign) anywhere in the script we would like.
	- Before Bash interprets (or runs) every line of our script it first checks to see if any variable names are present.
 	- For every variable it has identified, it replaces the variable name with its value.
 	- Then it runs that line of code and begins the process again on the next line.

## Setting our own variables:
As well as variables that are preset in the system, we may set our own variables. 
There are a few ways in which variables may be set (such as part of the execution of a command) but the basic form follows this pattern:
```sh
variable=value
```
This is one of those areas where formatting is important.
A few points on syntax:
- When referring to or reading a variable place a $ sign before the variable name.
- When setting a variable we leave out the $ sign.
- Some people like to always write variable names in uppercase so they stand out. It's your preference however. They can be all uppercase, all lowercase, or a mixture.
- A variable may be placed anywhere in a script (or on the command line for that matter) and, when run, Bash will replace it with the value of the variable.
- Note there is **no space** on either side of the equals ( = ) sign.
- Shell does not care about the type of variables. Variables could store strings, integers, or real numbers, but always are interpreted as Strings.

* To access the variables, just prefix the variable name with $, which will give you the value stored in that variable.
```sh
$ VARIABLE=”Hola mundo”
$ echo “El valor de la VARIABLE es $VARIABLE”
```

* The value stored in a variable can be changed by a subsequent assignment
```sh
$ VARIABLE="$VARIABLE soy patata"
$ echo $VARIABLE
Hola mundo soy patata
```

* If we want that a variable will not be modified we can use the command readonly
```sh
$ readonly VARIABLE
$ VARIABLE="$VARIABLE y te quiero cambiar"
bash: VARIABLE: variable de sólo lectura
```

* To remove the variables we can use the unset command
```sh
$ VAR=”hola juan”
$ unset VAR
$ echo $VAR
```

#### Example.1 Simple Bash Variable Assignment Usage
The following script called sample.sh creates a variable called DIR and assigns the value “./Desktop/”:
```sh
$ cat sample.sh
#!/bin/bash
DIR="./Desktop/"
echo $DIR
ls -l $DIR
```
Create with you favorite editor (for example gedit) the above script and execute it, which will echo the content of the variable DIR and will list the ./Desktop/ in long format.

#### Example 2. Command Substitution
Command substitution allows us to take the output of a command or program (what would normally be printed to the screen) and save it as the value of a variable. To do this we place it within brackets, preceded by a $ sign. For example:
```sh
$ DIR=$( pwd )
$ ls -l $DIR
```
In the following example the value stored in the variable PROC_USER depends on the value of USER.
```sh
$ USER=root
$ PROC_USER=$( ps -ef | grep $USER | wc -l)
$ echo “Total de procesos ejecutandose por el usuario $USER: $PROC_USER”
```

## Command Line Arguments
Command line arguments are commonly used. When we run a program on the command line you would be familiar with supplying arguments (options) to control its behavior. 

For instance we could run the command ls -l /etc. In this case -l and /etc are both command line arguments to the command ls. We can do similar with our bash scripts. To do this we use the variables $1 to represent the first command line argument, $2 to represent the second command line argument and so on. These are automatically set by the system when we run our script so all we need to do is refer to them.

For example the following script (sample2.sh) copy the file stored in the first argument to the second argument and, after the copy has been completed, run the command stat on the destination file just to verify it worked properly.
```sh
$ cat sample2.sh
#!/bin/bash
# A simple copy script

echo “We are going to copy the file $1 in $2 using the script $0” 
cp $1 $2
# lets verify the copy 
stat $2
```

Now we are going to execute the above script with the arguments data.txt and data2.txt
```sh
$ ./sample2.sh data.txt data2.txt
$ We are going to copy the file data.txt in data2.txt 
using the script ./sample2.sh
  File: «data2.txt»
  Size: 135       	Blocks: 16         IO Block: 4096   fichero regular
Device: 807h/2055d	Inode: 20188287    Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/eserrano)   Gid: ( 1000/eserrano)
Access: 2017-09-19 17:48:43.897493128 +0200
Modify: 2017-09-19 17:49:01.854327886 +0200
Change: 2017-09-19 17:49:01.854327886 +0200
```

## Other Special Variables
- $0 - The name of the Bash script.
- $1 - $9 - The first 9 arguments to the Bash script. (As mentioned above.)
- $# - How many arguments were passed to the Bash script.
- $@ - All the arguments supplied to the Bash script.
- $? - The exit status of the most recently run process. When the exit is true $? gets a zero value, otherwise $? will be greater than 0
- $$ - The process ID of the current script.

The following variables are preseted by the system:
- $USER - The user name of the user running the script.
- $HOSTNAME - The host-name of the machine the script is running on.
- $SECONDS - The number of seconds since the script was started.
- $RANDOM - Returns a different random number each time is it referred to.
- $LINENO - Returns the current line number in the Bash script.

## Exporting Variables
Remember how in the previous section we talked about scripts being run in their own process. 
This introduces a phenomenon known as scope which affects variables amongst other things. 

The idea is that variables are limited to the process they were created in. 
Normally this isn't an issue but sometimes, for instance, a script may run another script as one of its commands. 
If we want the variable to be available to the second script then we need to export the variable.

Suppose that we have the following script exportvar1.sh that executes exportvar2.sh
```sh
$ cat exportvar1.sh
#!/bin/bash
# demonstrate variable scope 1.
var1=blah
var2=foo
# Let's verify their current value
echo Script $0 :: Valor de var1: $var1, Valor de var2: $var2
export var1

./script/exportvar2.sh

# Let's see what they are now
echo Script $0:: Valor de var1: $var1, Valor de var2 : $var2
```

Being the script exportvar2.sh
```sh
#!/bin/bash
# demonstrate variable scope 2.
echo Script $0 :: Valor de var1: $var1, Valor de var2: $var2

# Let's change their values
var1=flop
var2=bleh
```

Now lets run exportvar1.sh and see what happens:
```sh
$ ./exportvar1.sh 
Script ./exportvar1.sh :: Valor de var1: blah, Valor de var2: foo
Script ./exportvar2.sh :: Valor de var1: blah, Valor de var2:
Script ./exportvar1.sh :: Valor de var1: blah, Valor de var2 : foo
```

The output above may seem unexpected. What actually happens when we export a variable is that we are telling Bash that every time a new process is created (to run another script or such) then make a copy of the variable and hand it over to the new process. So although the variables will have the same name they exist in separate processes and so are unrelated to each other.

Exporting variables is a one way process. The original process may pass variables over to the new process but anything that process does with the copy of the variables has no impact on the original variables (i.e., pass-by-value).

## Bash Arithmetic
Depending on what type of work you want your scripts to do you may end up using variable arithmetic a lot or not much at all. It's a reasonable certainty however that you will need to use variable arithmetic at some point.

The key point is to remember that not previously declared variables are strings and therefore the usual arithmetic operators (+, - ,...) are not defined for them. So the next program is incorrect in order to increment the value stored in the variable UNO
```sh
$ UNO=1
$ UNO=$UNO+1
$ echo $UNO
1+1
```

Translating a string into a numerical expression is relatively straightforward using the command let or parentheses.

The syntax of let is ```let expression```
where expression is an arithmetic expression to be evaluated. 

As you can see in the next example let , it is a little picky about spaces,
```sh
$ UNO=1
$ let UNO=$UNO+1
$ echo $UNO
2
$ let UNO=$UNO + 1       # --- Spaces around + sign are bad with let
-bash: let: +: syntax error: operand expected (error token is "+")
```

With the BASH shell, whole arithmetic expressions may be placed inside double parenthesis. This form is more forgiving about spaces.
```sh
$ ((e=5))
$ echo $e
5
$ (( e = e + 3 ))
$ echo $e
8
$ (( e=e+4 ))  # -- spaces or no spaces, it doesn't matter
$ echo $e
12
```

