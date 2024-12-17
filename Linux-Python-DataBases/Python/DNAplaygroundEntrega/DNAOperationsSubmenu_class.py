# Autora: Deyanira Borroto Alburquerque
# HPBBC, Final Practical Python: DNA Toolkit

from DNA_class import DNA
import textwrap

class DNAOperations_submenu:
    """Submenu for DNA operations
    
    Attributes:
        sequence: DNA chain
    """
    def __init__(self, sequence):
        self.sequence = sequence


    def submenu(self):
        """DNA operations submenu loop"""

        while True:
            self.display_menu()
            
            choice = input("··· Enter an option (1-8): ").strip()
            if choice not in "12345678":
                input("Invalid option! Please enter a valid number." 
                      + " Press ENTER to try again.")
                continue

            # Choices:
            if choice == "1":
                self.regenerate_dna()
            elif choice == "2":
                self.validate_dna()
            elif choice == "3":
                self.mutate_dna()
            elif choice == "4":
                self.measure_frequencies()
            elif choice == "5":
                self.count_subsequences()
            elif choice == "6":
                self.synthesize_reverse_complement()
            elif choice == "7":
                self.measure_gc_content()
            elif choice == "8":
                return self.sequence 
            
            else: # wrong inputs in choice
                input("Invalid choice. Please select a valid option.")


    def display_menu(self):
        """Display the submenu and current sequence"""

        menu = textwrap.dedent("""
        ~ Submenu: DNA OPERATIONS ~ 
        ---------------------------
        1 - Re-generate DNA        (Create a fresh DNA sequence)
        2 - Validate DNA           (Check if sequence is valid)
        3 - Mutate DNA             (Introduce mutations)
        4 - Measure frequencies    (Nucleotide frequencies)
        5 - Count subsequences     (Occurrences of a subsequence)
        6 - Synthesize reverse/complement
        7 - Measure GC%            (GC percentage)
        8 - Back to main menu
        -------------------------------------------------------------------""")
        print(menu)
        sequence_display = (
            f"You are working with this sequence: * {self.sequence} * \n"
            f"-------------------------------------------------------------------")
        print(sequence_display)


    def regenerate_dna(self):
        """Re-generate DNA sequence and deal with possible errors"""

        while True:
            try:
                new_length = int(input("Enter the length of the new DNA sequence: "))
                if new_length <= 0:
                    raise ValueError("DNA length must be a positive integer.")
                self.sequence = DNA("").create_seq(new_length)
                print(f"This is your fresh DNA sequence: {self.sequence}.")
                input("Press ENTER to continue.")
                break
            except ValueError as e:
                input(f"Invalid input: {e}. Press ENTER to try again.")


    def validate_dna(self):
        """Validate the current DNA sequence and deal with possible errors"""

        validation = ("** Valid DNA **" # If the result of validate funct. is True
                      if DNA(self.sequence).validate()
                      else "X Invalid DNA X") # if the result is False
        print(f"""
                Validation log: 
                ---------------
                {validation}
                """)
        input("Press ENTER to return to the menu.")


    def mutate_dna(self):
        """Mutate the current DNA sequence and deal with possible errors"""

        while True:
            try:
                mutations = int(input("Enter the number of mutations: "))
                if mutations < 0:
                    raise ValueError("Number of mutations must be a "
                                     + "non-negative integer.")
                original_sequence = self.sequence
                mutated_sequence, mutated_positions = (DNA(self.sequence)
                                                       .mutate(mutations))
                number_positions = [x+1 for x in mutated_positions]
                                   # To show exact position adding +1 to indexes
                print(f"""
                Mutation log:
                -------------
                Original sequence: {original_sequence}
                Mutated sequence:  {mutated_sequence}
                Positions mutated: {sorted(number_positions)}
                """)
                input("Press ENTER to return to the menu.")

                self.sequence = mutated_sequence # update sequence to mutated
                break

            except ValueError as e:
                input(f"Invalid input: {e}. Press ENTER to try again.")

    
    def measure_frequencies(self):
        """Measure nucleotide frequencies"""
        freqs = DNA(self.sequence).measure_freqs()
        print(f"""
                Nucleotide frequencies log: 
                ---------------------------
                {freqs}
                """)
        input("Press ENTER to return to the menu.")


    def count_subsequences(self):
        """Count occurrences of a subsequence"""

        while True:
            subseq = input("Enter the subsequence: ").strip().upper()

            if subseq.isnumeric() or not subseq:
                input("Subsequence cannot be empty or a number! Press ENTER to try again.")
                continue

            count, positions = DNA(self.sequence).count_subseq(subseq)
            locate_positions = [x+1 for x in positions] 
                               # add +1 for exact position
            print(f"""
                Count occurrences of a subsequence log:
                -------------------------------------
                Subsequence repetitions: {count}
                Location of the repetitions: {locate_positions}
                """)
            input("Press ENTER to return to the menu.")
            break


    def synthesize_reverse_complement(self):
        """Synthesize reverse and complement sequences"""

        original, reverse, complement = DNA(self.sequence).synt_complement()
        print(f"""
                Synthesize reverse/complement log:
                ----------------------------------
                Original:   3' {original} 5'
                Complement: 5' {complement} 3'
                Reverse:    5' {reverse} 3'
                """)
        input("Press ENTER to return to the menu.")


    def measure_gc_content(self):
        """Measure GC content"""
        gc_content = DNA(self.sequence).cg_percentage()
        print(f"""
                GC percentage log: 
                -----------------------
                GC%: {gc_content:.2f}
                """)
        input("Press ENTER to return to the menu.")