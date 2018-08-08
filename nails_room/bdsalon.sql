-- 2018-05-31 EJECUTAR EL SCRIPT COMPLETO
-- borramos la base si existe
DROP DATABASE IF EXISTS bdsalon;
-- crear db
CREATE DATABASE IF NOT EXISTS bdsalon;

USE bdsalon;

-- agregando catalogos


CREATE TABLE c_estacion_trabajo(
cl_estacion_trabajo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
ds_descripcion VARCHAR(255),
fg_estatus ENUM('1','0') NOT NULL DEFAULT '1',
orden DECIMAL(9,2),
PRIMARY KEY (cl_venta)
)
ENGINE = InnoDB;

CREATE TABLE c_configuracion(
cl_configuracion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
ds_descripcion VARCHAR(255),
PRIMARY KEY (cl_configuracion)
)
ENGINE = InnoDB;

CREATE TABLE c_estado_venta(
cl_estado_venta integer unsigned not null AUTO_INCREMENT,
ds_descripcion VARCHAR(65) NOT NULL,
PRIMARY KEY(cl_estado_venta)
)
ENGINE = InnoDB;
    
-- 2018-05-26 GTL - TABLA PUESTOS DEL TRABAJADOR
CREATE TABLE c_puesto(
cl_puesto integer unsigned not null AUTO_INCREMENT,
ds_descripcion VARCHAR(65) NOT NULL,
fg_estado ENUM('1','0') NOT NULL DEFAULT '1',
PRIMARY KEY(cl_puesto)
)
ENGINE = InnoDB;

-- tabla clientes 

CREATE TABLE c_cliente(
  cl_cliente INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL DEFAULT '',
  ap_paterno VARCHAR(45),
  ap_materno VARCHAR(45),
  email VARCHAR(45),
  fe_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  tel1 VARCHAR(25),
  tel2 VARCHAR(25),
  direccion VARCHAR(255),
  status ENUM('1','0'),  
  PRIMARY KEY(cl_cliente)   
)
ENGINE = InnoDB;

-- tabla sucursales 
CREATE TABLE c_sucursal(
cl_sucursal INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
ds_descripcion VARCHAR (255) NOT NULL,
direccion VARCHAR (355) NULL,
PRIMARY KEY (cl_sucursal)
)
ENGINE = InnoDB;

-- tabla usuario 
CREATE TABLE c_usuario (
  cl_usuario INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  cl_puesto INTEGER UNSIGNED NOT NULL,
  nombre VARCHAR(45) NOT NULL DEFAULT '',
  ap_paterno VARCHAR(45),
  ap_materno VARCHAR(45),
  email VARCHAR(45),
  password VARCHAR(45),
  fe_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fg_admin ENUM('1','0') NOT NULL DEFAULT '0',
  fg_activo ENUM('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY(cl_usuario),  
  CONSTRAINT fk_cl_puesto FOREIGN KEY fk_cl_puesto (cl_puesto) 
	REFERENCES c_puesto(cl_puesto)
	ON DELETE CASCADE
    ON UPDATE CASCADE 
 )
ENGINE = InnoDB;



-- Tabla Inventarios
CREATE TABLE c_articulo(
cl_articulo INTEGER unsigned NOT NULL AUTO_INCREMENT,
fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
descripcion VARCHAR(255) NOT NULL,
unidad_medida VARCHAR(20),
cantidad_entrada DECIMAL(9,2) NOT NULL,
cantidad_salida DECIMAL(9,2),
precio_venta DECIMAL(9,2),
cantidad_existente DECIMAL(9,2),
es_producto ENUM('1','0') NOT NULL DEFAULT '1',
fg_estatus ENUM('1','0') NOT NULL DEFAULT '1',
PRIMARY KEY(cl_articulo)
)
ENGINE = InnoDB;
					
-- 2018.05.22 GTL Tabla Ventas 
CREATE TABLE c_venta(
cl_venta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
fe_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
cl_cliente INTEGER UNSIGNED NOT NULL,
cl_usuario INTEGER UNSIGNED NOT NULL,
cl_estado_venta INTEGER UNSIGNED NOT NULL,
ds_descripcion VARCHAR(255),
PRIMARY KEY (cl_venta),
CONSTRAINT fk_venta_cl_cliente FOREIGN KEY fk_venta_cl_cliente (cl_cliente) 
	REFERENCES c_cliente(cl_cliente)
	ON DELETE CASCADE
    ON UPDATE CASCADE,    
CONSTRAINT fk_venta_cl_usuario FOREIGN KEY fk_venta_cl_usuario (cl_usuario) 
	REFERENCES c_usuario(cl_usuario)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_estatus_venta FOREIGN KEY fk_cl_estatus_venta (cl_estado_venta) 
	REFERENCES c_estado_venta(cl_estado_venta)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- 2018.05.22 GTL DETALLE DE VENTA
CREATE TABLE k_detalle_venta(
cl_detalle_venta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_venta INTEGER UNSIGNED NOT NULL,
cl_articulo INTEGER UNSIGNED NOT NULL,
cantidad INTEGER NOT NULL,
precio_articulo DECIMAL(9,2),
PRIMARY KEY (cl_detalle_venta),
CONSTRAINT fk_cl_venta FOREIGN KEY fk_cl_venta (cl_venta) 
	REFERENCES c_venta(cl_venta)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_articulo FOREIGN KEY fk_cl_articulo (cl_articulo) 
	REFERENCES c_articulo(cl_articulo)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;


CREATE TABLE c_caja(
cl_caja INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_usuario INTEGER UNSIGNED NOT NULL,
fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fecha_cierre TIMESTAMP NULL,
fg_estatus ENUM('1','0') NOT NULL DEFAULT '1',
ds_descripcion VARCHAR(255),
PRIMARY KEY (cl_caja),
CONSTRAINT fk_cl_usuario FOREIGN KEY fk_cl_usuario (cl_usuario) 
	REFERENCES c_usuario(cl_usuario)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE k_detalle_caja(
cl_detalle_caja INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_caja INTEGER UNSIGNED NOT NULL,
es_ingreso  ENUM('1','0') NOT NULL DEFAULT '1',
monto DECIMAL(9,2),
ds_descripcion VARCHAR(255),
PRIMARY KEY (cl_detalle_caja),
CONSTRAINT fk_cl_detalle_caja FOREIGN KEY fk_cl_detalle_caja (cl_caja) 
	REFERENCES c_caja(cl_caja)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;



-- FIN DEL SCRIPT

INSERT INTO c_usuario (cl_puesto,cl_sucursal,nombre,ap_paterno,ap_materno,email,password,fg_admin,fg_activo) VALUES ('1','1','Gerardo','Torreblanca','Luna','gtorre@email.com','123456','1','1');

INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Registrado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Cancelado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Autorizado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Archivado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Entregado');

INSERT INTO c_puesto (ds_descripcion) VALUES ('administrador');
INSERT INTO c_puesto (ds_descripcion) VALUES ('vendedor');
INSERT INTO c_puesto (ds_descripcion) VALUES ('chofer');
INSERT INTO c_puesto (ds_descripcion) VALUES ('proveedor');
