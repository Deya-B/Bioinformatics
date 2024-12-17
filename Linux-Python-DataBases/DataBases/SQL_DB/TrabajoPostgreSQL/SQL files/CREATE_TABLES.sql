--Autores: Deyanira Borroto Alburquerque, Tania Gonzalo Santana 
-- Código SQL para creación de tablas Base de Datoa Pruebas Hospitalarias

--Tabla Paciente (ID_paciente, Nombre, Apellido, DNI, Direccion, Telefono, Email, Fecha_nacimiento, Sexo, no_seguridad_social)
CREATE TABLE Paciente (
    ID_paciente SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI VARCHAR(9) UNIQUE NOT NULL,
    Direccion VARCHAR(100),
    Telefono CHAR(9),
    Email VARCHAR(100),
    Fecha_nacimiento DATE,
    Sexo CHAR(1),
    no_seguridad_social VARCHAR(20),
    CHECK (Telefono IS NOT NULL OR Email IS NOT NULL)
);

-- Tabla Factura (ID_factura, Fecha_emision, Total_pagar, Estado_pago)
CREATE TABLE Factura (
    ID_factura SERIAL PRIMARY KEY,
    Fecha_emision DATE,
    Total_pagar DECIMAL(10, 2) NOT NULL,
    Estado_pago VARCHAR(20) NOT NULL
	);

-- Tabla Muestra (ID_muestra, Fecha_obtencion, Sitio_recogida, Tipo_muestra, Condiciones_almacenamiento)
CREATE TABLE Muestra (
    ID_muestra SERIAL PRIMARY KEY,
    Fecha_obtencion TIMESTAMP,
    Sitio_recogida VARCHAR(20),
    Tipo_muestra VARCHAR(50),
    Condiciones_almacenamiento VARCHAR(100)
	);

-- Tabla Medico (ID_medico, Nombre, Apellido ,no_colegiado, Telefono, Email, Especialidad)
CREATE TABLE Medico (
    ID_medico SERIAL PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    no_colegiado VARCHAR(20) UNIQUE NOT NULL,
    Telefono CHAR(9),
    Email VARCHAR(100),
    Especialidad VARCHAR(50)
	);

-- Tabla Prueba (ID_prueba, no_colegiado, Tipo_prueba, Departamento, ID_factura, ID_paciente, ID_muestra, ID_medico)
CREATE TABLE Prueba (
    ID_prueba SERIAL PRIMARY KEY,
	Tipo_prueba VARCHAR(50),
    Departamento VARCHAR(50), 
	ID_factura INTEGER REFERENCES Factura(ID_factura) NOT NULL,
    ID_paciente INTEGER REFERENCES Paciente(ID_paciente) NOT NULL,
    ID_muestra INTEGER REFERENCES Muestra(ID_muestra) NOT NULL,
    ID_medico INTEGER REFERENCES Medico(ID_medico) NOT NULL
	);

-- Resultado (ID_resultado, Fecha_emision , Emisor_responsable , Valor_normal, Valor_resultado, ID_prueba)
CREATE TABLE Resultado (
    ID_resultado SERIAL PRIMARY KEY,
    Fecha_emision TIMESTAMP,
    Emisor_responsable VARCHAR(50) NOT NULL,
    Valor_normal VARCHAR(50),
    Valor_resultado VARCHAR(50) NOT NULL, 
	ID_prueba INTEGER REFERENCES Prueba(ID_prueba) NOT NULL
	);

-- Observación de las tablas creadas para verificar que se han creado crrectamente
SELECT * FROM Paciente;
SELECT * FROM Factura;
SELECT * FROM Resultado;
SELECT * FROM Prueba;
SELECT * FROM Medico;
SELECT * FROM Muestra;
