# Autora: Deyanira Borroto Alburquerque
# HPBBC, Final Practical Python: DNA Toolkit

import os

class File_operations:
    """Data files management.
    
    Attributes:
        file: name of the file where it will be saved.
        directory: (By default = Working directory) One or multiple directores hanging 
          from the current directory can be created using the following sintax: dir/n...dirs.
    """
    def __init__(self, file = None, directory = None):
        self.file = file
        self.directory = directory
        self.filelist = []
        self.filedic = {}


    def save(self, sequence):
        """Save the current DNA chain. 
        
        Args:
            sequence: The sequence you want to save.
        
        Returns:
            File and directory names.
        """
        if self.directory is None:
            self.directory = os.getcwd()
        else:
            newpath = os.path.join(os.getcwd(), self.directory)
            os.makedirs(str(self.directory), exist_ok=True) # exists_ok: no issues raised if exists, just use
            self.directory = newpath

        newfilename = self.file + ".dna"
        self.file = newfilename
        newfile = os.path.join(self.directory, newfilename)

        sequence_str = str(sequence) # passing DNA class to string so we can use the write function
        with open(newfile, "w") as file:
            file.write(sequence_str)
        return self.file, self.directory
    

    def list_info(self):
        """List all DNA chains with extension .dna in the current directory.
        
        Returns:
            filelist,  A list with the DNA's.\n
            filedict,  A dictionary with the files.\n
            line_num,  The number of entries found.
        """
        self.filelist = []
        self.filedic = {}
        
        files = os.listdir()  
        line_num = 1  # Line counter starts at 1
        for file in files:
            if file.endswith(".dna"):
                with open(file, 'r') as f:
                    for line in f:
                        components = line.strip().split(",")
                        # Process valid lines
                        if len(components) < 2:
                            print(f"Skipping malformed line in file {file}: {line.strip()}")
                        else:
                            sequences = components[:2]  # Take only length and DNA
                            mount = ",".join(sequences)
                            self.filelist.append(f"[{line_num}] -  {mount}") 
                            self.filedic[line_num] = file  # Create dictionary for later file retrieval of files
                            line_num += 1   # adds 1 each iteration to create line [1] DNA, line [2] DNA, etc
        return self.filelist, self.filedic, line_num 
                                            # line_num: Obtain the numbers present in the list for later error handling

    def load(self, number):
        """Read a DNA chain from the list of elements shown by List.

        Args:
          number: The number corresponding to the sequence to retrieve

        Returns:
          The sequence selected to retrieve
        """
        listing, _, _ = self.list_info()
        for item in listing:
            if item.startswith(f"[{number}]"):
                extracting = item.strip().split(",")
                retrieve = extracting [1]
                return retrieve


    def delete(self, number):
        """Delete a DNA chain from the list of elements shown by List.

        Args:
          number: the number corresponding to the sequence to retrieve

        Returns:
          Filepath of the sequence for deletion
        """
        listing, dictionary, _ = self.list_info()
        for item in listing:
            if item.startswith(f"[{str(number)}]"):
                filename = dictionary[number]
                filepath = os.path.join(os.getcwd(), filename)
                return filepath
                