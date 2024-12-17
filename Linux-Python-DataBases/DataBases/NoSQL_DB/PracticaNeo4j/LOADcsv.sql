Autores: Lucas Mateos Pinilla, Tania Gonzalo Santana, Deyanira Borroto Alburquerque
Practica Neo4j
-----------------------------------------------------------------
LOAD CSV WITH HEADERS FROM "file:/est.csv" AS csvLine 
CREATE (e:Estudiante { id: toInteger(csvLine.id), nombre: csvLine.nombre});

LOAD CSV WITH HEADERS FROM "file:/profesores.csv" AS csvLine 
CREATE (p:Profesor {id: toInteger(csvLine.id), nombre: csvLine.nombre});

LOAD CSV WITH HEADERS FROM "file:/esamigo.csv" AS csvLine 
MATCH(e1:Estudiante),(e2:Estudiante)  
WHERE e1.id= toInteger(csvLine.id1) AND e2.id= toInteger(csvLine.id2)  
CREATE (e1)-[e:esAmigo]->(e2)  
RETURN e; 

LOAD CSV WITH HEADERS FROM "file:/asignaturas.csv" AS csvLine  
CREATE (e:Asignatura { id: toInteger(csvLine.id), nombre: csvLine.nombre, 
curso: toInteger(csvLine.curso), semestre: csvLine.semestre, creditos: 
toInteger(csvLine.creditos)}); 

LOAD CSV WITH HEADERS FROM "file:/imparte.csv" AS csvLine 
MATCH(p:Profesor),(a:Asignatura)  
WHERE p.id= toInteger(csvLine.id1) AND a.id= toInteger(csvLine.id2)  
CREATE (p)-[i:Imparte{aula:csvLine.aula}]->(a)  
RETURN i; 

LOAD CSV WITH HEADERS FROM "file:/matriculado.csv" AS csvLine 
MATCH(e:Estudiante),(a:Asignatura)  
WHERE e.id= toInteger(csvLine.id1) AND a.id= toInteger(csvLine.id2)  
CREATE (e)-[m:Matriculado {nota:toInteger(csvLine.nota)}]->(a) 
RETURN m; 

LOAD CSV WITH HEADERS FROM "file:/trabajacon.csv" AS csvLine 
MATCH(p1:Profesor),(p2:Profesor)  
WHERE p1.id= toInteger(csvLine.id1) ANDp2.id= toInteger(csvLine.id2)  
CREATE (p1)-[t:trabajaCon]->(p2)  
RETURN t; 
-----------------------------------------------------------------
Borrar todo:
MATCH (n) 
DETACH DELETE n

Ver todo:
MATCH (n) 
RETURN n
