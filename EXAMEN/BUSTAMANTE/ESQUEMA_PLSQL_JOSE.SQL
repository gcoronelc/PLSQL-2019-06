-- =============================================
-- CRACIÓN DE LA APLICACIÓN
-- =============================================

DECLARE
	N INT;
	COMMAND VARCHAR2(200);
BEGIN
	COMMAND := 'DROP USER plsql CASCADE';
	SELECT COUNT(*) INTO N
	FROM DBA_USERS
	WHERE USERNAME = 'plsql5';
	IF ( N = 1 ) THEN
		EXECUTE IMMEDIATE COMMAND;
	END IF;
END;
/

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER plsql5 IDENTIFIED BY oracle;




GRANT CONNECT, RESOURCE TO plsql5;

ALTER USER plsql5
QUOTA UNLIMITED ON USERS;

GRANT CREATE VIEW TO plsql5


-- =============================================
-- CONECTARSE A LA APLICACIÓN
-- =============================================

CONNECT plsql5/oracle

-- =============================================
-- CREACIÓN DE LOS OBJETOS DE LA BASE DE DATOS
-- =============================================


CREATE TABLE T_Cliente (
Cliente_Id number NOT NULL,
Cliente_Cod CHAR ( 10 ) NOT NULL,
Nombre VARCHAR ( 50 ) NOT NULL,
Apellidos VARCHAR ( 50 ) NOT NULL,
Sexo CHAR(1) CHECK ((Sexo = 'M') OR (Sexo = 'F')),
FechaNacimiento DATE,
Telefono VARCHAR ( 12 )  ,
Email NVARCHAR2 ( 100 )  ,
  Estado CHAR(1) CHECK ((Estado = 'A') OR (Estado = 'I')), 
  Direccion NVARCHAR2 ( 100 ) ,
  idDepa  number ,
  idProv  number ,
  idDist  number ,
  primary key (Cliente_Id)
  );
  
  CREATE TABLE T_Cuenta (
    Cuenta_ID number  NOT NULL,
    Cliente_Id number NOT NULL,
    Cuenta_Num CHAR ( 12 ) NOT NULL,
    FechaCreacion DATE NOT NULL,
    Saldo number NOT NULL,
    Estado CHAR(1) CHECK ((Estado = 'A') OR (Estado = 'I')), 
    PRIMARY KEY (Cuenta_ID)
  );
  
 CREATE TABLE T_Operacion (
  Operacion_Id number  NOT NULL,
  Cuenta_ID number NOT NULL,
  Fecha DATE NOT NULL,
  Monto NUMBER NOT NULL,
  TipoOperacion_Id number NOT NULL,
  Modalidad_Id number NOT NULL,
  PRIMARY KEY(Operacion_Id)
	);
  
CREATE TABLE T_TipoOperacion (
  TipoOperacion_Id number NOT NULL,
  TipoOperacion char(1) not null,
  Descripcion VARCHAR ( 20 ) NOT NULL,
  PRIMARY KEY (TipoOperacion_Id)
);

CREATE TABLE T_Modalidad(
  Modalidad_Id number NOT NULL,
  Descripcion VARCHAR(20),
  PRIMARY KEY (Modalidad_Id)
);

CREATE TABLE DEPARTAMENTO(
idDepa number not null,
departamento varchar(50) null,
primary key (idDepa)
);

CREATE TABLE DISTRITO(
idDist number not null,
distrito varchar(50) null,
idProv number null,
primary key (idDist)
);

CREATE TABLE PROVINCIA(
idProv number not null,
provincia varchar(50) null,
idDepa number null,
primary key(idProv)
);

-- =============================================
-- CREACIÓN DE LAS LLAVES FORANEAS
-- =============================================

  ALTER TABLE T_Cuenta 
  ADD CONSTRAINT FK_CUENTA_CUENTAID FOREIGN KEY (Cliente_Id)
  REFERENCES T_Cliente (Cliente_Id);
  
  ALTER TABLE T_Operacion
  ADD CONSTRAINT FK_OPERACION_CUENTAID FOREIGN KEY (Cuenta_ID)
  REFERENCES T_Cuenta (Cuenta_ID);
  
    
  ALTER TABLE T_Operacion
  ADD CONSTRAINT FK_OPERACION_TIPOOPERACION FOREIGN KEY (TipoOperacion_Id)
  REFERENCES T_TipoOperacion (TipoOperacion_Id);
  
  ALTER TABLE T_Operacion
  ADD CONSTRAINT FK_OPERACION_MODALIDADID FOREIGN KEY (Modalidad_Id)
  REFERENCES T_Modalidad (Modalidad_Id);
  
  ALTER TABLE T_Cliente
  ADD CONSTRAINT FK_CLIENTE_IDDEPA FOREIGN KEY (idDepa) 
  REFERENCES DEPARTAMENTO (idDepa);
  
  ALTER TABLE T_Cliente
  ADD CONSTRAINT FK_CLIENTE_IDDIST FOREIGN KEY (idDist) 
  REFERENCES DISTRITO (idDist);
  
  ALTER TABLE T_Cliente
  ADD CONSTRAINT FK_CLIENTE_IDPROV FOREIGN KEY (idProv) 
  REFERENCES PROVINCIA (idProv);

ALTER TABLE PROVINCIA
ADD CONSTRAINT FK_PROVINCIA_IDDEPA FOREIGN KEY(idDepa)
REFERENCES DEPARTAMENTO (idDepa);

ALTER TABLE DISTRITO
ADD CONSTRAINT FK_DISTRITO_IDPROV FOREIGN KEY(idProv)
REFERENCES  PROVINCIA (idProv);