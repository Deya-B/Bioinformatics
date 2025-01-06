# Programmatic access to biomedical databases

## Querying on-line databases
There are 3 ways of querying an online database (abstraction level or ascending automation):

1. Making a local copy of the database: Not recommended - Manual process, quickly outdated. This copy can be downloaded through `wget` command (wget url/base/de/datos/fichero.txt).

2. Filling forms: Write a program to construct a query (or a related set of queries) to be sent by the program itself.
    - Only option when no API or endpoint is exposed
    - We could write a Python program to fill in the form to access the data in loop, changing the parameter values each search.
    - The URL sintax is
      ```
      scheme:[//host]path[?query][#fragment]
      ```
      - `scheme`  HTTP o HTTPS (secure)
      - `host`  server that contains the database
      - `path`  pathname where the server program is located in the host 
      - `?query` gives parameter names and values for a precise request (the format is `name=value&name2=value2`). What we want to do with python is codify the different parameters to automatically access different entries.
      - For example in this type of form https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw instead of filling it many times, we would want to change the value of the arguments: id=J00231, id=J00232, id=J00233, db=afdb etc.

        > Note: Path and query will require you to know well the server´s API
    
4. Direct HTTP requests: we could do this through Python requests library. We use the URLs of the servers with methods like `GET` and `POST`.

5. Specific API usage: Always the best option (if available). There are some systems that provide their server API to use them from Python. These are known as high level APIs or SDKs. These API REST are not available for all systems. They are very encapsulated, so they do not use URLs, GET or POST.

## Programmatic access to forms:
A lot of libraries available in Python to automate the access and processing
of URLs:
- urllib: low-level access, more adequate for network programming
- requests: very easy to use, a lot of documentation and examples

### `request` library - Basic usage
Installation
```Nushell
# En el terminal install the requests library
sudo apt-get install python3-requests
# or
pip install requests
```

#### The GET Request
One of the most common HTTP methods is GET. The GET method indicates that you’re trying to get or retrieve data from a specified resource. To make a GET request you can invoke `requests.get()`. 

```python
import requests
requests.get('https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw')
```

#### The Response
A `response` is a powerful object for inspecting the results of the request. 
```python
import requests
response = requests.get('https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw')
```
In this example, you’ve captured the return value of `get()`, which is an instance of `Response`, and stored it in a variable called `response`.

You can now use response to see a lot of information about the results of your GET request.

> **Status Codes**:
> The first bit of information that you can gather from Response is the status code. A status code informs you of the status of the request.
>
> For example, a 200 OK status means that your request was successful, whereas a 404 NOT FOUND status means that the resource you were looking for wasn’t found. There are many other possible status codes as well to give you specific insights into what happened with your request.
>
> By accessing `.status_code`, you can see the status code that the server returned:
>
> ```python
> response.status_code
> 200
> ```
> 
> If you use a Response instance in a conditional expression, requests will evaluate to True if the status code was smaller than 400, and False otherwise:
>
> ```python
> if response:
>     print("Success!")
> else:
>     raise Exception(f"Non-success status code: {response.status_code}")
> ```
> 
> Let’s say you don’t want to check the response’s status code in an if statement. Instead, you want to use Request’s built-in capacities to raise an exception if the request was unsuccessful. You can do this using `.raise_for_status()`:
>
> ```python
> import requests
> from requests.exceptions import HTTPError
> URLS = ["https://api.github.com", "https://api.github.com/invalid"]
> for url in URLS:
>    try:
>        response = requests.get(url)
>        response.raise_for_status()
>    except HTTPError as http_err:
>        print(f"HTTP error occurred: {http_err}")
>    except Exception as err:
>        print(f"Other error occurred: {err}")
>    else:
>        print("Success!")
> ```
>
> If you invoke `.raise_for_status()`, then Requests will raise an HTTPError for status codes between 400 and 600. If the status code indicates a successful request, then the program will proceed without raising that exception.


#### Content
The response of a GET request often has some valuable information, known as a payload, in the message body. Using the attributes and methods of Response, you can view the payload in a variety of different formats.

To see the response’s content in string you access `.text`:
```
response.text
type(response.text)
<class 'str'>
```

```python
import requests
url = 'https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw'
response = requests.get(url)

print(response.text)
```
---
Is possible to construct the URL though an `F-string` by adding the **parameters** in `{}`:

f'https://www.ebi.ac.uk/ Tools/dbfetch/dbfetch?db= `{tipo}` &id=J00 `{dna_id}` &style=raw' <br>
To add the different id's, such as: 231, 232, 233...

---

##### Example 1. To *get the ‘id’ parameter from the user* and show the result:
```py
import requests

dna_id = input("Introduce el identificador J00: ") # Ex: J00231
tipo = "ena_sequence"

ebi_url = f'https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db={tipo}&id=J00{dna_id}&style=raw'

# USE the GET method on the URL to bring the contents
response = requests.get(ebi_url)
print(response.text)
```
```
ID   J00231; SV 1; linear; mRNA; STD; HUM; 1089 BP.
XX
AC   J00231;
XX
DT   13-JUN-1985 (Rel. 06, Created)
DT   17-APR-2005 (Rel. 83, Last updated, Version 9)
XX
DE   Human Ig gamma3 heavy chain disease OMM protein mRNA.
XX
KW   C-region; gamma heavy chain disease protein;
KW   gamma3 heavy chain disease protein; heavy chain disease; hinge exon;
KW   immunoglobulin gamma-chain; immunoglobulin heavy chain;
KW   secreted immunoglobulin; V-region.
XX
OS   Homo sapiens (human)
OC   Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi; Mammalia;
OC   Eutheria; Euarchontoglires; Primates; Haplorrhini; Catarrhini; Hominidae;
OC   Homo.
XX
RN   [1]
RP   1-1089
RX   DOI; 10.1073/pnas.79.10.3260.
RX   PUBMED; 6808505.
RA   Alexander A., Steinmetz M., Barritault D., Frangione B., Franklin E.C.,
RA   Hood L., Buxbaum J.N.;
RT   "gamma Heavy chain disease in man: cDNA sequence supports partial gene
RT   deletion model";
RL   Proc. Natl. Acad. Sci. U.S.A. 79(10):3260-3264(1982).
XX
DR   MD5; dbfb2a63ffcc88671722e91e641adcaa.
DR   CABRI; LMBP 2079.
DR   CABRI; LMBP 2146.
DR   CABRI; LMBP 2147.
...
DR   EuropePMC; PMC2739203; 19682364.
DR   IMGT/LIGM; J00231.
XX
CC   The protein isolated from patient OMM is a gamma heavy chain
CC   disease (HCD) protein. It has a large 5' internal deletion
CC   consisting of most of the variable region and the entire ch1
CC   domain. [1] suggests that the protein abnormality is from a partial
CC   gene deletion rather than from defective splicing.
XX
FH   Key             Location/Qualifiers
FH
FT   source          1..1089
FT                   /organism="Homo sapiens"
FT                   /map="14q32.33"
FT                   /mol_type="mRNA"
FT                   /db_xref="taxon:9606"
FT   mRNA            <1..1089
FT                   /note="gamma3 mRNA"
FT   CDS             23..964
FT                   /codon_start=1
FT                   /gene="IGHG3"
FT                   /note="OMM protein (Ig gamma3) heavy chain"
FT                   /db_xref="GOA:P01860"
FT                   /db_xref="HGNC:HGNC:5527"
FT                   /db_xref="InterPro:IPR003006"
FT                   /db_xref="InterPro:IPR003597"
FT                   /db_xref="InterPro:IPR007110"
FT                   /db_xref="InterPro:IPR013783"
FT                   /db_xref="InterPro:IPR036179"
FT                   /db_xref="PDB:4WWI"
FT                   /db_xref="PDB:4ZNC"
FT                   /db_xref="PDB:5M3V"
FT                   /db_xref="PDB:5W38"
FT                   /db_xref="PDB:6D58"
FT                   /db_xref="PDB:6G1E"
FT                   /db_xref="UniProtKB/Swiss-Prot:P01860"
FT                   /protein_id="AAA52805.1"
FT                   /translation="MKXLWFFLLLVAAPRWVLSQVHLQESGPGLGKPPELKTPLGDTTH
FT                   TCPRCPEPKSCDTPPPCPRCPEPKSCDTPPPCPRCPEPKSCDTPPPCPXCPAPELLGGP
FT                   SVFLFPPKPKDTLMISRTPEVTCVVVDVSHEDPXVQFKWYVDGVEVHNAKTKLREEQYN
FT                   STFRVVSVLTVLHQDWLNGKEYKCKVSNKALPAPIEKTISKAKGQPXXXXXXXXXXXXE
FT                   EMTKNQVSLTCLVKGFYPSDIAVEWESNGQPENNYNTTPPMLDSDGSFFLYSKLTVDKS
FT                   RWQQGNIFSCSVMHEALHNRYTQKSLSLSPGK"
FT   sig_peptide     26..79
FT                   /gene="IGHG3"
FT                   /note="OMM protein signal peptide"
FT   mat_peptide     80..961
FT                   /gene="IGHG3"
FT                   /note="OMM protein mature peptide"
XX
SQ   Sequence 1089 BP; 240 A; 358 C; 271 G; 176 T; 44 other;
     cctggacctc ctgtgcaaga acatgaaaca nctgtggttc ttccttctcc tggtggcagc        60
     tcccagatgg gtcctgtccc aggtgcacct gcaggagtcg ggcccaggac tggggaagcc       120
     tccagagctc aaaaccccac ttggtgacac aactcacaca tgcccacggt gcccagagcc       180
     caaatcttgt gacacacctc ccccgtgccc acggtgccca gagcccaaat cttgtgacac       240
...
//
```

##### Example 2. To show *only the lines containing the organism and the molecule type* for the sequence.
```py
import requests

ebi_url = 'https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw'
response = requests.get(ebi_url)

# splitlines() attribute
salida = response.text.splitlines()
                       # Split a string into a list where each line is a list item
                       # needed to create a list in order to iterate with it in the loop

for line in salida:
    if line.startswith("OS"):  # orgaminsm
        print(line)
    if line.startswith("KW"):  # tipo de molecula
        print(line)
```
```
KW   C-region; gamma heavy chain disease protein;
KW   gamma3 heavy chain disease protein; heavy chain disease; hinge exon;
KW   immunoglobulin gamma-chain; immunoglobulin heavy chain;
KW   secreted immunoglobulin; V-region.
OS   Homo sapiens (human)
```

#### Passing parameters
One common way to customize a GET request is to pass values through query string parameters in the URL. To do this using get(), you pass data to params as a dictionary.

---
The `request`library admits a dictionary called `params` in which we can pass the **arguments**:
```python
    params = {'db': 'ena_sequence', 'id':'J00231' , 'style':'raw'}
```
`db`: Specifies the database you're querying. In this case, ena_sequence indicates you're querying the ENA (European Nucleotide Archive) sequence database.

`id`: Specifies the unique identifier of the sequence you want. In this case, 'J00231' is the ID of the sequence you're requesting.

`style`: Specifies the format in which you want the data. The raw style means that you want the raw sequence data, without additional formatting.

---

```python
import requests
ebi_url = 'https://www.ebi.ac.uk/Tools/dbfetch/dbfetch'

response = requests.get(ebi_url,
    params = {'db': 'ena_sequence', 'id':'J00231' , 'style':'raw'}
)
print(response.text)
```

##### Example 1:
```python
import requests
urlbase = "https://www.ebi.ac.uk/Tools/dbfetch/dbfetch"

# Set parameters
parameters = {'db':'uniprotkb','id':'S4TR86','format':'fasta','style':'raw'}

# Make the request!
print(requests.get(urlbase, params=parameters).text)
```

##### Example 2: To retrieve different sequences. Read each ID from 'prot_codes.txt' (one per line).
```python
import requests

urlbase = "https://www.ebi.ac.uk/Tools/dbfetch/dbfetch"
params = {'db':'uniprotkb','id':'S4TR86','format':'fasta','style':'raw'}

#Read each ID from 'prot_codes.txt' (one per line)
file = "./prot_codes.txt"
with open(file) as f:
    for line in f:  # each line is a dna id
        params['id'] = line.strip()
        print(requests.get(urlbase, params=params).text)
```

```
>UNIPROT:1433X_MAIZE P29306 14-3-3-like protein (Fragment)
ILNSPDRACNLAKQAFDEAISELDSLGEESYKDSTLIMQLLXDNLTLWTSDTNEDGGDEI
K

>tr|S4TR86|S4TR86_9HEMI Cytochrome c oxidase subunit 1 (Fragment) OS=Graptocleptes sp. 00004431 OX=1276425 GN=COI PE=3 SV=1
LGTPGTFIGNDQIYNVFVTAHAFIMIFFMVMPIMIGGFGNWLVPLMIGAPDMAFPRMNNM
SFWLLPPSLTLLLISSIAEGGAGTGWTVYPPLSSNIAHSGAAVDLAIFSLHLAGVSSILG
AVNFISTIINMRPXGMSPERIPMFVWSVGITALLLLLSLPVLAGAITMLLTDRNFNTSFF
DPSGGGDPILYQHLFWFFGHPEVXILILPGFGLISHIIAMETGK

>tr|S4TR87|S4TR87_9CAUD dUTP diphosphatase OS=Salmonella phage FSL SP-058 OX=1173761 GN=SP058_00140 PE=3 SV=1
MQVKLRVLPFNNPNMSVPARATEGSAGVDLRANTSEPFELKPGETKLIETGLAIHLDDVH
VAAMILPRSGLGHKHGVVLGNLTGLIDSDYQGELMVSLWNRSTEPFTVNPGDRIAQMVIV
PVMQPEFVVVDSFESTERGAGGFNSTGVK

>UNIPROT:1433T_RAT P68255 14-3-3 protein theta (14-3-3 protein tau)
MEKTELIQKAKLAEQAERYDDMATCMKAVTEQGAELSNEERNLLSVAYKNVVGGRRSAWR
VISSIEQKTDTSDKKLQLIKDYREKVESELRSICTTVLELLDKYLIANATNPESKVFYLK
MKGDYFRYLAEVACGDDRKQTIENSQGAYQEAFDISKKEMQPTHPIRLGLALNFSVFYYE
ILNNPELACTLAKTAFDEAIAELDTLNEDSYKDSTLIMQLLRDNLTLWTSDSAGEECDAA
EGAEN
```

#### Response json()
The response of the GET method, it’s actually serialized JSON content. <br>
To get a dictionary, you could take the str that you retrieved from `.text` and deserialize it using `json.loads()`. <br>
However, a simpler way to accomplish this task is to use `.json()`:

```python
response.json()
type(response.json())
<class 'dict'>
```
The type of the return value of `.json()` is a dictionary, so you can access values in the object by key.

#### Response Headers
The response headers can give you useful information, such as the content type of the response payload and a time limit on how long to cache the response. To view these headers, access `.headers`:
```python
import requests
response = requests.get("https://api.github.com")
response.headers

{'Server': 'GitHub.com',
...
'X-GitHub-Request-Id': 'AE83:3F40:2151C46:438A840:65C38178'}
```




## JSON
```python

```


```python

```

```python

```

