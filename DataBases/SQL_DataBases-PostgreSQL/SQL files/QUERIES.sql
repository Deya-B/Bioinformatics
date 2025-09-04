-- Autores: Deyanira Borroto Alburquerque, Tania Gonzalo Santana

--- QUERY 1 - Recuperar pacientes con más de una muestra mayores de 50 años.
SELECT 
    Paciente.Nombre AS nombre_paciente, 
    Paciente.Apellido AS apellido_paciente, 
    EXTRACT(YEAR FROM AGE(Paciente.Fecha_nacimiento)) AS edad,  
    COUNT(DISTINCT Muestra.ID_muestra) AS Numero_Muestras
FROM Paciente
JOIN Prueba ON Paciente.ID_paciente = Prueba.ID_paciente
JOIN Muestra ON Prueba.ID_muestra = Muestra.ID_muestra
WHERE EXTRACT(YEAR FROM AGE(Paciente.Fecha_nacimiento)) > 50
GROUP BY Paciente.Nombre, Paciente.Apellido, Paciente.Fecha_nacimiento
HAVING COUNT(DISTINCT Muestra.ID_muestra) > 1
ORDER BY Numero_Muestras DESC;

--- QUERY 2 - Facturas pendientes de pago con un total a pagar superior a 300.
SELECT Paciente.Nombre AS nombre_paciente, Paciente.Apellido AS apellido_paciente, Factura.Total_pagar AS Pendiente_pago
FROM Paciente
JOIN Prueba ON Paciente.ID_paciente = Prueba.ID_paciente
JOIN Factura ON Prueba.ID_factura = Factura.ID_factura
WHERE Factura.Estado_pago = 'Pendiente' AND Factura.Total_pagar > 300
GROUP BY Paciente.Nombre, Paciente.Apellido, Factura.Total_pagar
ORDER BY Pendiente_pago DESC;

--- QUERY 3 - Obtener el historial de pruebas y resultados de un paciente específico.
SELECT p.Nombre, p.Apellido, pr.Tipo_prueba, r.Fecha_emision, r.Valor_resultado
FROM Paciente p
JOIN Prueba pr ON p.ID_paciente = pr.ID_paciente
JOIN Resultado r ON pr.ID_prueba = r.ID_prueba
WHERE p.DNI = '12113678A'
ORDER BY r.Fecha_emision DESC;

--- QUERY 4 - Importe de las pruebas solicitadas por cada uno de los médicos en la segunda quincena de septiembre de 2024 ordenado por dia.
SELECT m.Nombre AS nombre_medico, 
       TO_CHAR(f.Fecha_emision, 'DD') AS Dia, 
       f.Total_pagar AS importe_por_pruebas_solicitadas
FROM Factura f
JOIN Prueba p ON p.id_factura = f.id_factura
JOIN Medico m ON p.ID_medico = m.ID_medico 
WHERE f.Fecha_emision BETWEEN '2024-09-15' AND '2024-09-30'
GROUP BY m.Nombre, TO_CHAR(f.Fecha_emision, 'DD'), f.Total_pagar
ORDER BY Dia ASC;

--- QUERY 5 - El paciente con más pruebas realizadas a partir de una única muestra que debe mantenerse o bien refrigeradas o bien congeladas.
SELECT p.nombre AS nombre_paciente, 
       m.Tipo_muestra, 
       m.Condiciones_almacenamiento, 
       COUNT(pr.ID_prueba) AS Numero_Pruebas
FROM Muestra m
JOIN Prueba pr ON m.ID_muestra = pr.ID_muestra
JOIN Paciente p ON p.ID_paciente = pr.ID_paciente
WHERE LOWER(m.Condiciones_almacenamiento) LIKE '%refrigerado%' 
   OR LOWER(m.Condiciones_almacenamiento) LIKE '%congelado%'
GROUP BY m.ID_muestra, m.Tipo_muestra, m.Condiciones_almacenamiento, p.nombre
HAVING COUNT(pr.ID_prueba) > 1
ORDER BY Numero_Pruebas DESC
LIMIT 1;

--- QUERY 6 - Obtener el primer médico por apellido junto con su número de pruebas del departamente con más pruebas solicitadas
SELECT m.Nombre AS nombre_medico, 
       m.Apellido AS apellido_medico, 
       COUNT(p.ID_prueba) AS Numero_Pruebas
FROM Medico m
JOIN Prueba p ON m.ID_medico = p.ID_medico
WHERE p.Departamento = (
        SELECT p1.Departamento
        FROM Prueba p1
        GROUP BY p1.Departamento
        ORDER BY COUNT(p1.ID_prueba) DESC
        LIMIT 1)
GROUP BY m.Nombre, m.Apellido
ORDER BY m.Apellido
LIMIT 1;

--- QUERY 7 - Encontrar el promedio de tiempo desde la recogida de muestra hasta la emision de resultado por tipo de muestra
SELECT m.Tipo_muestra, 
    FLOOR(AVG(EXTRACT(EPOCH FROM (r.Fecha_emision - m.Fecha_obtencion)) / 86400)) AS Promedio_Dias,
    FLOOR(AVG(EXTRACT(EPOCH FROM (r.Fecha_emision - m.Fecha_obtencion)) % 86400) / 60) AS Promedio_Minutos
FROM Muestra m
JOIN Prueba pr ON m.ID_muestra = pr.ID_muestra
JOIN Resultado r ON pr.ID_prueba = r.ID_prueba
WHERE m.Tipo_muestra IS NOT NULL
GROUP BY m.Tipo_muestra;

--- QUERY 8 - Encontrar los pacientes cuyo resultado más reciente es anormal y se le ha realizado mas de una prueba
SELECT DISTINCT Paciente.Nombre AS nombre_paciente, 
                Paciente.Apellido AS apellido_paciente, 
                Resultado.Valor_resultado,
                Resultado.Valor_normal,
                Resultado.Fecha_emision
FROM Paciente
JOIN Prueba ON Paciente.ID_paciente = Prueba.ID_paciente
JOIN Resultado ON Prueba.ID_prueba = Resultado.ID_prueba
WHERE Resultado.Fecha_emision = (
        SELECT MAX(R.Fecha_emision)
        FROM Resultado R
        JOIN Prueba P ON R.ID_prueba = P.ID_prueba
        WHERE P.ID_paciente = Paciente.ID_paciente)
AND Resultado.Valor_resultado <> Resultado.Valor_normal
AND Paciente.ID_paciente IN (
        SELECT ID_paciente
        FROM Prueba
        GROUP BY ID_paciente
        HAVING COUNT(ID_prueba) > 1)
ORDER BY Paciente.Apellido;

--- QUERY 9 - Encontrar los médicos que han solicitado pruebas para pacientes que tienen más de una prueba con resultados anormales
WITH Pacientes_Anormales AS (
    SELECT Paciente.ID_paciente, COUNT(Resultado.ID_resultado) AS Numero_Resultados_Anormales
    FROM Paciente
    JOIN Prueba ON Paciente.ID_paciente = Prueba.ID_paciente
    JOIN Resultado ON Prueba.ID_prueba = Resultado.ID_prueba
    WHERE Resultado.Valor_resultado <> Resultado.Valor_normal
    GROUP BY Paciente.ID_paciente
    HAVING COUNT(Resultado.ID_resultado) > 1
)
SELECT Medico.Nombre AS nombre_medico, Medico.Apellido AS apellido_medico, COUNT(DISTINCT Pacientes_Anormales.ID_paciente) AS Numero_Pacientes
FROM Medico
JOIN Prueba ON Medico.ID_medico = Prueba.ID_medico
JOIN Pacientes_Anormales ON Prueba.ID_paciente = Pacientes_Anormales.ID_paciente
GROUP BY Medico.Nombre, Medico.Apellido
ORDER BY apellido_medico;
