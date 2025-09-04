-- Autores: Deyanira Borroto Alburquerque, Tania Gonzalo Santana 

------------------------------------ TRIGGER 1------------------------------------------- 
-- Trigger para notificar cada vez que se inserta un nuevo paciente en la tabla Paciente.

-- FUNCIÓN PARA EL TRIGGER
--Eliminar la función si existe:
DROP FUNCTION IF EXISTS informar_paciente_insertado() CASCADE;

-- Creación de la función informar_paciente_insertado():
CREATE OR REPLACE FUNCTION informar_paciente_insertado() 
RETURNS TRIGGER AS $$ 
BEGIN 
    RAISE NOTICE 'Nuevo paciente insertado: Nombre=%, Apellido=%, DNI=%',
    NEW.Nombre, NEW.Apellido, NEW.DNI; 
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 

-- ELIMINACIÓN Y CREACIÓN DEL TRIGGER:
DROP TRIGGER IF EXISTS trigger_informar_paciente_insertado ON Paciente;

CREATE TRIGGER trigger_informar_paciente_insertado 
AFTER INSERT ON Paciente 
FOR EACH ROW 
EXECUTE FUNCTION informar_paciente_insertado();

--VERIFICACION DEL TRIGGER:
--Insertar un nuevo dato en la tabla:
INSERT INTO Paciente (Nombre, Apellido, DNI, Direccion, Telefono, Email, Fecha_nacimiento, Sexo, no_seguridad_social) 
VALUES ('Gemma', 'Gomez', '17895278A', 'Calle Rosales', '555125656', NULL, '1985-01-21', 'F', '123444449'); 

--Salida:
--NOTICE:  Nueva prueba solicitada: Tipo=Análisis de sangre, Departamento=Hematología, Paciente ID=123

------------------------------------ TRIGGER 2------------------------------------------- 
--Trigger para evitar la modificación de la fecha_emision a una fecha futura en la tabla Resultados
-- FUNCIÓN PARA EL TRIGGER
--Eliminar la función si existe:
DROP FUNCTION IF EXISTS verificar_fecha_emision CASCADE;

-- Creación de la función verificar_fecha_emision():
CREATE OR REPLACE FUNCTION verificar_fecha_emision() 
RETURNS TRIGGER AS $$ 
BEGIN 
        IF NEW.fecha_emision > CURRENT_DATE THEN 
        RAISE EXCEPTION 'La fecha_emision no puede ser una fecha futura: %', NEW.fecha_emision; 
    END IF; 
        
    RAISE NOTICE 'VALOR OLD: %', OLD.fecha_emision;
    RAISE NOTICE 'VALOR NEW: %', NEW.fecha_emision;
 
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 

-- ELIMINACIÓN Y CREACIÓN DEL TRIGGER:
DROP TRIGGER IF EXISTS t_verificar_fecha_emision ON Resultado;

CREATE TRIGGER t_verificar_fecha_emision 
BEFORE UPDATE OF fecha_emision ON Resultado
FOR EACH ROW 
EXECUTE FUNCTION verificar_fecha_emision();

--VERIFICACION DEL TRIGGER:
--Ejemplo sin error:
UPDATE Resultado SET fecha_emision = '2023-11-24' WHERE id_resultado = 1;
SELECT * FROM Resultado WHERE id_resultado = 1;
--Ejemplo con error
UPDATE Resultado SET fecha_emision = '2025-01-01' WHERE id_resultado = 1;

------------------------------------ TRIGGER 3------------------------------------------- 
--Crear nueva tabla
CREATE TABLE Log_Cambios ( 
ID_log SERIAL PRIMARY KEY, 
ID_paciente INT NOT NULL,
campo_modificado TEXT NOT NULL, 
valor_anterior TEXT NOT NULL,
valor_nuevo TEXT NOT NULL,
fecha TIMESTAMP DEFAULT NOW()
); 

-- Crear función
CREATE OR REPLACE FUNCTION registrar_cambios_contacto() 
RETURNS TRIGGER AS $$ 
BEGIN 
    IF OLD.telefono IS DISTINCT FROM NEW.telefono OR OLD.email IS DISTINCT FROM NEW.email THEN
        INSERT INTO Log_Cambios (ID_paciente, campo_modificado, valor_anterior, valor_nuevo, fecha) 
        VALUES ( 
        NEW.ID_paciente, 'Contacto', 
            CONCAT('Tel: ', OLD.telefono, ', Email: ', OLD.email), 
            CONCAT('Tel: ', NEW.telefono, ', Email: ', NEW.email), 
            NOW() ); 
    END IF;

RETURN NEW;
END; 
$$ LANGUAGE plpgsql;

--Crear triggers
CREATE TRIGGER registrar_cambios_contacto 
AFTER UPDATE ON Paciente 
FOR EACH ROW 
EXECUTE FUNCTION registrar_cambios_contacto(); 

--VERIFICACION DEL TRIGGER:
--Ejemplo con insercción en la tabla log_comabios:
UPDATE Paciente SET telefono = '126896347', email = 'new@hotmail.com' WHERE ID_paciente = 1; 
SELECT * FROM Paciente WHERE ID_paciente = 1;
SELECT * FROM Log_Cambios WHERE ID_paciente = 1; 
--Ejemplo sin insercción en la tabla log_comabios:
UPDATE Paciente SET nombre = 'Aurora' WHERE ID_paciente = 2;
SELECT * FROM Paciente WHERE ID_paciente = 2;
SELECT * FROM Log_Cambios WHERE ID_paciente = 2; 