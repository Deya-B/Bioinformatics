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
      - For example in this type of form https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw instead of filling it many times, we would want to change the value of the arguments `id=J00231, id=J00232, id=J00233, db=afdb` etc.
        > Note: Path and query will require you to know the server´s API
    
4. Direct HTTP requests: we could do this through Python requests library. We use the URLs of the servers with methods like `GET` and `POST`.

5. Specific API usage: Always the best option (if available). There are some systems that provide their server API to use them from Python. These are known as high level APIs or SDKs. These API REST are not available for all systems. They are very encapsulated, so they do not use URLs, GET or POST.

## Programmatic access to forms:
A lot of libraries available in Python to automate the access and processing
of URLs:
- urllib: low-level access, more adequate for network programming
- requests: very easy to use, a lot of documentation and examples

Python requests library has one of the most common HTTP methods, the `GET` command.
```Nushell
# En el terminal install the requests library
sudo apt-get install python3-requests
# or
pip install requests
```

```python
import requests

url = 'https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231&style=raw'
response = requests.get(url)

print(response.text)
```

