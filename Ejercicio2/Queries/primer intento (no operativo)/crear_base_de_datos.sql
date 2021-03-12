use master
go
alter database db_floristeria_fiorella set single_user with rollback immediate
go
drop database db_floristeria_fiorella
create database db_floristeria_fiorella
go
use db_floristeria_fiorella
go
create table departamento (
	id int identity(1,1) primary key,
	nombre varchar(100) not null,
	nombre_archivo varchar(150) not null
)
go
insert into departamento(nombre, nombre_archivo) values ('San Miguel', 'SanMiguel_')
insert into departamento(nombre, nombre_archivo) values ('San Salvador', 'SanSalvador_')
insert into departamento(nombre, nombre_archivo) values ('Santa Ana', 'SantaAna_')
go
create table venta (
	id varchar(100) primary key,
	rosa bit not null,
	clavel bit not null,
	maceta bit not null,
	tierra bit not null,
	girasole bit not null,
	hortensia bit not null,
	globo bit not null,
	tarjeta bit not null,
	orquidea bit not null,
	carmesi bit not null,
	lirios bit not null,
	aurora bit not null,
	tulipan bit not null,
	liston bit not null,
	fk_departamento_id int foreign key references departamento(id)
)

alter database db_floristeria_fiorella set multi_user