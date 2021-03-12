use master
go
alter database db_diego_spa set single_user with rollback immediate
go
drop database db_diego_spa
create database db_diego_spa
go
use db_diego_spa
go
create table sucursal (
	id int identity(1,1) primary key,
	nombre varchar(100) not null,
	nombre_archivo varchar(100) not null
)
go
insert into sucursal(nombre, nombre_archivo) values ('Centro', 'SpaCentro_')
insert into sucursal(nombre, nombre_archivo) values ('Santa Tecla', 'SpaSantaTecla_')
insert into sucursal(nombre, nombre_archivo) values ('Escalón', 'SpaEscalon_')
go
create table visita (
	id varchar(100) primary key,
	sexo bit not null,
	ingresos money not null,
	promedio_visitas decimal(18,3) not null,
	edad int not null,
	sauna bit not null,
	masaje bit not null,
	hidro bit not null,
	yoga bit not null,
	fk_sucursal_id int foreign key references sucursal(id)
)
go
create table visita_historico (
	pk_historico_id int identity(1,1) primary key,
	fecha_archivado date not null default GETDATE(),
	old_id varchar(100) not null,
	sexo bit not null,
	ingresos money not null,
	promedio_visitas decimal(18,3) not null,
	edad int not null,
	sauna bit not null,
	masaje bit not null,
	hidro bit not null,
	yoga bit not null
)

alter database db_diego_spa set multi_user