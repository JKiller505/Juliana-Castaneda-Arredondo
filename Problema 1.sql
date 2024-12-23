-- GESTIÓN DE DATOS - JULIANA CASTAÑEDA ARREDONDO
-- PROBLEMA 1 

-- Creamos la base de datos
create database problema1;
show databases; 

use problema1;

-- Creación de la tabla de Estudiantes 
CREATE TABLE Estudiantes ( 
ID INT PRIMARY KEY,
Nombre VARCHAR(50)
);

-- Introducimos los datos de la tabla de estudiantes
INSERT INTO Estudiantes (ID, Nombre) VALUES 
(1, 'Manuel'), 
(2, 'Tania'), 
(3, 'Pedro'), 
(4, 'Ana'), 
(5, 'Luis'), 
(6, 'Marta'), 
(7, 'Jorge'), 
(8, 'Clara'), 
(9, 'Pablo'), 
(10, 'Sara'), 
(11, 'David'), 
(12, 'Laura'), 
(13, 'Mario'), 
(14, 'Silvia'), 
(15, 'Carlos'), 
(16, 'Isabel'), 
(17, 'Antonio'), 
(18, 'Elena'), 
(19, 'Francisco'), 
(20, 'Sofía');

SELECT * FROM Estudiantes;

-- Creación de la tabla de Amigos
CREATE TABLE Amigos (
    ID INT PRIMARY KEY,
    ID_Amigo INT,
    FOREIGN KEY (ID) REFERENCES Estudiantes(ID),
    FOREIGN KEY (ID_Amigo) REFERENCES Estudiantes(ID)
);

-- Introducimos los datos de la tabla de amigos
INSERT INTO Amigos (ID, ID_Amigo) VALUES
(1, 1),
(2, 20),
(3, 3),
(4, 12),
(5, 4),
(6, 5),
(7, 1),
(8, 13),
(9, 6),
(10, 12),
(11, 17),
(12, 18),
(13, 19),
(14, 8),
(15, 9),
(16, 15),
(17, 10),
(18, 7),
(19, 10),
(20, 11);

SELECT * FROM Amigos;

-- Creación de la tabla de Salarios
CREATE TABLE Salarios (
    ID INT PRIMARY KEY,
    Salario FLOAT
);

-- Introducimos los datos de la tabla de salarios
INSERT INTO Salarios (ID, Salario) VALUES
(1, 15200.10),
(2, 10060.20),
(3, 11500.50),
(4, 12120.00),
(5, 13200.75),
(6, 9500.40),
(7, 14500.00),
(8, 10300.30),
(9, 16000.00),
(10, 8500.50),
(11, 9000.00),
(12, 17000.75),
(13, 11000.20),
(14, 12500.40),
(15, 13500.10),
(16, 9200.60),
(17, 10100.80),
(18, 11200.90),
(19, 14000.25),
(20, 14500.50);

SELECT * FROM Salarios;



	-- * I)* Consultamos los estudiantes cuyos amigos perciben un ingreso mayor que ellos

SELECT 
-- Seleccionamos los datos de los estudiantes
    e.ID, 
    e.Nombre, 
    s_e.Salario AS Salario_Estudiante, 
    
-- Seleccionamos los datos de los amigos
    a.ID_Amigo, 
    s_a.Salario AS Salario_Amigo
FROM 
    Estudiantes e
JOIN 
    Amigos a ON e.ID = a.ID
JOIN 
    Salarios s_e ON e.ID = s_e.ID
JOIN 
    Salarios s_a ON a.ID_Amigo = s_a.ID

-- Condicional de que el salario del amigo sea mayor al salario del estudiante
WHERE 
    s_a.Salario > s_e.Salario

-- Ordenamos por el salario que ganan los amigos de manera descendente
ORDER BY 
    s_a.Salario DESC;



	-- * II)* Consultar estudiantes cuyos amigos poseen un sueldo mayor al salario promedio de los estudiantes

SELECT 
    e.Nombre, 
    -- Calculamos el promedio del salario de los amigos del estudiante 
    -- (el cual no es tan necesario porque cada estudiante solo tiene un amigo)
    AVG(s_a.Salario) AS Salario_Amigos
    
FROM 
    Estudiantes e
    
-- Relacionamos el ID de cada estudiante con el de sus amigos 
JOIN 
    Amigos a ON e.ID = a.ID

-- Unimos en una misma tabla el ID del amigo y su Salario 
JOIN 
    Salarios s_a ON a.ID_Amigo = s_a.ID

GROUP BY 
    e.ID, e.Nombre

-- Determinamos si el salario del amigo es mayor al salario promedio de los estudiantes
HAVING 
    AVG(s_a.Salario) > (SELECT AVG(Salario) FROM Salarios)

-- Ordenamos el salario promedio que ganan los amigos de manera descendente
ORDER BY 
    Salario_Amigos DESC;

