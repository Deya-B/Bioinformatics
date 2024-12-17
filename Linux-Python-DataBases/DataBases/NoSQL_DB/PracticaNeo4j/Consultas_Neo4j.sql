Autores: Lucas Mateos Pinilla, Tania Gonzalo Santana, Deyanira Borroto Alburquerque
Practica Neo4j
-----------------------------------------------------------------
CONSULTAS
-----------------------------------------------------------------
A. Nombre de las asignaturas que enseña la profesora Veronica:
MATCH (p:Profesor {nombre:"Veronica"}) - [:Imparte] -> (a:Asignatura) 
RETURN a.nombre AS Asignatura

B. Nombre de asignaturas del primer año:
MATCH (s:Asignatura {curso: 1}) 
RETURN s.nombre AS asignaturas_primer_año

C. Nombre de asignaturas por orden alfabético:
MATCH (a:Asignatura) 
RETURN a.nombre AS asignaturas_alfabeticamente  
ORDER BY a.nombre 

D. Nombre de asignaturas del tercer y el cuarto año:
MATCH (a:Asignatura) 
WHERE a.curso = 3 OR a.curso = 4 
RETURN a.nombre AS asignaturas_curso3y4 

E. Elimina la propiedad semestre del nodo asignaturas:
MATCH (s:Asignatura)  
REMOVE s.semestre 

F. Cambia el nombre de una asignatura:
MATCH (s:Asignatura)  
WHERE s.nombre = 'Bioquimica' SET s.nombre = 'Genetica'  
RETURN s.nombre AS nueva_asignatura 

G. Número de asignaturas en las que el estudiante Daniel está matriculado:
MATCH (e:Estudiante {nombre:"Daniel"}) - [:Matriculado] -> (a:Asignatura) 
RETURN COUNT(a) AS numero_asignaturas_Daniel 

H. Nombres de los amigos de Pedro:
MATCH (e:Estudiante {nombre:"Pedro"}) - [:esAmigo] -> (amigo:Estudiante) 
RETURN amigo.nombre AS amigos_Pedro 

I. Nombres de los amigos de los amigos de Pedro:
MATCH (e:Estudiante {nombre:"Pedro"}) - [:esAmigo] -> (amigo:Estudiante) - [:esAmigo] -> (amigodeamigo:Estudiante) 
RETURN amigodeamigo.nombre AS amigos_de_amigos_de_Pedro 

J. Nombre de las asignaturas en las cuales uno de los amigos del estudiante Maria está matriculado: 
MATCH (e:Estudiante {nombre:"Maria"}) - [:esAmigo] -> (amigo:Estudiante) - [:Matriculado] - 
(a:Asignatura)  
WITH amigo, a 
LIMIT 1 
RETURN amigo.nombre, a.nombre AS nombre_asignaturas 

K. Nombre de los estudiantes que están matriculados en cualquiera de las asignaturas que enseña el Profesor Fernando: 
MATCH (p:Profesor {nombre:"Fernando"}) - [:Imparte] -> (a:Asignatura) <- [:Matriculado] - (e:Estudiante) 
RETURN e.nombre AS estudiante, a.nombre AS asignatura 

L.  Nombres de los estudiantes que están matriculados en cualquiera de las asignaturas que enseña cualquiera de los profesores que trabaja con el Profesor Fernando:
MATCH (p:Profesor {nombre:"Fernando"}) - [:trabajaCon] -> (p2:Profesor) - [:Imparte] -> (a:Asignatura) <- [:Matriculado] - (e:Estudiante) 
RETURN e.nombre AS estudiante 

-----------------------------------------------------------------
CONSULTAS PROPUESTAS Y RESUELTAS:
-----------------------------------------------------------------
a) Profesores que tienen y asignaturas a las que asisten los amigos y amigos remotos de María:
MATCH (e:Estudiante {nombre:"Maria"}) - [a:esAmigo*1..3] -> (amigos_remotos:Estudiante) - [m:Matriculado] - (s:Asignatura) - [i:Imparte] - (p:Profesor) 
RETURN e, a, amigos_remotos, s, p 

b) Listar estudiantes con más de 1 amigo:
MATCH (e:Estudiante) - [r:esAmigo] -> (x:Estudiante)  
WITH e, COUNT(r) AS rel_cnt  
WHERE rel_cnt > 1  
RETURN e.nombre AS estudiante_con_mas_amigos, rel_cnt AS num_amigos 

c) Nota promedio (redondeada) de estudiantes por curso:
MATCH (s:Estudiante)-[r:Matriculado]->(a:Asignatura) 
RETURN a.curso AS Curso, round(AVG(r.nota)) AS NotaPromedio 
ORDER BY Curso
