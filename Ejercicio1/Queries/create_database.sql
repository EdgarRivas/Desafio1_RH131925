if not exists (select * from sys.databases WHERE name = 'db_diego_spa')
begin
	create database db_diego_spa
end
go
use db_diego_spa
go
if not exists (select * from sysobjects WHERE name = 'visita' and xtype = 'U')
begin
	create table visita (
		id varchar(100) primary key,
		sexo bit not null,
		ingresos money not null,
		promedio_visitas decimal(18,3) not null,
		edad int not null,
		sauna bit not null,
		masaje bit not null,
		hidro bit not null,
		yoga bit not null
	)
end
go
if not exists (select * from sysobjects WHERE name = 'visita_historico' and xtype = 'U')
begin
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
end