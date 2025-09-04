# Text editors
## The vi editor
Text editor that comes with all Linux distributions. <br>
It's screen oriented, doesn't have GUI, meaning that is only text input. <br>
Two modes of operation:
- Command mode: typed characters are interpreted as commands that do something to the text file
- Insert mode: typed characters are directly added to the text being edited

vim ([vi improved](www.vim.org)) is included as vi in most distributions.

### Basic vi commands:
* `vi <filename>` ↠ Start editor (Example: `vi temp.txt` vi will create the file “temp.txt”)
* `i, a` ↠ Input mode: (i) Insert text before cursor, (a) after cursor
* `:x <return>` ↠ Exit saving file
* `:q! <return>` ↠ Exit without saving
* `k, j, h, l` ↠ Move cursor up, down, left, right
* `0, $` ↠ Move cursor to beginning, end of the current line
* `u` ↠ Undo last change
* `Esc` ↠ Exit insert mode and go back to command mode
* `x, dd` ↠ Delete single character, entire line

### Creating a file:
At the command prompt type:
```Nushell
vi temp.txt
```

Press the `i` key to switch to input mode.
Type something like:
```Nushell
  VI is great! I think I'll be using vi from 
  now on instead of Word

  # Press <enter> to add lines.
  Type some more text...

          # Don't experiment much, you will screw up...
```

Save the file that you are in:
- Press `ESC` to enter the command mode (an believe you are in it)
- Type `:wq` to save and quit the file (notice the `:` before the wq!)

### Navigation, copy/paste and editing in vi
1. We will enter a file to Edit it... but let's start at the bottom of the file.
  > [!TIP]
  > Opening a file with THE "+" OPTION opens the file and places the cusor at the end of the file. Handy for long config files.

  ```Nushell
  vi + longfile.txt
  ```
2. Go to the first line of the file. Then go to line 10...
    ```Nushell
    :1
    
    # Go to line 10
    :10
    ```
3. Add a new line by pressing the “o” key, and add in some lines of text:
    ```Nushell
    ##
    ## For example you can add a comment :)
    ##
    ```
4. Delete the three lines you just created:
    - Press `ESC`
    - Then move to the first line of new text
    - Press `dd` to delete the whole line, repeat until the text is gone

5. Save the file, but don’t exit:
    ```Nushell
    :w
    # press <enter>
    ```

#### Copying and pasting text
1. Go to line 12, copy 3 lines of text, go to the bottom of the file, place the text there:
    ```Nushell
    ESC
    :12    # go to line 12 of the file
    3yy    # “yank” 3 lines and place in copy buffer = COPY 3 lines
    G      # go to the end of the file
    p      # place the contents of the copy buffer here = PASTE
    ```
2. If want to undo this you would type (in command mode):
    ```Nushell
    u      # Undo the last change       
    ```
3. Go to the top of the file, replace all occurrences of “A” with “X”, but prompt for each change:
    ```Nushell
    ESC
    :1
    :%s/A/X/gc
    ```
    Say “yes” or “no” to a few prompts. <br>
    Escape from this mode by pressing ^c {Ctrl+c} and {ENTER}.

5. Go to line 1, search for “kernel”, move to the end of the line, add some text:
    ```Nushell
    ESC
    :1
    /kernel        # u otra palabra que esté en tu texto
    ```
   Press `n` to travel between the words that match the pattern.

    ```Nushell
    SHIFT-A        # Press to start writing at the end of the line.
    Add some text
    ESC
    ```

6. Now let’s exit from the file and not save the few changes we’ve made.
  ```Nushell
  :q!
  ```
### More practice:
As you should be able to see vi is extremely powerful as an editor, but not necessarily intuitive. The best way to get good at using vi is to practice.

#### Open a file and practice the following
##### Moving around:
  - By word  `w` or `b`
  - End of line `A` or `$`
  - Start of line `^`
  - Top of file `1G`
  - Bottom of file `G`
  - To an absolute line number `:n`

##### Copy, paste, search, replace:
- Copying and pasting multiple lines (use vi commands,`nyy`)
- Copying and pasting single lines (use vi commands, `yy` & `P` or `p`)
- Copying and pasting multiple lines (use your mouse buffer)
- Copying and pasting single lines (use your mouse buffer)
- Search for items backwards and forwards `?string` or `/string`
- Replacing text  `:s/pattern /string /flags`

[More Basic vi Commands](https://www.cs.colostate.edu/helpdocs/vi.html)

[Quick Reference Card](http://tnerual.eriogerg.free.fr/vimqrc.pdf)


## The [emacs](https://www.gnu.org/software/emacs/) editor
"The extensible, customizable, self-documenting, real-time display editor."

* Content-aware editing modes, including syntax coloring, for many file types
* Complete built-in documentation, including a tutorial for new users
* Full Unicode support for nearly all human scripts
* Highly customizable, using Emacs Lisp code or a graphical interface
* An entire ecosystem of functionality beyond text editing, including a project
* planner, mail and news reader, debugger interface, calendar, and more
* A packaging system for downloading and installing extensions

[GNU Emacs Reference Card](https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf)

## Basic usage
- Start emacs with the command: `emacs`
- Launch the emacs tutorial by typing: `Ctrl+h t`
- Exit: `C-x C-c`
- Cancel a partially introduced command: `C-g`

Emacs commands involve the use of:
- the Control key (called CTRL or CTL) here is called C. For example:
    - `C-<car>` Means: Hold the CTRL key while typing the character car.
    - `C-f` Means: Hold the Control key and type f.
- the Meta key (called EDIT or ALT) here is called M. For example:
    - `M-<car>` Means: Hold the ALT key while typing car.
- \>> on the left side: indicate instructions for you tu use a command

#### Moving around:

- `C-v` Pass to next page
- `C-m` Go to previous page
- `C-l` Show all the text around the pointer. C-l moves you where the pointer is centered in the text. When pressed again moves the text till the pointer is on the top of the screen, and when pressed again moves the text till the pointer is at the bottom of the screen.
- Pointer movement:
  ```emacs
  C-f      forward one character 
  C-b      backwards one character
  
  M-f      foward a word    
  M-b      backwards a word

  C-n      next line
  C-p      previous line

  C-a      start of line
  C-e      end of line

  M-a      start of paragraph
  M-e      end of paragraph

  M-<        begining of the file
  M-shift->  end of the file
  ```

  
