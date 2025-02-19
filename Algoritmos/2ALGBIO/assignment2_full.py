# %%
## Assignment 2

# %% [markdown]
# 
# 
# 
# ### Question 1.
# 
# To work with files in Python we first open them (i.e., get a handle to traverse them) as in `f = open('name.txt', 'r')` and then proceed to read it. Useful methods for this are 
# 
# * `f.read()` which returns a string with the entire file; 
# * `f.readline()` which returns a string with the next line; 
# * `f.readlines()` which returns a list of string with each of the file lines.
# 
# Write a function `num_lines_chars(f_name)` that returns the number of lines and chars in the text file named `f_name`.

# %% [markdown]
# ### Question 1.
# 
# Write a function `num_non_wspace_chars(f_name)` that returns the number of non whitespace chars in a text file.

# %%
# LO HE INTENTADO CON EL METODO STRING.WHITESPACE PERO NO HE PODIDO.
import string

def num_non_wspace_chars(f_name):
    """We can read the file as a string and apply to it the method .split()
    that ignores any whitespace and returns a list with its words.
    We can then join these words with nothing between them.
    """
    with open (f_name, "r") as f:
        seq = f.read()
        count = 0
        for _ in seq != string.whitespace:
            count += 1
            return count

f_name = "assignment_1_2023.ipynb"    
print(num_non_wspace_chars(f_name))

# %%
def num_non_wspace_chars(f_name):
    """We can read the file as a string and apply to it the method .split()
    that ignores any whitespace and returns a list with its words.
    We can then join these words with nothing between them.
    """
    with open (f_name, "r") as f:
        seq = f.read()
        tolist = seq.split(' ') # Split spacios en blanco y crear una lista
        characters = ''.join(tolist) # join all chars without spaces
        count = 0
        for _ in characters:
            count += 1
        return count
        
f_name = "assignment_1_2023.ipynb"    

print(num_non_wspace_chars(f_name))

# %% [markdown]
# ### Question 2.
# 
# Write a function `num_words(f_name)` that returns the number of words (i.e., groups of chars surrounded by whitespace) in a text file.
# 
# Hint: `strng.split()`?

# %%
def num_words(f_name):
    """Just change slightly the approach/code of the previous function.
    """
    with open (f_name, "r") as f:
        file = f.read()
        tolist = file.split()
        count = 0
        for _ in tolist:
            count += 1
    return count

f_name = "assignment_1_2023.ipynb" 
print(num_words(f_name))

# %% [markdown]
# ### Question 3.
# 
# Once we have written some (hopefully) useful code in a notebook we would like to keep it as a `.py` file.
# 
# We can do so by downloading it as a Python file but with the inconvenience of getting all the markdown as commented lines.
# 
# Write a function `clean_notebook(f_in, f_out)` that reads such a file `f_in` and saves it as a new Python file `f_out`where all those inconvenient lines are removed.

# %%
def clean_notebook(f_in, f_out):
    """We can read each line in the file, check if the line is a markdown one
    and write to the output file the ones that aren't.
    """
    with open (f_in, "r") as f1:
        fullfile = f1.readlines()
        
        for lines in fullfile:
            if lines.startswith("#"):
                pass
            else:
                with open(f_out, "a") as f2: # 'w' is used to overwrite any existing content
                    f2.write(lines)          # 'a' is used to append
                    
        return print(f"Operation completed! --> {f_in} cleaned to >> {f_out}") 


# To get the .py document, this one has to be exported as a python file
f_in  = "assignment2_full.py"
f_out = "assign2_clean.py"

clean_notebook(f_in, f_out)

# %% [markdown]
# ### Question 4.
# 
# After checking the output file, we realize that we also want to remove all the lines that do not correspond to the functions we have defined.
# 
# Write a better version of `clean_notebook` that removes them and leaves only the functions we have defined.

# %%
def clean_notebook2(f_in, f_out):
    """Starting with the previous code, decide what other lines you
    have to remove and just write out the ones to keep.
    """
    with open (f_in, 'r') as f1:
        for line in f1:
            if line.startswith("def") or line.startswith("  "):
                with open (f_out, 'a') as f2:
                    f2.write(line)

f_in  = "assign2_clean.py"
f_out = "assign2_best.py"

clean_notebook2(f_in, f_out)


