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
-- estado = 1 ocupado, estado = 0 libre
fg_estado ENUM('1','0') NOT NULL DEFAULT '1',
-- (OPCIONAL) orden para mostrar en el panel
orden DECIMAL(9,2),
PRIMARY KEY (cl_estacion_trabajo)
)
ENGINE = InnoDB;

CREATE TABLE c_configuracion(
cl_configuracion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
nombre_empresa VARCHAR(255),
direccion_empresa VARCHAR(455),
telefono_uno VARCHAR(55),
telefono_dos VARCHAR(255),
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


CREATE TABLE c_estado_cita(
cl_estado_cita integer unsigned not null AUTO_INCREMENT,
ds_descripcion VARCHAR(65) NOT NULL,
PRIMARY KEY(cl_estado_cita)
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
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  tel1 VARCHAR(25),
  tel2 VARCHAR(25),
  direccion VARCHAR(255),
  fg_activo ENUM('1','0') NOT NULL DEFAULT '1', 
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
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fg_admin ENUM('1','0') NOT NULL DEFAULT '0',
  fg_activo ENUM('1','0') NOT NULL DEFAULT '1',
  comision DECIMAL(9,2),
  PRIMARY KEY(cl_usuario),  
  CONSTRAINT fk_cl_puesto FOREIGN KEY fk_cl_puesto (cl_puesto) 
	REFERENCES c_puesto(cl_puesto)
	ON DELETE CASCADE
    ON UPDATE CASCADE 
 )
ENGINE = InnoDB;

CREATE TABLE c_caja(
cl_caja INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_usuario INTEGER UNSIGNED NOT NULL,
fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fecha_cierre TIMESTAMP NULL,
fg_activo ENUM('1','0') NOT NULL DEFAULT '1',
ds_descripcion VARCHAR(255),
PRIMARY KEY (cl_caja),
CONSTRAINT fk_cl_usuario FOREIGN KEY fk_cl_usuario (cl_usuario) 
	REFERENCES c_usuario(cl_usuario)
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
precio_venta DECIMAL(9,2),
cantidad_existente DECIMAL(9,2),
es_producto ENUM('1','0') NOT NULL DEFAULT '1',
fg_activo ENUM('1','0') NOT NULL DEFAULT '1',
PRIMARY KEY(cl_articulo)
)
ENGINE = InnoDB;
					
-- 2018.05.22 GTL Tabla Ventas 
CREATE TABLE c_venta(
cl_venta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
cl_cliente INTEGER UNSIGNED NOT NULL,
cl_usuario INTEGER UNSIGNED NOT NULL,
cl_caja INTEGER UNSIGNED NOT NULL,
cl_estacion_trabajo INTEGER UNSIGNED NOT NULL,
cl_estado_venta INTEGER UNSIGNED NOT NULL,
ds_descripcion VARCHAR(255),
es_pago_efectivo ENUM('1','0') NOT NULL DEFAULT '1',
es_pago_tarjeta ENUM('1','0') NOT NULL DEFAULT '0',
comision_pagada ENUM('1','0') NOT NULL DEFAULT '0',
PRIMARY KEY (cl_venta),
CONSTRAINT fk_venta_cl_cliente FOREIGN KEY fk_venta_cl_cliente (cl_cliente)
	REFERENCES c_cliente (cl_cliente)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_venta_cl_usuario FOREIGN KEY fk_venta_cl_usuario (cl_usuario)
	REFERENCES c_usuario (cl_usuario)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_estado_venta FOREIGN KEY fk_cl_estado_venta (cl_estado_venta)
	REFERENCES c_estado_venta (cl_estado_venta)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_caja FOREIGN KEY fk_cl_caja (cl_caja) 
	REFERENCES c_caja (cl_caja)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_estacion_trabajo FOREIGN KEY fk_cl_estacion_trabajo (cl_estacion_trabajo)
	REFERENCES c_estacion_trabajo (cl_estacion_trabajo)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- 2018.09.05 
CREATE TABLE c_cita(
cl_cita INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_cliente INTEGER UNSIGNED NOT NULL,
cl_estado_cita INTEGER UNSIGNED NOT NULL,
fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fecha_cita TIMESTAMP NULL,
ds_descripcion VARCHAR(255),
PRIMARY KEY (cl_cita),
CONSTRAINT fk_cita_cl_cliente FOREIGN KEY fk_cita_cl_cliente (cl_cliente)
	REFERENCES c_cliente (cl_cliente)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_estado_cita FOREIGN KEY fk_cl_estado_cita (cl_estado_cita)
	REFERENCES c_estado_cita (cl_estado_cita)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- 2018.05.22 GTL DETALLE DE VENTA
CREATE TABLE k_detalle_venta(
cl_detalle_venta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_venta INTEGER UNSIGNED NOT NULL,
cl_articulo INTEGER UNSIGNED NOT NULL,
cantidad DECIMAL(9,2) NOT NULL,
precio_articulo DECIMAL(9,2),
-- orden entrada, sirve para agrupar el orden en que se agregaron los articulos, 1, 2, 3
orden_entrada INTEGER NOT NULL,
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

ALTER TABLE k_detalle_venta ALTER COLUMN cantidad decimal(9,2)

INSERT INTO c_estado_venta (ds_descripcion) VALUES ('Preventa');
INSERT INTO c_estado_venta (ds_descripcion) VALUES ('Cancelado');
INSERT INTO c_estado_venta (ds_descripcion) VALUES ('Finalizado');

INSERT INTO c_estado_cita (ds_descripcion) VALUES ('Apartado');
INSERT INTO c_estado_cita (ds_descripcion) VALUES ('En proceso');
INSERT INTO c_estado_cita (ds_descripcion) VALUES ('Finalizado');
INSERT INTO c_estado_cita (ds_descripcion) VALUES ('Cancelado');

INSERT INTO c_puesto (ds_descripcion) VALUES ('Administrador');
INSERT INTO c_puesto (ds_descripcion) VALUES ('Mostrador');
INSERT INTO c_puesto (ds_descripcion) VALUES ('Vendedor');
INSERT INTO c_puesto (ds_descripcion) VALUES ('Aplicador');

INSERT INTO c_usuario (cl_puesto,nombre,ap_paterno,ap_materno,email,password,fg_admin,fg_activo) VALUES ('1','admin','admin','admin','admin','123456','1','1');

INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,tel1,tel2,direccion) VALUES ('Gerardo','Torreblanca','Luna','gtorre@email.com','7859621365','5555555555','Calle Juan Aldama 53');


INSERT INTO c_articulo (descripcion,unidad_medida,precio_venta,cantidad_existente) VALUES ('Crema depiladora','PZA',500,10);

INSERT INTO c_estacion_trabajo (ds_descripcion) VALUES ('Isla 1');
INSERT INTO c_estacion_trabajo (ds_descripcion) VALUES ('Isla 2');
INSERT INTO c_estacion_trabajo (ds_descripcion) VALUES ('Isla 3');
INSERT INTO c_estacion_trabajo (ds_descripcion) VALUES ('Isla 4');

INSERT INTO c_configuracion (nombre_empresa,direccion_empresa,telefono_uno,telefono_dos) VALUES ('NAILS ROOM','Abasolo 33, centro, chilpancingo gro','55555555','555555555')

