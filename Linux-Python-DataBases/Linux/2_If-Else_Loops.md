# Table of Contents
1. [Branching introduction](#intro)
    1. [Basic IF Statement](#basicif)
        - [`test`](#test)
        - [AND and OR](#andor)
        - [NOT](#not)
    2. [IF ... ELSE / IF.. ELIF... ELSE Statements](#ifelse)
2. [LOOPS](#loops)
    1. [FOR](#for)
        - [Sequences](#seq)
    2. [WHILE](#while)
    3. [UNTIL](#until)
    - [Ejercicio](#ejemplo)
    - [SOLUCIÓN](#solucion)

References: [tutorials](https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php)

# 1. Branching introduction <a name="intro"></a>
In this section of our Bash Scripting Tutorial you will learn the ways you may use if statements in your Bash scripts to help automate tasks.

If statements (and, closely related, case statements) allow us to make decisions in our Bash scripts. They allow us to decide whether or not to run a piece of code based upon conditions that we may set. If statements, combined with loops (which we'll look at in the next section) allow us to make much more complex scripts which may solve larger tasks.

Like what we have looked at in previous sections, their syntax is very specific so stay on top of all the little details.

## 1.1 Basic IF Statement <a name="basicif"></a>
A basic if statement effectively says: <br>
if a particular test is true then perform a given set of actions.
```sh
if [ <some test> ]
then
 ‪  <commands>
fi
```
Example:
```sh
#!/bin/bash 
FILE=$(ls *html | head -1) 
echo "Exit code: $?" # return exit code to 0 (TRUE) or 1 (FALSE) 
if [ -e $FILE ] 
then 
  echo "$FILE exists" 
fi
```
The square brackets ( [ ] ) in the if statement above are actually a reference to the command test: such as typing in the bash shell `$ test -e $FILE`

This means that all of the operators that test allows may be used here as well.

### `test` <a name="test"></a>
Check the test manual (`man test`) to see all of the possible operators, some of the more common ones are:
|Operator			|				Description 					|
|-------------|-----------------------------|
|! EXPRESSION |			The EXPRESSION is false.|
|-z STRING		|			The length of STRING is zero (ie it is empty).|
| STRING1 = STRING2 | STRING1 is equal to STRING2 |
| STRING1 != STRING2 | STRING1 is not equal to STRING2 |
| INTEGER1 -eq INTEGER2 | INTEGER1 is numerically equal to INTEGER2 |
| INTEGER1 -gt INTEGER2 | INTEGER1 is numerically greater than INTEGER2 |
| INTEGER1 -lt INTEGER2 | INTEGER1 is numerically less than INTEGER2 |
| -d FILE | FILE exists and is a directory |
| -e FILE | FILE exists |
| -r FILE | FILE exists and the read permission is granted |
| -s FILE | FILE exists and it's size is greater than zero (ie. it is not empty) |
| -w FILE | FILE exists and the write permission is granted |
| -x FILE | FILE exists and the execute permission is granted |
| <FILE1> -nt <FILE2> | True, if <FILE1> is newer than <FILE2> (mtime) |
| <FILE1> -ot <FILE2> | True, if <FILE1> is older than <FILE2> (mtime) |

*NOTE:*
  - The spaces before an after the <some test> are mandatory!!
  - = is slightly different to **-eq**
  	- [ 001 = 1 ] will return false as = does a string comparison (ie. character for character the same)
    - whereas -eq does a numerical comparison meaning [ 001 -eq 1 ] will return true
  - You'll notice that in the **if** statement above we indented the commands that were run if the statement was true. This is referred to as indenting and is an important part of writing good, clean code (in any language, not just Bash scripts). The aim is to improve readability and make it harder for us to make simple, silly mistakes. There aren't any rules regarding indenting in Bash so you may indent or not indent however you like and your scripts will still run exactly the same. I would highly recommend you do indent your code however (especially as your scripts get larger) otherwise you will find it increasingly difficult to see the structure in your scripts.

### AND and OR <a name="andor"></a>
(preferred way) The way often recommended to logically connect several tests with AND and OR is to use **several single test commands** and to **combine** them with the shell && and || **list control operators**:
```sh
if [ -n "$FILE" ] && [ -e "$FILE" ]; then
   echo "$FILE is not null and a file named $FILE exists"
fi
```
(el lado oscuro) The logical operators AND and OR for the test-command itself are -a and -o, thus:
```sh
if [ -n "$FILE" -a -e "$FILE" ]
then
    echo "$FILE is not null and a file named $FILE exists"
fi
```

### NOT <a name="not"></a>
As for AND and OR, there are 2 ways to negate a test with the shell keyword ! or passing ! as an argument to test. 

Here ! negates the exit status of the command test which is 0 (true), and the else part is executed:
```sh
if ! [ -d '/tmp' ]
then 
   echo "/tmp doesn't exists"
else 
   echo "/tmp exists"
fi
```

Here the test command itself exits with status 1 (false) and the else is also executed:
```sh
if  [ ! -d '/tmp' ]; then echo "/tmp doesn't exists"; else echo "/tmp exists"; fi
```

## 1.2 IF ... ELSE / IF.. ELIF... ELSE Statements <a name="ifelse"></a>
Sometimes we want to perform a certain set of actions if a statemen is true, and another set of actions if it is false. We can accommodate this with the else mechanism:
```sh
if [ <some test> ]
then
   <commands>
else
   <other commands>
fi
```

Loock at the following example: 
```sh
DIR=$( pwd )/prueba
mkdir $DIR 

if [ $? -eq 0 ] 
then
        echo "Creando directorio $DIR"
else
        echo "Error al crear directorio $DIR"
fi
```

Sometimes we may have a series of conditions that may lead to different paths.
```sh
if [ <some test> ]
then
   <commands>
elif [ <some test> ] 
then
   <different commands>
else
   <other commands>
fi
```

# 2. LOOPS <a name="loops"></a>
Loops allow us to take a series of commands and keep re-running them until a particular situation is reached. They are useful for automating repetitive tasks.

## 2.1 FOR <a name="for"></a>
The for loop will: 
1. take each item in a list (one after the other)
2. assign that item as the value of the variable var
3. execute the commands between do and done
4. go back to the top, grab the next item in the list and repeat over.
It has the following syntax:
```sh
for var in <list>
do
 <commands>
done
```

For example:
```sh
for i in $( ls ) 
do
    echo “item: $i”
done
```
As we can see in the first line, we declare i to be the variable that will take the different values contained in $( ls ). 

* Run the next example and interpret the results:
```sh
names='hola don pepito hola don jose'
for i in $names ; do
    echo -e “item: $i\n”
done
```

* the for loop can be pipped as the input to other command.
* One of the more useful applications of for loops is in the processing of a set of files. To do this we may use wild-cards . See for example the script backupfiles.sh that converts a series of .html files over .php files:

```sh
#!/bin/bash

#----------
# Cambia el filetype de un conjunto de ficheros
#-------

# get files
FILES=$(ls *.html)

# get today date
DATE=$(date +%F)

#------- create backup directory
DIR=$(pwd)/backup-files-$DATE
if mkdir $DIR 
then
    echo "Creando directorio $DIR"
else
    echo "Error al crear directorio $DIR"
    exit 113 # exit de la shell retornando un código de error
fi

# ---------Copying files--------- 
for file in $FILES
do
    ff=$DIR/$DATE-$(basename $file .html).php       
    cp $file $ff
    echo -e "Copiando $file to $ff" 
done
```

### Sequences <a name="seq"></a>
We can also process a series of numbers en C-style programming
```sh
for i in {1..50..5}
do
    echo $i
done
```
It's important when specifying a range like this that there are no spaces present between the curly brackets { }. If there are then it will not be seen as a range but as a list of items.

## 2.2 WHILE <a name="while"></a>
The while construct allows for repetitive execution of a list of commands, as long as the command controlling the while loop executes successfully (exit status of zero). The syntax is:
```sh
while [ <some test> ]
do
 <commands>
done
```

For example:
```sh
COUNTER=0
while [  $COUNTER -lt 10 ] 
do
  echo The counter is $COUNTER
  let COUNTER=COUNTER+1    # Esta sentencia es equivalente a (( COUNTER++ )) 
done
```

## 2.3 UNTIL <a name="until"></a>
The until loop is fairly similar to the while loop. The difference is that it will execute the commands within it until the test becomes true. The syntax is:
```sh
until [ <some test> ]
do
 <commands>
done
```
As you can see in the example above, the syntax is almost exactly the same as the while loop (just replace while with until). 

We can also create a script that does exactly the same as the while example above just by changing the test accordingly. <br>
So you may be asking, 'Why bother having the two different kinds of loops?'. We don't necessarily. The while loop would be able to handle every scenario. Sometimes, however, it just makes it a little easier to read if we phrase it with until rather than while.


### Ejercicio: <a name="ejemplo"></a>
Supongamos que tenemos un fichero de entrada (por ejemplo index.txt) que incluye una lista con nombres de ficheros. En la lista solo aparece el filename y el filetype de los ficheros pero no su path. Un ejemplo de fichero de entrada podría ser el siguiente:
```sh
$ cat /home/eserrano/cursoUnix/index.txt
ejercicios.txt
simKolmogorov.dvi
recibo.pdf
kk.pdf
```
Se debe realizar un script que busque los ficheros incluidos en el fichero de entrada y que genere un fichero de salida con el path completo y el tiempo en que fueron modificados cada uno de los ficheros del fichero de entrada.

La información incluida en el fichero de salida se deberá almacenar en dos columnas. En la primera columna se incluira el path de cada uno de los ficheros y en la segunda el tiempo en el que fueron modificados. Las columnas estarán separadas por un tabulador. Por ejemplo un posible fichero de salida correspondiente al fichero de entrada anterior podría ser el fichero salida.txt:
```sh
$ cat salida.txt
/home/eserrano/ejercicios.txt 	 2017-09-15 14:38:57.527956179 +0200
/home/eserrano/sim/simKolmogorov.dvi 	 2013-10-16 11:47:06.836328955 +0200
/home/eserrano/personal/recibo.pdf 	 2013-09-23 10:39:45.887909254 +0200
```
Si uno de los ficheros incluido en el el fichero de entrada no se encontrase en el árbol de ficheros, no deberá aparecer en el fichero de salida. Por ejemplo el fichero “kk.pdf” de la última linea de index.txt no aparece en “salida.txt” porque no se ha encontrado en la búsqueda.

El script debe respetar las siguientes especificaciones:
1. Debe tener tres argumentos de entada:
    - El primer argumento debe indicar un directorio válido a partr del cual se van a buscar los ficheros. Por ejemplo /home/eserrano/
    - El segundo argumento indicará el fichero de entrada (incluyendo su path). Por ejemplo /home/eserrano/cursoUnix/index.txt
    - El tercer argumento el fichero de salida. Por ejemplo ./salida.txt
2.El script debe realizar al menos las siguientes tres comprobaciones sobre sus argumentos de llamada:
    - Comprobar que el número de argumentos en la llamada es tres.
    - Comprobar que el directorio desde el que se inicia la búsqueda de los ficheros es un directorio válido.
    - Comprobar que el fichero de entrada existe y tiene permiso de lectura.

Si alguna de las tres comprobaciones anteriores fallase, debería abortarse la ejecución del script y mandar un mensaje de error a stderror. Además el script debe comprobar si ya existe el fichero de salida. Si ya existiese debería eliminarlo y continuar con la ejecución.

3. Asumir que los ficheros incluidos en el fichero de entrada NO tienen copias (por ejemplo el fichero ejercicios.txt no puede hallarse en varios directorios).

> Ayuda:
>
> Para buscar los ficheros puede utilizar el comando find. Por ejemplo el comando: find /home/eserrano -name ejercicios.txt buscaría el fichero ejercicios.txt a partir del directorio /home/eserrano/
>
> Para obtener la fecha de modificación de un fichero puede utilizar el comando stat. Por ejemplo, el comando: stat -c %y ejercicios.txt imprimiría la fecha de modoficación del fichero ejercicios.txt
>
> Antes de intentar programar ten clara la “secuencia de acciones” de tu programa (pseudocódigo). Te recomiendo que las escribas en un papel. Solamente después puedes ponerte a programar!!
>
> No trates de hacer el programa y después probarlo. Hasta que no hayas programado con éxito una acción no pases a la siguiente.

### SOLUCIÓN: <a name="solucion"></a>
Antes de mirar la solución es importante que trates desesperadamente de hallar tu solución. No desistas!!!

```sh
#!/bin/bash
DIR=$1
FILEIN=$2
FILEOUT=$3

# ---------------------------------------------
# comprobacion de los argumentos
 de entrada
#----------------------------------------------

# Comprueba que total de argumentos de entrda es correcto
if [ ! $# -eq  3 ] 
then
  echo -e "Numero de parametros incorrecto" >&2  
  exit 123
fi

# Comprueba que el directorio desde el que se inicia la busqueda existe
if [ ! -d $DIR ] 
then 
  echo -e "Directorio $DIR incorrecto" 
>&2
  exit 133
fi 

# Comprueba que el fichero de entrada existe y tiene permiso de lectura 
if [ ! -r $FILEIN ]
then
  echo -e "Fichero de lectura $FILE incorrecto" >&2
  exit 143      
fi

# Elimina el fichero de salida si existiese
if [ -f $FILEOUT ]
then
 rm $FILEOUT
fi

#--------------------------------------------------
# Procesa cada una de las lineas del fichero $FILEIN
#-------------------------------------------------

inFILE=$( cat $FILEIN )
for file in $inFILE
do
   buff=$( find $DIR -name $file )
   if [ ! -z $buff ]  # procesa solo los ficheros que existen
   then 
       fecha=$( stat -c %y $buff)
       echo -e "$buff \t $fecha" >> $FILEOUT
   fi
done
```
