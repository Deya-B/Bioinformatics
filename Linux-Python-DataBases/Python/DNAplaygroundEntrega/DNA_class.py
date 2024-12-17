# Autora: Deyanira Borroto Alburquerque
# HPBBC, Final Practical Python: DNA Toolkit

import numpy
import random

class DNA:
    """DNA manipulation.    
    
    Attributes:
        sequence: DNA chain
        frequencies: The frequencies at which each base is present 
        length: The legth of the chain
    """
    def __init__(self, sequence): 
        self.sequence = sequence
        self.freqs = self.measure_freqs()
        self.length = len(self.sequence)


    def __str__(self):
        self.length = len(self.sequence)
        self.freqs = self.measure_freqs()
        return str(self.length)+ "," + str(self.sequence)+ "," + str(self.freqs)
    

    def create_seq(self, length):
        """Create a random sequence.

        Args:
          length: provide desired chain length

        Returns:
          Sequence: A new sequence of given length
        """
        nuclFreq = [0.2, 0.3, 0.3, 0.2]     # Make nucleotides' frequency to 
                                            # be slightly more realistic
        nucleotidos = ["A", "C", "G", "T"]
        self.sequence = numpy.random.choice(nucleotidos, size=length, p=nuclFreq)
        self.sequence = numpy.array(self.sequence) # Avoiding future array problems 
                                                   # changing array to numpy array
        self.sequence = ''.join(self.sequence.tolist()) # numpy array to list 
                                                        # and join into STRING
        return self.sequence


    def validate(self):
        """Make sure that the sequence contains only valid nucleotides.

        Returns:
          True (valid) or False (non-valid).
        """

        for base in self.sequence:
            if base not in "ATCG":
                return False
        return True
    
    
    def measure_freqs(self):
        """Count the amount of each nucleotide.

        Returns:
          frequencies: A dictionary with the frequencies for each nucleotide
        """

        self.freqs = {"A":0, "T":0, "G":0, "C":0}

        for nucleotido in self.sequence:  
            if nucleotido == "A":
                self.freqs["A"] += 1

            elif nucleotido == "T":
                self.freqs["T"] += 1

            elif nucleotido == "G":
                self.freqs["G"] += 1

            elif nucleotido == "C":
                self.freqs["C"] += 1

        return self.freqs
    

    def count_subseq(self,chainIn):
        """Count the number of times that appears a given subsequence.

        Args:
            chain-in: The sequence to find

        Returns:
            chainIn_count, the number of ocurrences of the given nucleotide chain.\n
            chains_positions, the positions at which those ocurrences start.
        """

        chainIn_count = 0
        chains_positions = []
        chainIn_length = len(chainIn)
        i = 0

        while i <= len(self.sequence) - chainIn_length:
            find = self.sequence[i:i + chainIn_length]
            if chainIn == find:
                chains_positions.append(i)
                chainIn_count += 1
                i += chainIn_length # to move index forward by the length 
                                    # of the subsequence to avoid overlap
            else:
                i += 1    # otherwise, move to next character

        return chainIn_count, chains_positions 
    
    
    def synt_complement (self):
        """Obtaining  the reverse and complementary chain.

        Returns:
            sequence, the given chain.\n
            reverse, the reversed of the sequence.\n
            complementary, the complement chain to the sequence.
        """
        sequence = self.sequence
        reverse = sequence[::-1]
        to_replace = {"A":"T", "T":"A", "G":"C", "C":"G"}
        result = []

        for nucl in self.sequence:
            result += to_replace[nucl]
        complementary = ''.join(result)

        return sequence, reverse, complementary
    
    
    def cg_percentage (self):
        """Measure CG_percentage of the sequence.

        Returns:
            CG Percentage
        """
        CG_count = 0
        total = 0  # Calculate total number of CG dinucleotides
        
        for i in range (len(self.sequence)-1):
            dinucleotide = self.sequence[i:i + 2]
            if dinucleotide == "CG":
                CG_count += 1
            total += 1
        if total == 0:
            return 0
        
        return (CG_count*100)/total
    

    def mutate(self,num_mutations):
        """Mutate the sequence.

        Args:
            num_mutations: The number of mutations that you want to introduce

        Returns:
            mutated_seq, the resultant mutated sequence\n
            positions, the mutation positions in the chain
        """
        positions = random.sample(range(0, len(self.sequence)), num_mutations) 
                                        # for given number of unique positions
        result = list(self.sequence)

        for i in range(len(self.sequence)):
            if i in positions:
                if result[i] == "A":
                    result[i] = random.choice(["C", "G", "T"])

                elif result[i] == "C":
                    result[i] = random.choice(["A", "G", "T"])

                elif result[i] == "G":
                    result[i] = random.choice(["C","A","T"])

                elif result [i] == "T":
                    result[i] = random.choice(["C","G","A"])

        mutated_seq = ''.join(result)

        return mutated_seq, positions 