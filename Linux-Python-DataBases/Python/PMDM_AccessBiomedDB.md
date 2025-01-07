# Programmatic access to biomedical databases

## Querying on-line databases
There are 3 ways of querying an online database (abstraction level or ascending automation):

1. Making a **local copy of the database**:
    - Not recommended
    - Manual process, quickly outdated.
    - This copy can be downloaded through `wget` command (wget url/base/de/datos/fichero.txt).
2. **Filling forms**: 
    - Write a program to construct a query (or a related set of queries) to be sent by the program itself.
    - Only option when no API or endpoint is exposed
    - We could write a Python program to fill in the form to access the data in loop, changing the parameter values each search.
    - The URL sintax is
      ```
      scheme:[//host]path[?parameters]
      ```
      - `scheme`  HTTP o HTTPS (secure)
      - `host`  server that contains the database
      - `path`  pathname where the server program is located in the host 
      - `?parameters` parameter names and values for a precise request <br>
        (the format is `name=value&name2=value2`).
      - What we want to do with python is codify the different parameters to automatically access different entries. For example in this type of form  <br>
        https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw  <br>
        instead of filling it many times, we would want to change the value of the arguments:<br>
        id=J00231, id=J00232, id=J00233, db=afdb etc.

        > Note: Path and query will require you to know well the server´s API
    
4. **Direct HTTP requests**: 
    - This could be done through Python requests library.
    - By using the **URLs** of the servers with methods like `GET` and `POST`.
    
5. Specific **API usage**:
    - Always the **BEST option**, however, these API REST are not available for all systems.
    - There are some systems that provide their server API to use them from Python.
    - These are known as high level APIs or SDKs.
    - They are very encapsulated, so they do not use URLs, GET or POST.


## Programmatic access to forms:
A lot of libraries available in Python to automate the access and processing
of URLs:
- `urllib`: low-level access, more adequate for network programming
- `requests`: very easy to use, a lot of documentation and examples

### `request` library - Basic usage
Installation
```Nushell
# En el terminal install the requests library
sudo apt-get install python3-requests
# or
pip install requests
```

#### The GET Request
One of the most common HTTP methods is GET. <br>
The GET method indicates that you're trying to get or retrieve data from a specified resource.<br>
To make a GET request you can invoke `requests.get()`. 
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
In this example, you've captured the return value of `get()`, which is an instance of `Response`, and stored it in a variable called `response`.

You can now use response to see a lot of information about the results of your GET request.

> **Status Codes**:
>
> The first bit of information that you can gather from Response is the status code. A status code informs you of the status of the request.
>
> For example:
> - a 200 OK status means that your request was successful,
> - whereas a 404 NOT FOUND status means that the resource you were looking for wasn't found.
> There are many other possible status codes as well to give you specific insights into what happened with your request.
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
> If you want to use Request's built-in capacities to raise an exception if the request was **unsuccessful**. You can do this using `.raise_for_status()`:
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
> If you invoke `.raise_for_status()`, then Requests will raise an HTTPError for status codes between 400 and 600. <br>
> If the status code indicates a successful request, then the program will proceed without raising that exception.


#### Content
The response of a GET request often has some valuable information, known as a payload, in the message body. Using the attributes and methods of Response, you can view the payload in a variety of different formats.

To see the response's content in string you access `.text`:
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
Is possible to construct the URL through an `F-string` by adding the **parameters** in `{}`:

`f'https://www.ebi.ac.uk/ Tools/dbfetch/dbfetch?db=ena_sequence&id=J00 {dna_id} &style=raw'` <br>
In this way is possible add the different dna_id's, such as: 231, 232, 233...

---

##### Example 1. To *get the 'id' parameter from the user* and show the result:
```py
import requests

dna_id = input("Introduce el identificador J00: ") # Ex: J00231
tipo = "ena_sequence"

ebi_url = f'https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db={tipo}&id=J00{dna_id}&style=raw'

# USE the GET method on the URL to bring the contents
response = requests.get(ebi_url)
print(response.text)
```

##### Example 2. To show *only the lines containing the organism and the molecule type* for the sequence.
```py
import requests

ebi_url = 'https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw'
response = requests.get(ebi_url)

# Using the text attribute of GET + splitlines() method
salida = response.text.splitlines()
                       # Split a string into a list where each LINE is a list item
for line in salida:
    if line.startswith("OS"):  # orgaminsm
        print(line)
    if line.startswith("KW"):  # tipo de molecula
        print(line)
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


#### Response json()
The response of the GET method, it's actually serialized JSON content. <br>
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

| JSON operations | code | function |
|------|------|------|
|To dict | `dict =`<br>**`json.loads(str)`** | Converts a string into a native dictionary |
| To string | `str =`<br>**`json.dumps(dict, indent = x)`** | Converts a dictionary into a string. <br> Optionally, formats output with indent.|
|To file | **`json.dump(dict, file)`** | Writes a JSON object (dict) into a file |

```python
import json

# some JSON:
json_data =  '{"name":"John", "age":30, "city":"New York"}'

# Print JSON
print(json_data)
# [OUT]{"name":"John", "age":30, "city":"New York"}

print(type(json_data))
# [OUT]<class 'str'>    !!! Note that till here the type is just a STRING...
```

*Before a JSON structure can be used as a native **Python object**, <br>
it must be “loaded” into one.* <br>
JSON structures are similar to dictionaries:
```python
import json

# some JSON:
json_data =  '{ "name":"John", "age":30, "city":"New York"}'
dict_data = json.loads(json_data)

# What is exactly the type?
print(type(json_data))
# [OUT]<class 'str'>
print(type(dict_data))
# [OUT]<class 'dict'>

# If we run:
print(json_data["age"]) # esto NO funciona
print(dict_data["name"]) # pero esto SI
# [OUT]John
```

Therefore, before accesing and working with a **JSON structure**, it must be <br>
**converted to a JSON dictionary** with the **json.loads()** function.
```python
import json

json_data =  '{ "name":"John", "age":30, "city":"New York"}'
dict_data = json.loads(json_data)

print(f'The age of {dict_data["name"]} is {dict_data["age"]}')
# [OUT]The age of John is 30
```

If you have a **Python object**, you can  <br>
convert it into a **JSON string** <br>
by using the **json.dumps()** method.
```python
import json

# a Python object (dict):
dict_data = {
  "name": "John",
  "age": 30,
  "city": "New York",
}

# Convert into JSON string
json_data = json.dumps(dict_data)

# The result is now a JSON string
print(json_data)
# [OUT]{"name": "John", "age": 30, "city": "New York"}
print(type(dict_data))
# [OUT]<class 'dict'>
print(type(json_data))
# [OUT]<class 'str'>
```

If the structure is big, showing it in one line is not very clear. <br>
Use the following parameter for a prettier format:
```python
import json
data =  '{ "name":"John", "age":30, "city":"New York"}'

# Print the JSON structure
json_data = json.loads(data)
print(json_data)
# [OUT]{'name': 'John', 'age': 30, 'city': 'New York'}
print(type(json_data))
# [OUT]<class 'dict'>

# A bit prettier
print(json.dumps(json_data, indent = 2))
# [OUT]
#{
#  "name": "John",
#  "age": 30,
#  "city": "New York"
#}
dumpta = json.dumps(json_data)
print(type(dumpta))
# [OUT]<class 'str'>
```

#### Exercise 1: Show only the names of the persons contained in the ['people.json'](./Exercises/people.json) file, along the city where they live (for example, "John - New York")
```python
import json

# Read the file
file = open ("people.json", "r").read()

# Convert JSON to a native type
json_file = json.loads(file)

# Iterate over each person
for person in json_file:
    # Now person is a dictionary 
    print(f"{person["name"]} - {person["city"]}")
```

### Serialization / deserialization
Once a JSON structure have been converted to a native dictionary, it can be used and modified as usual.

Converting Python object and writing into a JSON file:
```python
import json

# a Python object (dict):
file = open ("people.json", "r").read()

# Convert into a JSON dictionary
json_file = json.loads(file)

# Modify the residence of people to Madrid
for person in json_file:
    person["city"] = "Madrid"

json_data_mad = json.dumps(json_file)
print(json_data_mad)

# write the results into a new file
open("people_madrid.json", "a").write(json_data_mad)
    # or
    with open("people_madrid.json", "w") as write:
        json.dump(json_data_mad, write)
```

JSON is a format that encodes objects in a string. <br>
**Serialization** is the process of encoding from a native data type to JSON format. Convert an object into that string usually to store it in a file... <br>
- Say, you have an object:
```python
    data = {
        'president': {
            "name": """Mr. Presidente""",
            "male": True,
            'age': 60,
            'wife': None,
            'cars': ('BMW', "Audi")
        }
    }
```
- serializing into JSON will convert it into a string which can be stored or sent:
```python
    # serialize
    json_data = json.dumps(data, indent=2)

    print(json_data)
    # {
    #   "president": {
    #     "name": "Mr. Presidente",
    #     "male": true,
    #     "age": 60,
    #     "wife": null,
    #     "cars": [
    #       "BMW",
    #       "Audi"
    #     ]
    #   }
    # }
```

**JSON Deserialization** is the inverse process: convert from **string -> object**. <br>
- The receiver can then deserialize the previous string to get back the original object:
```python
    # deserialize
    restored_data = json.loads(json_data)
```



## API REST usage
Anatomy of a REST request

![image](https://github.com/user-attachments/assets/3f6072b9-0ad7-4f2a-9769-02645ab47594)

#### REST Access uses HTTP methods:
The original HTTP methods semantics are:
- **GET** Asks to receive a representation of the identified resource
- **POST** Intended for adding some information to the resource
- **HEAD** (like GET but without receiving the body, only headers)
- Other verbs include DELETE, PUT, CONNECT, TRACE, CONNECT (rarely used)

#### GET vs POST
|GET|POST|
|---|---|
|URLs for **GET method**<br> `http://rest.ensembl.org/archive/id`<br>`/ENSG00000157764` | An equivalent **POST method** uses `http://rest.ensembl.org/archive/id/`|
|The parameters (payload) are part of the URL | The URL has **NO parameter info**. <br> These must be sent in the request body:<br> `response = requests.post(server, data = {"id" : ["ENSG00000157764", "ENSG00000248378"]})`|
|An example of a GET mehthod is the [GET archive/id/:id](http://rest.ensembl.org/documentation/info/archive_id_get)| An example of a POST mehthod is the [POST archive/id](http://rest.ensembl.org/documentation/info/archive_id_post) |
|Only one identifier at a time | Many identifiers can be submitted in one go <br> Will usually have a Maximum POST size |


### GET programmatically
For calling the following GET URL: <br>
http://rest.ensembl.org/sequence/id/ENSG00000157764 <br>
The documentation can be seen [here](http://rest.ensembl.org/documentation/info/sequence_id) <br>

#### Code:
`requests.get(endpoint, headers={ "Content-Type" : "text/plain"})`
- Being `endpoint`:
    - `endpoint = f"http://rest.ensembl.org/sequence/id/{gene}"` *defined earlier*
    - or
    - `server+ext` *replacing endpoint*
        - `server = "https://rest.ensembl.org"` 
        - `ext = "/sequence/id/ENSG00000157764?"`
        - or
        - `ext = f"/sequence/id/{id}"`  

#### Example:
```python
import requests

gene = "ENSG00000157764"
endpoint = f"http://rest.ensembl.org/sequence/id/{gene}"

r = requests.get(endpoint, headers={ "Content-Type" : "text/plain"})
```

### GET parameters
Specified with **'params'**

#### Code:
`parameters = {'species': 'homo_sapiens'}` <br>
`r = requests.get(endpoint, params = parameters, headers={"Content-Type" : "text/json"})`
- Being `parameters`:
    - a **dictionary** containing the keys and desired values for the search.

#### Example:
```python
import requests

gene = "ENSG00000157764"
endpoint = f"http://rest.ensembl.org/sequence/id/{gene}"
parameters = {'species': 'homo_sapiens'}

r = requests.get(endpoint, params = parameters, headers={"Content-Type" : "text/json"})
```

### POST programmatically
**Parameters**
`response = requests.post(server, data = {'key':'value'})`


### Processing the response
The response object contains all the data sent from the server in response to your GET request, including headers and the data payload:
```python
response.content() # Return the raw bytes of the data payload
response.text() # Return a string representation of the datapay load
response.json() # This method is convenient when the API returns JSON
```

### Dealing with errors
response.status_code contains the HTTP code returned by the API
```python
response = requests.get(server)
if (response.status_code == 200):
    print("The request was a success!")
    # Code here will only run if the request is successful
```

### Examples:
#### Basic GET request (/sequence/id/)
```python
import requests, sys

server = "https://rest.ensembl.org"
ext = "/sequence/id/ENSG00000157764?"

r = requests.get(server+ext, headers={ "Content-Type" : "text/plain"})

if not r.ok:
  r.raise_for_status()
  sys.exit()

print(r.text)
```

#### GET request(/info/software?) to get the software version of the API.
```python
import requests, sys

server = "http://rest.ensembl.org"
endpoint = "/info/software?"

r = requests.get(f"{server}{endpoint}", headers={ "Content-Type" : "application/json"})

if not r.ok:
  r.raise_for_status()
  sys.exit()

print(r.json())

# TIP: JSON structures are difficult to read if not are properly formatted. Use `pprint` module for that.
import pprint
pprint.pprint(r.json())
```

#### Processing responses and errors
The response objects has a status_code attribute that can be used to check for any errors the API might have reported
```python
import requests, pprint

response = requests.get("http://api.open-notify.org/astros.json")
if (response.status_code == 200):
    print("The request was a success!")
    # Code here will only run if the request is successful
    pprint.pprint(response.json())
elif (response.status_code == 404):
    print("Result not found!")
    # Code here will react to failed requests
```
To see this in action, try removing the last letter from the URL endpoint, the API should return a 404 status code.

#### Getting the sequence for ENSG00000157764
```python
import requests, sys

server = "http://rest.ensembl.org"
endpoint = "/sequence/id/"
gene = "ENSG00000157764"

r = requests.get(f"{server}{endpoint}{gene}", headers={ "Content-Type" : "text/plain"})

print(r.text) 
```

#### Getting the lastest version info about gene ENSG00000157764
```python
import requests, sys
import pprint

server = "http://rest.ensembl.org"
gene = "ENSG00000157764"
get_gene_info_endpoint = f"/archive/id/{gene}"

response = requests.get(f"{server}{get_gene_info_endpoint}", 
            headers={ "Content-Type" : "application/json"})

res_dic = response.json()
result = json.dumps(res_dic, indent = 2)
print(result)
```

#### Using parameters
#### Getting info for several genes:
ENSG00000157764 <br>
ENSG00000248378
```python
import requests, sys
import pprint

server = "http://rest.ensembl.org"
ext = "/archive/id/"
genes = '{"id":["ENSG00000157764","ENSG00000248378"]}'
headers={ "Content-Type" : "application/json"}

response = requests.post(f"{server}{ext}", headers=headers, data=genes)

if not r.ok:
  r.raise_for_status()
  sys.exit()

# res_dic = response.json()
# result = json.dumps(res_dic, indent = 2)
# print(result) 
pprint.pprint(response.json())

```

#### To get the gene tree for the gene ENSGT00390000003602 of a cow, including its DNA sequence:
```python
# GET genetree/id/:id

import requests, sys
import pprint

server = "http://rest.ensembl.org"
gene = "ENSGT00390000003602"
endpoint_gene = f"/genetree/id/{gene}"

headers={ "Content-Type" : "application/json"}
parameters = {'prune_species': 'cow', 'sequence': 'cdna'}

response = requests.get(f"{server}{endpoint_gene}", 
           params=parameters, headers=headers)

if not r.ok:
  r.raise_for_status()
  sys.exit()

pprint.pprint(response.json())
```

#### Write a program to generate a list with the taxon ids of all the vertebrates included in the Ensembl database
```python
# GET info/species

import requests, sys
import pprint

server = "http://rest.ensembl.org"
endpoint = "/info/species"
parameters = { "division" : "EnsemblVertebrates" }

headers={ "Content-Type" : "application/json"}

response = requests.get(f"{server}{endpoint}", params=parameters, headers=headers)

if response.ok:
  decoded = response.json()['species']

  # Print each taxon_id
  for s in decoded:
    print(s['taxon_id'])

pprint.pprint(response.json())

```

#### Write a program to list the common names of the specie with taxon_id = 10091
```python
# Exercise 2. Write a program to list the common names of the specie with taxon_id = 10091
import requests, sys, pprint

server = "https://rest.ensembl.org"
ext = "/info/species?"
taxon_id = 9598

def search_taxon(l, taxon_id):

  for i in l:
      if int(i['taxon_id']) == taxon_id:
        return i['common_name']

  return None

# Set parameters
division_params = {'division': 'EnsemblVertebrates'}

response = requests.get(server+ext, params = division_params, headers={"Content-Type" : "application/json"})

if response.ok:
    decoded_list = response.json()['species']

    # Search for the appropiate taxon_id
    result = search_taxon(decoded_list, taxon_id)
    print(result)
```

#### How many species are included in the Ensemble database?
```python
# **Exercise 3**. How many species are included in the Ensemble database?
import requests, sys, pprint

server = "https://rest.ensembl.org"
ext = "/info/species?"

def search_taxon(l, taxon_id):

  for i in l:
      if int(i['taxon_id']) == taxon_id:
        return i['common_name']

  return None

# Set parameters
division_params = {'division': 'EnsemblVertebrates'}

response = requests.get(server+ext, params = division_params, headers={"Content-Type" : "application/json"})

if response.ok:
    decoded_list = response.json()['species']

    # The total species is the number of elements of the list
    num_species = len(decoded_list)

    # Search for the appropiate taxon_id
    print(f"There are {num_species} species in the database")
```

#### Write a program to list the name of all the analyses involved in generating Ensembl data for humans, and save it to a file name 'analyses.txt'
```python
import requests, sys, pprint

server = "https://rest.ensembl.org"
ext = "/info/analysis/homo_sapiens?"

r = requests.get(server+ext, headers={ "Content-Type" : "application/json"})

if not r.ok:
  r.raise_for_status()
  sys.exit()

decoded = r.json()

with open ('analyses.txt', 'w') as analysis_file:
  pprint.pprint(decoded)
  analysis_file.write(repr(decoded))
```

#### Write a program to generate a file, named 'ENSG00000157764.txt', which contains the DNA sequence for this identifier, and prints the total number of bases, and the number for each type. 

The output must be similar to:<br>
File 'ENSG00000157764.txt' successfully written.<br>
Total number of bases: 234234<br>
Number of 'A' bases: 345<br>
Number of 'C' bases: 345<br>
Number of 'G' bases: 345<br>
Number of 'T' bases: 345<br>

```python
import requests, sys

server = "https://rest.ensembl.org"
ext = "/sequence/id/ENSG00000157764?"
file_name = "ENSG00000157764.txt"

response = requests.get(server+ext, headers={ "Content-Type" : "text/plain"})

if response.ok:
  sequence = response.text

  with open(f"{file_name}", 'w') as gene_line:
      gene_line.write(sequence)
  print(f"File '{file_name}' successfully written.")
  print(f"Total number of bases: {len(sequence)}")
  print(f"Number of 'A' bases: {sequence.count('A')}")
  print(f"Number of 'C' bases: {sequence.count('C')}")
  print(f"Number of 'G' bases: {sequence.count('G')}")
  print(f"Number of 'T' bases: {sequence.count('T')}")
```

#### Ejercicio 1.
Implementa una función write_dna_sequece que recupere de rest.ensembl.org y escriba en un fichero, cuyo nombre se reciba como parámetro, la secuencia ADN de un identificador dado. Adicionalmente, si se especifica un parámetro opcional a la función denominado 'analysis' y éste tiene el valor True, la función deben imprimir también por pantalla el número total de bases, así como el número de cada una de ellas. La salida debe ser similar a la siguiente:

File 'dna_sequence.txt' successfully written. <br>
Total number of bases: 205603<br>
Number of 'A' bases: 60015<br>
Number of 'C' bases: 37965<br>
Number of 'G' bases: 40168<br>
Number of 'T' bases: 67455<br>

Para la implementación de la función, puedes utilizar el siguiente endpoint:
- GET /sequence/id/:id recupera secuencias por identificador. <br>
cuya documentación se muestra más abajo. No es necesario el uso de parámetros opcionales del endpoint.

![image](https://github.com/user-attachments/assets/08402d87-1a96-45ec-b30b-d3827bde7847)
```python
import requests
def write_dna_sequence(DNA_id, file_name, analysis = False):
    """Función que obtiene la secuencia de Ensembl y la escribe en un fichero.
    Input Parameters
    ----------------------
    DNA_id: str
    ID de la secuencia que se quiere guardar
    file_name: str
    nombre del fichero en el que se quiere guardar la secuencia
    analysis: bool
    Parámetro que imprime la cantidad total de bases y el número de
    bases de cada nucleótido cuando True (por defecto).
    """
server = "rest.ensembl.org/"
endpoint = f"sequence/id/{DNA_id}"

response = requests.get(f"{server}{endpoint}", headers ={"Content-type":"application/text"})

if response.ok:
    dna_sequence = response.text
    with open(file_out, "w") as f:
        f.write(dna_sequence)
    print(f"File {file_out} successfully written.")

    if analysis:
        print(f"Total number of bases: {len(dna_sequence)}")
        for nucleotide in "ATCG":
            print(f"Number of {nucleotide} bases:
                {dna_sequence.count(nucleotide)}")
else:
    print("Se ha producido un error")
```


#### Ejercicio 2. 
El siguiente programa tiene como objetivo obtener la información de la versión más reciente de un gen específico. Desafortunadamente, no funciona como se espera. Señala y explica todos los errores, y escribe una versión corregida.
```python
import requests, sys, json
import pprint

server = "http://rest.ensembl.org"
gene = "ENSG00000157764"
get_gene_info_endpoint = f"/overlap/id/{gene}?feature=gene"
r = requests.get(f"{server}{get_gene_info_endpoint}")

if r.ok:
    r.raise_for_status()
    sys.exit()

pprint(r)
```
Primero, la comprobación de la petición está invertida: 

    if r.ok:
        r.raise_for_status()
        sys.exit()

cuando la petición se ha realizado correctamente, queremos continuar con el programa, y cuando ha habido algún error, se quiere apagar el sistema. 

    if not r.ok:
      r.raise_for_status()
      sys.exit()

Además, como importamos el módulo pprint, al llamar a una función dentro de ese módulo se debe utilizar la estructura módulo.función, no solo la función.

Asimismo, como queremos imprimir el contenido de la petición, esto se encuentra dentro de text.

Finalmente, se está importando el módulo json y no se está utilizando. Esto no es un error en sí, solo un warning, pero se puede reemplazar pprint con json.loads(r.text) y un print normal. Así, el código corregido quedaría de la siguiente forma:
```python
import requests, sys, json
import pprint

server = "http://rest.ensembl.org"
gene = "ENSG00000157764"
get_gene_info_endpoint = f"/overlap/id/{gene}?feature=gene"
r = requests.get(f"{server}{get_gene_info_endpoint}")

if not r.ok: #r.ok == False
    r.raise_for_status()
    sys.exit()

pprint.pprint(r.text)

##Alternativa
r_dict = json.loads(r.text)
print(r_dict)
```


```python

```
