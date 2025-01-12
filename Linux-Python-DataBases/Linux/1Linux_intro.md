# Table of Contents
[Linux Introduction](#intro)
1. [UNIX, GNU/Linux?](#unix1)
2. [The GNU/Linux operating system](#unix2)
3. [The kernel](#kernel)
4. [The shell](#shell)
5. [The “Programms”](#programms)
6. [Files and processes](#processes)
7. [The Directory Structure](#dir)
8. [Starting an UNIX terminal](#terminal)
9. [Access rights](#access)
   1. [Access rights on files](#files)
    2. [Access rights on directories](#dirI)
    3. [`chmod`: Changing access rights](#chmod)
10. [Processes and Jobs](#jobs)
    1. [Running background processes](#bg)
    2. [Listing suspended and background processes](#fg)
    3. [Killing a process](#kill)
11. [Other useful UNIX commands](#other)
12. [`history`](#history)
13. [`shh`](#shh)
14. [`nohub`](#nohub)


# Linux Introduction <a name="intro"></a>
## UNIX, GNU/Linux? <a name="unix1"></a>
UNIX is an operating system which was conceived and implemented by Ken Thompson and Dennis Ritchie (both of AT&T Bell Laboratories) in 1969 and first released in 1970. 
Later they rewrote it in a new programming language, C, to make it portable. The availability and portability of UNIX caused it to be widely adopted, 
copied and modified by academic institutions and businesses.

## The GNU/Linux operating system <a name="unix2"></a>
The GNU/Linux operating system is made up of three parts; the kernel, the shell and the programs.

## The kernel <a name="kernel"></a>
The kernel of UNIX is the core of the operating system: it allocates time and memory to programs and handles the filestore and communications in response to system calls.

As an illustration of the way that the shell and the kernel work together, suppose a user types rm myfile.txt (which has the effect of removing the file myfile.txt). 
The shell searches the filestore for the file containing the program rm, and then requests the kernel, through system calls, to execute the program rm on myfile.txt. 
When the process rm myfile has finished running, the shell then returns the UNIX prompt % to the user, indicating that it is waiting for further commands.

## The shell <a name="shell"></a>
The shell acts as an interface between the user and the kernel. When a user logs in, the login program checks the username and password, and then starts another program called the shell. 
The shell is a command line interpreter (CLI). It interprets the commands the user types in and arranges for them to be carried out. 
The commands are themselves programs: when they terminate, the shell gives the user another prompt ($ on our systems).

The user can customise his/her own shell, and deferent users can use different shells on the same machine. 
The bash shell is the most wide spread and arguably one of the simplest shell to begin with, but there are also plenty of other shells like the Bourne, Korn or Cshell. 
You can detect your shell using the command:
```
$echo $SHELL
```

The bash shell has certain features to help the user inputting commands.

Filename Completion - By typing part of the name of a command, filename or directory and pressing the [Tab] key, the tcsh shell will complete the rest of the name automatically. 
If the shell finds more than one name beginning with those letters you have typed, it will beep, prompting you to type a few more letters before pressing the tab key again.

History - The shell keeps a list of the commands you have typed in. If you need to repeat a command, use the cursor keys to scroll up and down the list or type history 
for a list of previous commands.

## The “Programms” <a name="programms"></a>
UNIX systems also have a graphical user interface (GUI) similar to Microsoft Windows which provides an easy to accecess a wide variety of applications for communication, 
work, education and entertainment (for example KDE desktop or GNOMAdektop). However, knowledge of UNIX is required for operations which aren't covered by a graphical program, 
or for when there is no windows interface available, for example, in a telnet session.

## Files and processes <a name="processes"></a>
Everything in UNIX is either a file or a process.

- A process is an executing program identified by a unique PID (process identifier).

- A file is a collection of data. They are created by users using text editors, running compilers etc.

**Examples of files:** 
- a document (report, essay etc.)
- the text of a program written in some high-level programming language
- instructions comprehensible directly to the machine and incomprehensible to a casual user, for example, a collection of binary digits (an executable or binary file);
- a directory, containing information about its contents, which may be a mixture of other directories (subdirectories) and ordinary files.

## The Directory Structure <a name="dir"></a>
All the files are grouped together in the directory structure. The file-system is arranged in a hierarchical structure, like an inverted tree. 
The top of the hierarchy is traditionally called root (written as a slash / ).

## Starting an UNIX terminal <a name="terminal"></a>
To open an UNIX terminal window in the KDE desktop, click on the "Terminal" icon from Applications/Accessories/Terminal menus.

An UNIX Terminal window will then appear with a $ prompt, waiting for you to start entering commands.

## Access rights <a name="access"></a>
```ruby
$ -rw-r--r-- 1 cursof alumnos 3864 sep 5 10:22 rm.txt
$ drwxr-xr-x 2 cursof alumnos 4096 sep 5 10:24 backups
```
Each file (and directory) has associated access rights. In the left-hand column is a 10 symbol string consisting of the symbols d, r, w, x, -, and, occasionally, l or L. If d is present, it will be at the left hand end of the string, and indicates a directory: otherwise - will be the starting symbol of the string. In the above example rm.txt is a file and backups is a directory.

The 9 remaining symbols indicate the permissions, or access rights, and are taken as three groups of 3. The left group of 3 gives the file permissions for the user that owns the file (or directory) (cursof in the above examples); the middle group gives the permissions for the group of people to whom the file (or directory) belongs (alumnos in the above example); the rightmost group gives the permissions for all others.

### Access rights on files <a name="files"></a>
- r (or -), indicates read permission (or otherwise), that is, the presence or absence of permission to read and copy the file
- w (or -), indicates write permission (or otherwise), that is, the permission (or otherwise) to change a file
- x (or -), indicates execution permission (or otherwise), that is, the permission to execute a file, where appropriate

```-rwxrwxrwx``` A file that everyone can read, write and execute (and delete).

```-rw-------``` A file that only the owner can read and write - no-one else can read or write and no-one has execution rights (e.g. your mailbox file).

### Access rights on directories <a name="dirI"></a>
Because directories are not used in the same way as regular files, the permissions work slightly (but only slightly) differently.  An attempt to list the files in a directory requires read permission for the directory, but not on the files within.  An attempt to add a file to a directory, delete a file from a directory, or to rename a file, all require write permission for the directory, but (perhaps surprisingly) not for the files within.  Execute permission doesn't apply to directories (a directory can't also be a program).  But that permission bit is reused for directories for other purposes.
- `r` allows users to list files in the directory;
- `w` means that users may create/delete/ from the directory or move files into it;
- `x` means the right to access files in the directory. This implies that you may read files in the directory provided you have read permission on the individual files.

### `chmod`: Changing access rights  <a name="chmod"></a>
```chmod [who]operator[permissions] filename```
- who means
  - u 🡒 User permissions
  - g 🡒 Group permissions
  - o 🡒 Other permissions
  - a 🡒 All permissions
- operator means:
  - \- 🡒 Take away permission
  - \+ 🡒 Add permission
  - = 🡒 Set permission
- permission means:
  - r 🡒 Read permission
  - w 🡒 write (and delete) permission
  - x 🡒 execute (and access directory) permission
```chmod go-rwx rm.txt``` To remove read write and execute permissions on the file rm.txt for the group and others

```chmod a+rw rm.txt``` To give read and write permissions to all on the file rm.txt 

```chmod a-x linuxstauff/``` Remove execution permissions of the folder linuxstauff/<br>
This causes that this directory cannot be opened (you cannot cd linuxstauff/), you cannot list what is on linuxstauff/, you cannot cat or access any files in it...

## Processes and Jobs  <a name="jobs"></a>
Linux, like most modern OS's is a multitasking operating system. This means that many processes can be running at the same time.

* ```top``` Use this program to get a snapshot of what is currently happening on the system
* ```ps -ef``` To see information about your processes, with their associated PID and status
* ```ps -ef | grep cursof``` Pipe the output to grep to filter out just the data you are after

### Running background processes  <a name="bg"></a>
* ```sleep 10 &``` To run a process at the background, type **&** at the end of the command line. The & runs the job in the background and returns the prompt straight away, allowing you do run other programs while waiting for that one to finish.
* Backgrounding a current foreground process
  - ```sleep 1000``` You can suspend the process running in the foreground by typing **^Z**, i.e.hold down the [Ctrl] key and type [z]. Then to put it in the background, type ```bg```

### Listing suspended and background processes  <a name="fg"></a>
* ```jobs``` When a process is running, backgrounded or suspended, it will be entered onto a list along with a job number.
* ```fg ${jobnumber}``` To restart (foreground) a suspended process, for example: ```fg $1``` Typing fg with no job number foregrounds the last suspended process.

### Killing a process <a name="kill"></a>
**kill** (terminate or signal a process)
It is sometimes necessary to kill a process (for example, when an executing program is in an infinite loop)
To kill a job running in the foreground, type ^C (control c).
* ```kill {PID}``` To kill a suspended or background process. For example, run: ```kill 20077```

A message should be displayed informing the user that the job has been killed. If no message is displaying indicating the job has terminated, it is good idea to wait for a minute in case the process is in the middle of terminating, then issue another kill command, this time with the signal option -9
* ```kill -9 20077```
* ```kill $1``` Kill job number 1

## Other useful UNIX commands <a name="other"></a>
* ```df``` The df command reports on the space left on the file system. For example, to find out how much space is left on the file-server
* ```du```The du command outputs the number of kilobytes used by each subdirectory. Useful if you have gone over quota and you want to find out which directory has the most files. In your home-directory, type ```du -s 

### history <a name="history"></a>
history (show command history list).
```history | grep -i find```

### `ssh` <a name="shh"></a>
To execute a command on a remote Linux server and have the result displayed locally.
```
ssh -X remote_host_ip
```
Once you have connected to the server, you will probably be asked to verify your identity by providing a password. The -X option to ssh enables X11 and allow you to use your terminal as a graphical terminal (for example you could edit a program in the server side with gedit editor).

To get the remote_remote_host_ip you can run on the remote host the command ifconfig
```
$ ifconfig
# Find in the output:     Direc. inet:150.244.64.50
```
So you can enter on the above remote server with ```ssh -X 150.244.64.50```

and then any process that you lunch on this terminal will be executed on the remote server. For example, typing 
```$ xterm &```
you will open other xterminal.

To exit back into your local session, simply type:
```$ exit```

### `nohup`  <a name="nohub"></a>
Most of the time you login into remote server via ssh. If you start a shell script or command and you exit (abort remote connection), the process / command will get killed. Sometimes a job or command takes a long time. If you are not sure when the job will finish, then it is better to leave it running in the background. But, if you log out of the system, the job will be stopped and terminated by your shell.

To keep it use the nohup command line-utility: allows to run command/process or shell scripts that can continue running in the background after you log out from a shell. The syntax is as follows:
```
nohup <command-name> &
```




