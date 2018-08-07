-- 2018-05-31 EJECUTAR EL SCRIPT COMPLETO
-- borramos la base si existe
DROP DATABASE IF EXISTS bdsalon;
-- crear db
CREATE DATABASE IF NOT EXISTS bdsalon;

USE bdsalon;

-- agregando catalogos

CREATE TABLE c_estatus_venta(
cl_estatus_venta integer unsigned not null AUTO_INCREMENT,
ds_descripcion VARCHAR(65) NOT NULL,
PRIMARY KEY(cl_estatus_venta)
)
ENGINE = InnoDB;

-- 2018-05-26 GTL - TABLA PUESTOS DEL TRABAJADOR
CREATE TABLE c_puesto(
cl_puesto integer unsigned not null AUTO_INCREMENT,
ds_descripcion VARCHAR(65) NOT NULL,
fg_activo ENUM('1','0') NOT NULL DEFAULT '1',
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
  fg_activo ENUM('1','0') NOT NULL DEFAULT '1',  
  PRIMARY KEY(cl_cliente)  
   
)
ENGINE = InnoDB;

-- tabla sucursales 
CREATE TABLE c_sucursal(
cl_sucursal INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
nombre VARCHAR (40) NOT NULL,
rfc VARCHAR (40) NOT NULL,
calle varchar(45),
CP VARCHAR (5),
colonia VARCHAR(50),
municipio VARCHAR(70),
estado VARCHAR(50),
t_fijo VARCHAR (12),
t_secundario VARCHAR (12),
PRIMARY KEY (cl_sucursal)
)
ENGINE = InnoDB;

-- tabla usuario 
CREATE TABLE c_usuario (
  cl_usuario INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  cl_puesto INTEGER UNSIGNED NOT NULL,
  cl_sucursal INTEGER UNSIGNED NOT NULL,
  nombre VARCHAR(45) NOT NULL DEFAULT '',
  ap_paterno VARCHAR(45),
  ap_materno VARCHAR(45),
  email VARCHAR(45),
  password VARCHAR(45),
  fe_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  comision DECIMAL(9,2),
  fg_admin ENUM('1','0') NOT NULL DEFAULT '0',
  fg_activo ENUM('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY(cl_usuario),  
  CONSTRAINT fk_cl_puesto FOREIGN KEY fk_cl_puesto (cl_puesto) 
	REFERENCES c_puesto(cl_puesto)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
 CONSTRAINT fk_cl_sucursal FOREIGN KEY fk_cl_sucursal (cl_sucursal) 
	REFERENCES c_sucursal(cl_sucursal)
	ON DELETE CASCADE
    ON UPDATE CASCADE 
 )
ENGINE = InnoDB;

-- Tabla inventarios
CREATE TABLE c_articulo(
cl_articulo INTEGER unsigned NOT NULL AUTO_INCREMENT,
fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
cl_almacen INTEGER UNSIGNED NOT NULL,
cl_color INTEGER UNSIGNED NOT NULL,
descripcion VARCHAR(80) NOT NULL,
unidad_medida VARCHAR(20),
cantidad_entrada DECIMAL(9,2) NOT NULL,
cantidad_salida DECIMAL(9,2),
precio_venta DECIMAL(9,2),
cantidad_existente DECIMAL(9,2),
fg_estatus ENUM('1','0') NOT NULL DEFAULT '1',
PRIMARY KEY(cl_articulo)
)
ENGINE = InnoDB;
					
-- 2018.05.22 GTL Tabla ventas 
CREATE TABLE c_venta(
cl_venta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
fe_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
cl_cliente INTEGER UNSIGNED NOT NULL,
cl_usuario INTEGER UNSIGNED NOT NULL,
cl_sucursal INTEGER UNSIGNED NOT NULL,
cl_estatus_venta INTEGER UNSIGNED NOT NULL,
ds_descripcion VARCHAR(100),
PRIMARY KEY (cl_venta),
CONSTRAINT fk_cl_cliente FOREIGN KEY fk_cl_cliente (cl_cliente) 
	REFERENCES c_cliente(cl_cliente)
	ON DELETE CASCADE
    ON UPDATE CASCADE,    
CONSTRAINT fk_venta_cl_sucursal FOREIGN KEY fk_venta_cl_sucursal (cl_sucursal) 
	REFERENCES c_sucursal(cl_sucursal)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_usuario FOREIGN KEY fk_cl_usuario (cl_usuario) 
	REFERENCES c_usuario(cl_usuario)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_cl_estatus_venta FOREIGN KEY fk_cl_estatus_venta (cl_estatus_venta) 
	REFERENCES c_estatus_venta(cl_estatus_venta)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- 2018.05.22 GTL DETALLE DE VENTA
CREATE TABLE k_detalle_venta(
cl_detalle_venta INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_venta INTEGER UNSIGNED NOT NULL,
cl_articulo INTEGER UNSIGNED NOT NULL
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
cl_usuario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fe_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fe_cierre TIMESTAMP NULL,
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
ingreso DECIMAL(9,2),
monto DECIMAL(9,2),
ds_descripcion VARCHAR(155),
PRIMARY KEY (cl_detalle_caja),
CONSTRAINT fk_cl_caja FOREIGN KEY fk_cl_caja (cl_caja) 
	REFERENCES c_caja(cl_caja)
	ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE c_estacion_trabajo(
cl_estacion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
ds_descripcion VARCHAR(80) NULL,
fg_estatus ENUM('1','0') NOT NULL DEFAULT '1',
orden DECIMAL(9,2),
ds_descripcion VARCHAR(80) NOT NULL,
PRIMARY KEY (cl_estacion)
)
ENGINE = InnoDB;

CREATE TABLE c_configuracion(
cl_configuracion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
cl_sucursal INTEGER UNSIGNED NOT NULL,
ds_descripcion VARCHAR(80) NULL,
fg_estatus ENUM('1','0') NOT NULL DEFAULT '1',
PRIMARY KEY (cl_configuracion)
)
ENGINE = InnoDB;

-- FIN DEL SCRIPT

-- valores para la configuracion inicial
INSERT INTO c_configuracion (1,'Informacion inicial ')

-- valores para estado de la venta
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Registrado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Cancelado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Autorizado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Archivado');
INSERT INTO c_estatus_venta (ds_descripcion) VALUES ('Entregado');

-- valores para el iventario
INSERT INTO c_articulo (cl_almacen,cl_color,descripcion,unidad_medida,cantidad_entrada,precio_venta,cantidad_existente,fg_estatus) VALUES ('2','1','sala_2','pieza',600,22000,500,'1');
INSERT INTO c_articulo (cl_almacen,cl_color,descripcion,unidad_medida,cantidad_entrada,precio_venta,cantidad_existente,fg_estatus) VALUES ('2','2','sala_3','pieza',600,22000,500,'1');
INSERT INTO c_articulo (cl_almacen,cl_color,descripcion,unidad_medida,cantidad_entrada,precio_venta,cantidad_existente,fg_estatus) VALUES ('2','1','sala_4','pieza',600,22000,500,'1');
INSERT INTO c_articulo (cl_almacen,cl_color,descripcion,unidad_medida,cantidad_entrada,precio_venta,cantidad_existente,fg_estatus) VALUES ('2','1','sala_5','pieza',600,22000,500,'1');
INSERT INTO c_articulo (cl_almacen,cl_color,descripcion,unidad_medida,cantidad_entrada,precio_venta,cantidad_existente,fg_estatus) VALUES ('2','1','sala_6','pieza',600,22000,500,'1');
INSERT INTO c_articulo (cl_almacen,cl_color,descripcion,unidad_medida,cantidad_entrada,precio_venta,cantidad_existente,fg_estatus) VALUES ('2','1','sala_7','pieza',600,22000,500,'1');
INSERT INTO c_articulo (cl_almacen,cl_color,descripcion,unidad_medida,cantidad_entrada,precio_venta,cantidad_existente,fg_estatus) VALUES ('2','1','sala_8','pieza',600,22000,500,'1');

-- ingresamos usuarios
INSERT INTO c_usuario (cl_puesto,cl_sucursal,nombre,ap_paterno,ap_materno,email,password,fg_admin,fg_activo) VALUES ('1','1','Gerardo','Torreblanca','Luna','gtorre@email.com','123456','1','1');
INSERT INTO c_usuario (cl_puesto,cl_sucursal,nombre,ap_paterno,ap_materno,email,password,fg_admin,fg_activo) VALUES ('2','1','Armando','Gonzales','Borja','armando@email.com','123456','1','1');
INSERT INTO c_usuario (cl_puesto,cl_sucursal,nombre,ap_paterno,ap_materno,email,password,fg_admin,fg_activo) VALUES ('4','1','luis','proveedor 1','ap_paterno','proveedor@email.com','123456','1','1');

-- valores para sucursales
INSERT INTO c_sucursal (cl_sucursal, nombre, calle, t_fijo) VALUES ('1', 'TOLUCA 1', 'PINOSUAREZ', '7222426467');
INSERT INTO c_sucursal (cl_sucursal, nombre, calle, t_fijo) VALUES ('2', 'TOLUCA 2', 'ADOLFO LOPEZ MATEOS', '7223186761');
INSERT INTO c_sucursal (cl_sucursal, nombre, calle, colonia, municipio, estado, t_fijo) VALUES ('3', 'TOLUCA 3', 'PASEO TOLLOCAN', 'UNIVERSIDAD', 'TOLUCA', 'TOLUCA', '7222121844');

-- clientes
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente1','ap_paterno','ap_materno','cliente1@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente2','ap_paterno','ap_materno','cliente2@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente3','ap_paterno','ap_materno','cliente3@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente4','ap_paterno','ap_materno','cliente4@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente5','ap_paterno','ap_materno','cliente5@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente6','ap_paterno','ap_materno','cliente6@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente7','ap_paterno','ap_materno','cliente7@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente8','ap_paterno','ap_materno','cliente8@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente9','ap_paterno','ap_materno','cliente9@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente10','ap_paterno','ap_materno','cliente10@email.com','1');
INSERT INTO c_cliente (nombre,ap_paterno,ap_materno,email,status) VALUES ('cliente11','ap_paterno','ap_materno','cliente11@email.com','1');


-- insertar puestos
INSERT INTO c_puesto (ds_descripcion) VALUES ('administrador');
INSERT INTO c_puesto (ds_descripcion) VALUES ('vendedor');
INSERT INTO c_puesto (ds_descripcion) VALUES ('chofer');
INSERT INTO c_puesto (ds_descripcion) VALUES ('proveedor');
