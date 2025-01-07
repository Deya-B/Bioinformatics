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
The GET method indicates that you’re trying to get or retrieve data from a specified resource.<br>
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
In this example, you’ve captured the return value of `get()`, which is an instance of `Response`, and stored it in a variable called `response`.

You can now use response to see a lot of information about the results of your GET request.

> **Status Codes**:
>
> The first bit of information that you can gather from Response is the status code. A status code informs you of the status of the request.
>
> For example:
> - a 200 OK status means that your request was successful,
> - whereas a 404 NOT FOUND status means that the resource you were looking for wasn’t found.
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
> If you want to use Request’s built-in capacities to raise an exception if the request was **unsuccessful**. You can do this using `.raise_for_status()`:
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
Is possible to construct the URL through an `F-string` by adding the **parameters** in `{}`:

`f'https://www.ebi.ac.uk/ Tools/dbfetch/dbfetch?db=ena_sequence&id=J00 {dna_id} &style=raw'` <br>
In this way is possible add the different dna_id's, such as: 231, 232, 233...

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

| JSON operations | code | function |
|------|------|------|
|To dict | `dict = `**`json.loads(str)`** | Converts a string into a native dictionary |
| To string | `str = `**`json.dumps(dict, indent = x)`** | Converts a dictionary into a string. <br> Optionally, formats output with indent.|
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

```python

```

```python

```

```python

```


```python

```


```python

```

