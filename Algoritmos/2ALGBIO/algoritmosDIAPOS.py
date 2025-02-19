# def euclid_gcD(a, b):
#     while b > 0:
#         # print (a,b)
#         a, b = b, a % b
#     return print(a, b)

# euclid_gcD(2, 1)

###### CAMBIO NORMAL ######
# def change(c):
#     """ 
#     """
#     assert c >= 0, "change for positive ammounts only"

#     l_coin_values = [1, 2, 5, 10, 20, 50, 100, 200]
#     d_change = {}

#     for coin in sorted(l_coin_values)[::-1]:
#         d_change[coin] = c // coin
#         print(c,coin)
#         c = c % coin
#         print(c)
#         if c == 0:
#             break
        
#     return d_change

# print(change(1255))


# ###### DISCOS Hanoi ######
# def hanoi (n_disks, a=1, b=2, c=3):
#     assert n_disks > 0, "n_disks at least 1"

#     if n_disks == 1:
#         print("1.move disk from %d to %d" % (a, b))
#     else:
#         hanoi(n_disks -1, a, c, b) ### El codigo va de aquí a arriba cambiando a, c, b hasta que 
#                                     ## el n_disks se alcanza el 1... entonces se ejecuta el 1.move
#         print("2.move disk from %d to %d" % (a, b)) # Una vez se ejecuta pasa a esta linea y se ejecuta
#         hanoi(n_disks -1, c, b, a)  ## Después se ejecuta éste y va dando vueltas en esto
        
# hanoi(4) # Whatch out how costly is this problem, even for small disk numbers!!


# ###### lINEAR SEARCH ######
# def linear_search(key, l_ints):
#     """..."""
#     for i, val in enumerate(l_ints):
#         print(i, val, key)
#         if val == key:  # KEY OPERATION
#             return print("THe position is:", i+1)
#     return None

# search1 = linear_search(2, [1,4,5,6,2,8,9])
# print(search1)
# search2 = linear_search("ba", ["si", "pi", "mi", "ba", "ra"])
# print(search2)



#### CALCULAR la distancia Euclidea entre puntos con coordenadas (x1, y1) y (x2, y2)
# import math
# def atob (x1, y1, x2, y2):
#     dx = (x2 - x1)**2
#     dy = (y2-y1)**2
#     return (math.sqrt(dx+dy))

# print(atob(0,0,3,4))


##### CALCULAR MAXIMO ##################
# def max(a,b):
#     if a < b:
#         return b
#     else:
#         return a

# a = 500
# print(max(a,105))


######## for loops ##################
# def sumintegers(n):
#     sum = 0
#     for i in range(1,n+1):
#         print(i, sum)
#         sum = sum+i
#     return sum

# print(sumintegers(10))


######## while loops ##################
# def adduntil(b):
#     i = 1
#     total = i
#     while total <= b:
#         print(i,total)
#         i = i + 1
#         total = total + i
#         print(i,total)
#     return i

# print(adduntil(5))


######## array access ##################
# import numpy as np
# a_list=[0,1,2,3,4]
# a1= np.array(a_list)
# print(a1[1:4])


######## ######### ######### #########
# import numpy as np
# dim = 2 + 2
# m = np.array(([dim, dim], [dim, dim],[dim, dim]))
# print(m)


######## Longest common subseq #########

# import numpy as np

# def lcs_matrix(s, t):
#     """
#     A function to create the dynamic programming matrix used to compute the longest common subsequence 
#     between two given strings.

#     Args:
#         seq1: the first sequence
#         seq2: the second sequence

#     Returns:
#         matrix (list): a matrix with the longest common subsequence
#     """
#     matrix = np.zeros((len(s)+1, len(t)+1), dtype = int) # Agrandamos para iniciacion de la matriz en 0's
    
#     for i in range(1, len(s)+1): 
#         for j in range(1, len(t)+1):
#             if s[i-1] == t[j-1]:
#                 matrix[i][j] = matrix[i-1][j-1] + 1
#             else:
#                 matrix[i][j] = max(matrix[i-1][j], matrix[i][j-1])

#     return matrix

# ######## Find the sequence ##################

# def longestCommonSubsequence(s, t):
#     # Time: O(m*n)
#     """
#     Finds the longest common subsequence between two strings using dynamic programming.
#     """

#     matrix = lcs_matrix(s, t)
#     i, j = len(s), len(t)
#     subsequence = []
    
#     while i > 0 and j > 0: # Hasta que llegemos a la primera fila/columna
#         if s[i-1] == t[j-1]:
#             subsequence.append(s[i-1])
#             i -= 1
#             j -= 1
#         elif matrix[i-1][j] > matrix[i][j-1]:  # Mover hacia arriba
#             i -= 1
#         else:  # Mover hacia la izquierda
#             j -= 1
    
#     return ''.join(reversed(subsequence))  # Se invierte la lista porque se llenó al revés


# test_cases = [
#     ("biscuit", "suitcase"),
#     ("bananas", "bahamas"),
#     ("confidential", "trascendental")
# ]

# for s, t in test_cases:
#     print(f"LCS({s}, {t}) = '{longestCommonSubsequence(s, t)}'")


################## Represent functions ##################
# import matplotlib.pyplot as plt

# # filter(function, sequence) # returns a sequence (list, tuple) with the items from sequence for 
# # which function(item) is true

# # Define the function to filter even numbers
# par = lambda x: x % 2 == 0  # lambda is used to define inline simple functions

# # Apply the filter function
# filtered_numbers = list(filter(par, (1, 4, 9, 16, 25)))

# # Plot the filtered numbers
# plt.plot(filtered_numbers, 'bo-', label='Even Numbers') # change the variable to see diff functions
# plt.xlabel('Index')
# plt.ylabel('Value')
# plt.title('Filtered Even Numbers')
# plt.legend()
# plt.grid(True)
# plt.show()

# # map(function, sequence) # calls function(item) for each item in sequence and returns a list with values
# cube = lambda x: x**3
# mapping_cube = list(map(cube, filter(par, range(1,11))))

# # Plot the filtered numbers
# plt.plot(mapping_cube, 'bo-', label='Even Numbers') # change the variable to see diff functions
# plt.xlabel('Index')
# plt.ylabel('Value')
# plt.title('Filtered Even Numbers')
# plt.legend()
# plt.grid(True)
# plt.show()


################## ZIP ##################
## joins serveral lists of the same length in a single list of tuples made of the elements on each list
# l_1 = range(10)
# l_2 = [i*i for i in l_1]

# for a,b in zip(l_1, l_2):
#     print(a * b)

# ## ENUMERATE allows to iterate on a list and its indices:
# for i, sq in enumerate(l_2):
#     print("El cuadrado de {0:2d} es {1:4d}".format(i, sq))


################## DICTIONARIES ##################
# d = {}
# ## 2 ways to add elements
# d.update({"a":"alpha"})
# d["b"]="beta"

# ## keys() > list of key values, values() list of values, items() returns key:value tuples
# print(f"""Keys: {d.keys()}, 
# values {d.values()}, 
# items {d.items()}""")
# for i in d.items():
#     print(i)

# keys=["a","b","c","d","e"]
# values=[1,2,3,4,5]
# ## Dict comprehension:
# mydict = {k:v for (k,v) in zip(keys, values)}
# ## The following can also be used for the same purpose:
# # myDict = dict(zip(keys, values))
# print(mydict)

# numDic = {x: x**2 for x in [1,2,3,4,5]}
# print(numDic)

### NESTED Dict comprehension
## given string
# codon = "ATG"
# dic = {
#     x: {y: x + y for y in codon} for x in codon
# }

# print(dic)

################## PACKING AND UNPACKING ##################
# print([1,2,3,4])
# print(*[1,2,3,4]) # here, the 4 values are passed to print as separate arguments

# ## * can be use to pack also:
# *l_1, = 1,2,3,4 # *variable, = ...
# print(l_1)

# keys=["a","b","c","d","e"]
# values=[1,2,3,4,5]
# ## Dict comprehension:
# mydict1 = {k:v for (k,v) in zip(keys, values)}
# mydict2 = {"f":6, "g":7, "h":8}
# new_dict = {**mydict1, **mydict2}
# print(new_dict)

## Packing function arguments:
# def do_something (*args, **kwargs):
#     for arg in args:
#         print(arg)
#     for key in kwargs:
#         print(key, "=", kwargs[key])

# # equivalent calls
# do_something(1,2,3, a=11, b=22)
# do_something(*(1,2,3), **{"a":11, "b":22})


################## Removing duplicates ##################
# l_1 = [1,2,3,1,2,3]
# l_2 = []
# # evitar lo siguiente
# for item in l_1:
#     if item not in l_2:
#         l_2.append(item)
# print(l_2)

# # más pitónico:
# l_1 = [1,2,3,1,2,3]
# l_2 = list( set (l_1) )
# print(l_2)


################## WORKING WITH FILES ##################
# fName = open("file", "w")
#     ## can also be opened with "r", "a", "b", "t"...
# fName.read(size)    # to read the next size bytes
# fName.read()        # return a STRING with the entire file
# fName.readline()    # return a STRING with the NEXT line
# fName.readlines()   # return a STRING LIST with each of the file lines

# fName.write(string) # write the string in the file
# fName.writelines(s) # write the strings in the list s as file lines

# fName.close()

# ### In python, a file is a sequence of LINES, thus we can loop through it
# fName = open("file", "r"):
# for line in fName:
#     print(line[:-1]) # -1 avoids the final line break


### Seek and tell
## the seek(offset) method resets the file's current position at offset
# f = open("test.txt", "r"); c = 0
# for line in f:
#     c += len(line)
#     print(c)

# f.seek(1) # buscamos a partir de un caracter dado
# for line in f:
#     print(line[:-1])

# ## f.seek(0) is used to rewind the file
# f.seek(0); chunk = 20
# while len(f.read(chunk)) == chunk:
#     print( f.tell() )
# print("file has %d characters" % f.tell() )
# f.close()



##################  ##################
# Write a Python function `pascal_row(k)` that returns the `k`-th row of Pascal's triangle. 
# Assume the single `1` to be the 0-th row.  
# Hint: Make it a recursive function that computes first the previous row `k-1` 
# and uses it to compute the current one.

# def pascal_row(k):
#     """
#     Returns the k-th row of Pascal's Triangle using recursion.
#     """
#     if k == 0:
#         return [1]  # Base case: first row of Pascal's triangle

#     previous_row = pascal_row(k - 1)  # Compute the previous row recursively

#     # Compute the current row using the previous row
#     next_row = [1]  # The first element is always 1
#     for i in range(len(previous_row) - 1):
#         next_row.append(previous_row[i] + previous_row[i + 1])  # Sum adjacent elements
#     next_row.append(1)  # The last element is always 1

#     return next_row  # Return the computed row

# # Testing the function
# for k in range(5):  # Print first 10 rows
#     print(pascal_row(k))



# def pascal_row(k):
#     """
#     Returns the k-th row of Pascal's Triangle using recursion.
#     """
#     if k == 0:
#         return [1]  # Base case: first row of Pascal's triangle

#     previous_row = pascal_row(k - 1)  # Construir recursivamente la fila anterior
    
#     def build_row(prev, i=0): # Cada vez que la llamamos reiniciamos i en 0, para usarla como indice
#         if i == (len(prev)-1):
#             return [] # Parar recursion cuando se consiga el último par
        
#         return ([prev[i] + prev[i+1]] + build_row(prev, i+1))
    
#     return [1]+build_row(previous_row)+[1] 
        
# # Testing the function
# for k in range(10):  # Print first 10 rows
#     print(pascal_row(k))


################## GREEDY ALGORITHM ##################
# A greedy strategy (natural under the circumstances!) is to order the items by 
# descending relative values $\frac{v_i}{w_i}$ and add them to the knapsack until 
# the allowed total weight $W$ is surpassed. Remember that you cannot take cannot 
# take a fraction of an item.

# Write a function `greedy_value(l_weights, l_values, max_weight)` that returns 
# the value of the maximal loot made up of elements with weights in `l_weights` 
# and values in `l_values` that can be carried away in a knapsack which can hold 
# at most a weight `max_weight`. 

def greedy_value(l_weights, l_values, max_weight):
    """
    """
    #### PREGUNTAS:
    ## 1. Lo tenemos q hacer en base al valor relativo, no??
    ## 2. En cada caso mirar la mejor solucion, para ese momenton no?

    # Calculamos el valor relativo de cada item
    rel_val = []
    for v, w in zip(l_values, l_weights):
        rel_val.append(v/w)
    # Añadimos los valores relativos y ordenamos las listas por valor relativo
    values = (zip(l_values, l_weights, rel_val))
    sorted_vals = sorted(values, key=lambda x:x[2], reverse=True) # sort using the 2nd index(0,1,2)
    print(sorted_vals)
    
    # Tenemos v_i, w_i, rv_i por cada item
    # Para el mayor valor relativo, si el weight entra en la saca meter,
    # para el sig valor, si el weight entra meter, sino probar el sig
    # para el sig valor, si el weight entra meter, sino probar el sig más peq

    totalW_added = 0
    totalV_added = 0
    for v, w, _ in sorted_vals:
        if (w + totalW_added) < max_weight:
            totalW_added += w
            totalV_added += v
    return ("Total weight:", totalW_added, "Total value:", totalV_added)


# Testing values
l_values  = [15, 10, 11]
l_weights = [5, 4, 4]
max_weight = 8

print(greedy_value(l_weights, l_values, max_weight))

## More testing
# l_values  = [15, 8, 5]
# l_weights = [10, 1, 2]
# max_weight = 12

# print(greedy_value(l_weights, l_values, max_weight))

##################  ##################




##################  ##################
