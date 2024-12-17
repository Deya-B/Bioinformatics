# Autora: Deyanira Borroto Alburquerque
# PRMDM Assignment: Accessing Ensembl database

import requests

def get_gene():
    """Main program, with the following functions:
    1. Get file input and deal with possible errors.
    2. Obtain gene identifiers from the file.
    3. Request to check gene species.
    """

    file_name = input("Introduce the name of the file "
                     + "containing the identifiers: ")

    try:
        with open(file_name, 'r') as file_in:
            for line in file_in:
                gene_id = line.strip()
                check_gene_species(gene_id)

    except FileNotFoundError:
        print(f"File '{file_name}' not found. "
            + f"Please ensure the file exists.")
    except OSError as e:
        print(f"An error occurred while trying to read the file: {e}")


def check_gene_species(identifier):
    """
    Check if the identifier belongs to a human gene:
    1. If YES, request the sequence.
    2. If NO, provide some information of what is wrong with it.

    Args:
        identifier: An Ensembl stable ID.
    """

    server = "http://rest.ensembl.org"
    headers = {"Content-Type" : "application/json"}
    endpoint_identifier = f"/lookup/id/{identifier}"
    
    id_response = requests.get(f"{server}{endpoint_identifier}", 
                               headers=headers)

    if id_response.status_code == 200:
        gene_info = id_response.json()

        if gene_info["species"] == "homo_sapiens":
            if gene_info["object_type"] == "Gene": # For Genes
                print(f"""\nHuman gene {identifier} result log:
-------------------------------------------""")
                get_sequence(identifier)

            elif gene_info["object_type"] == "Transcript": # For Transcripts
                print(f"""\nHuman transcript {identifier} result log:
-------------------------------------------""")
                print(f"The associated gene for the given transcript is " 
                    + f"{gene_info['Parent']}.")
                get_sequence(gene_info['Parent']) # Obtain the gene DNA 
                                                  # for that Transcript
            else:
                print(f"\nThe human molecule provided is of: **" 
                + f"{gene_info['object_type']} type** NOT a gene.")

        else:
            print(f"\nIdentifier {identifier}: NOT human. "
                + f"\nIt corresponds to the {gene_info['species']} species.")
    else:
        print(f"\nError retrieving identifier:" 
            + f"{id_response.json().get('error', 'Unknown error')}")


def get_sequence(identifier):
    """
    1. Obtain the DNA sequence for the given human gene.
    2. Create a file in the working directory with the name of the gene 
    identifier containing the complete DNA sequence.
    
    Args:
        identifier: An Ensembl stable human gene ID.

    Returns:
        A file named identifier.txt, e.g. ENST00000288602.txt \
        with the DNA sequence.
    """

    server = "http://rest.ensembl.org"
    headers = {"Content-Type" : "application/json"}
    endpoint_sequence = f"/sequence/id/{identifier}"

    sequence_response = requests.get(f"{server}{endpoint_sequence}", 
                                     headers=headers)
    if sequence_response.status_code == 200:
        sequence_info = sequence_response.json()
        sequence = sequence_info['seq']

        filename = f"{identifier}.txt"
        with open(filename, "w") as file_out:
            file_out.write(sequence)
        print(f"The complete DNA sequence for that gene " 
            + f"was extracted to {filename}")

        find_subsequence(sequence)

    else:
        print("\nFailed to retrieve sequence.")


def find_subsequence(dna_sequence):
    """
    Find positions of the "TTTT" subsequences.
    
    Args:
        dna_sequence: The sequence where the subsequence will be searched.

    Returns:
        Prints, only on screen, the positions of the subsequence.
    """
    subsequence = "TTTT"      
    subsequence_positions = [i for i in range(len(dna_sequence) - 3) 
                            if dna_sequence[i:i + 4] == subsequence]
    subsequence_positions_readable = [pos +1 for pos in subsequence_positions]
    
    if subsequence_positions:
        print(f"Positions for the subsequence {subsequence}: "
        + f"{subsequence_positions_readable}")
    else:
        print("No 'TTTT' subsequences found.")


if __name__ == "__main__":
    get_gene()
