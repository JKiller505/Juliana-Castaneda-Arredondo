-- GESTIÓN DE DATOS - JULIANA CASTAÑEDA ARREDONDO
-- PROBLEMA 2
-- Desarrolla un datamart anexando los scripts que emplearías.

-- Creamos la base de datos
create database problema2;
show databases; 

use problema2;

-- II) Desarrolla las tablas de un datamart con: Clientes, Productos que oferta, Tipo de cambio, transacciones.

-- Creamos la tabla incluyendo los datos de los CLIENTES
CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY,            	  	 									 -- ID es primary key siendo la clave de identificación de cada cliente
    Nombre VARCHAR(100) NOT NULL,           	 
    Direccion VARCHAR(200) NOT NULL,         	 
    Telefono BIGINT NOT NULL CHECK (Telefono BETWEEN 1000000000 AND 9999999999),	 -- Teléfono como entero de 10 dígitos incluyendo LADA
    Email VARCHAR(100) NOT NULL            	     
);

-- Añadimos los datos de algunos clientes
INSERT INTO Clientes (ID_Cliente, Nombre, Direccion, Telefono, Email) VALUES
(1, 'Juliana Castañeda', 'Calle 548, Ciudad', 5281616158, 'julianacast@gmail.com'),
(2, 'Luis Gerardo', 'Calle 895, Ciudad', 5215358416, 'luisgera@gmail.com'),
(3, 'Juana Arredondo', 'Calle 785, Ciudad', 5281696526, 'juanaarre@gmail.com'),
(4, 'Jose Martinez', 'Calle 269, Ciudad', 5281616302, 'josemar@gmail.com'),
(5, 'Maria Garcia', 'Avenida 456, Ciudad', 5282956221, 'mariagarcia@gmail.com');


-- ------------------------------------------------------------------------
-- Creamos la tabla incluyendo los datos de PRODUCTOS que oferta el banco
CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY,				 				-- ID que identifica de manera única cada producto ofertado
    ID_Cliente INT NOT NULL,									-- ID del cliente como foreign key para relacionarla con la tabla de clientes
    Producto VARCHAR(100) NOT NULL,							    
    Type_Product VARCHAR(50) NOT NULL,							
    Tasa_Interes DECIMAL(5,2) NOT NULL,							-- Válido hasta 5 dígitos y 2 decimales
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)    
);

-- Añadimos los de datos de ejemplo para la tabla Productos
INSERT INTO Productos (ID_Producto, ID_Cliente, Producto, Type_Product, Tasa_Interes) VALUES
(1531031, 1, 'Préstamo Personal', 'Préstamo', 18.75), 
(8566116, 2, 'Cuenta de ahorro', 'Tarjeta', 0.1),
(8126524, 3, 'Préstamo Hipotecario', 'Préstamo', 9.89),
(8666452, 4, 'Crédito educativo', 'Préstamo', 6.45),
(8464632, 5, 'Tarjeta de Crédito', 'Tarjeta', 19.9);


-- ------------------------------------------------------------------------
-- Creamos la tabla incluyendo el TIPO DE CAMBIO
CREATE TABLE TipoCambio (
    ID_TipoCambio INT PRIMARY KEY,				  -- ID del tipo de cambio como llave primaria y única
    ID_Cliente INT NOT NULL,					  -- ID del cliente como foreign key para relacionarla con la tabla de tipo de cambio
	Cantidad_MonedaOrigen int NOT NULL, 		  -- Cantidad de moneda origen a intercambiar. Ejemplo: 10 dólares a pesos mexicanos
    Moneda_Origen VARCHAR(3) NOT NULL,			  
    Moneda_Destino VARCHAR(3) NOT NULL,			  
    Valor_moneda DECIMAL(10, 4) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Añadimos los de datos de ejemplo para la tabla del Tipo de Cambio
INSERT INTO TipoCambio (ID_TipoCambio, ID_Cliente, Cantidad_MonedaOrigen, Moneda_Origen, Moneda_Destino, Valor_moneda, Fecha) VALUES
(1, 4, 50, 'USD', 'MXN', 20.8461, '2024-12-22'),     
(2, 5, 100, 'USD', 'MXN', 20.8461, '2023-06-28'),    
(3, 2, 30, 'EUR', 'USD', 1.2689, '2024-09-05'),      
(4, 1, 200, 'USD', 'MXN', 20.8461, '2024-12-10'),    
(5, 3, 980, 'EUR', 'USD', 1.2689, '2024-03-14');     


-- ------------------------------------------------------------------------
-- Creamos la tabla del HISTORIAL DE TRANSACCIONES de cada cliente 
CREATE TABLE Historial_Transacciones (
    ID_Transaccion INT PRIMARY KEY,								 -- ID de la transacción como llave primaria que nos indica el número de transacción
    ID_Cliente INT NOT NULL,									 -- ID del cliente como foreign key para relacionarla con la tabla de historial de transacciones
    ID_Producto INT NOT NULL,									 -- ID del producto ofertado, proveniente de la tabla de productos
    ID_TipoCambio INT NOT NULL,								     -- ID del tipo de cambio realizado, proveniente de la tabla de tipo de cambio
    Monto DECIMAL(10, 2) NOT NULL,								 -- Monto de la transacción					 
    Fecha DATE NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
    FOREIGN KEY (ID_TipoCambio) REFERENCES TipoCambio(ID_TipoCambio)
);

-- Inserción de datos de ejemplo para Historial_Transacciones
INSERT INTO Historial_Transacciones (ID_Transaccion, ID_Cliente, ID_Producto, ID_TipoCambio, Monto, Fecha) VALUES
(1, 1, 1531031, 1, 5000.00, '2024-12-22'),  
(2, 5, 8464632, 2, 2000.00, '2023-06-28'),  
(3, 2, 8566116, 3, 3000.00, '2024-09-05'),  
(4, 4, 8666452, 4, 1500.00, '2024-12-10'),  
(5, 3, 8126524, 5, 2500.00, '2024-03-14');  

