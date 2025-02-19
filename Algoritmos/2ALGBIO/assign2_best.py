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


def clean_notebook2(f_in, f_out):
    """Starting with the previous code, decide what other lines you
    have to remove and just write out the ones to keep.
    """
    with open (f_in, 'r') as f1:
        for line in f1:
            if line.startswith("def") or line.startswith("  "):
                with open (f_out, 'a') as f2:
                    f2.write(line)
