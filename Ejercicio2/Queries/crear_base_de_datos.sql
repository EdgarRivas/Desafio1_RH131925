use master
go
alter database second_try set single_user with rollback immediate
go
drop database second_try
create database second_try
go
use second_try
go
create table departamento (
	id int identity(1,1) primary key,
	nombre varchar(100) not null,
	nombre_archivo varchar(150) not null
)
go
insert into departamento(nombre, nombre_archivo) values ('San Miguel', 'SanMiguel_'),('San Salvador', 'SanSalvador_'),('Santa Ana', 'SantaAna_')
go
create table producto (
	id int identity(1,1) primary key,
	nombre varchar(150) not null
)
go
insert into producto(nombre) values ('Rosas'),('Claveles'),('Macetas'),('Tierra'),('Girasoles'),('Hortensia'),
									('Globos'),('Tarjetas'),('Orquidias'),('Carmesi'),('Lirios'),('Aurora'),('Tulipanes'),('Liston')
create table venta (
	id int identity(1,1) primary key,
	cliente varchar(100) not null,
	fk_departamento_id int foreign key references departamento(id),
	fk_producto_id int foreign key references producto(id)
)

alter database second_try set multi_user