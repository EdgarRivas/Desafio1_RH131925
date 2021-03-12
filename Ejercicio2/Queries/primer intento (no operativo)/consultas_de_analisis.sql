select d.nombre, count(*) as [# ventas] from [db_floristeria_fiorella].[dbo].[venta] v
inner join [db_floristeria_fiorella].[dbo].[departamento] d ON v.fk_departamento_id = d.id
group by d.nombre;

-- Revisar combinaciones y ordenar por mas exitosa a menos exitosa
select tab_combinaciones.combinacion, count(tab_combinaciones.combinacion) from
(SELECT id, combinacion =
	STUFF((select DISTINCT ', ' + b.producto 
	FROM 

		(select id, 'Rosas' as producto from [db_floristeria_fiorella].[dbo].[venta] where [rosa] = 1
		UNION ALL
		select id, 'Claveles' as producto from [db_floristeria_fiorella].[dbo].[venta] where [clavel] = 1
		UNION ALL
		select id, 'Macetas' as producto from [db_floristeria_fiorella].[dbo].[venta] where [maceta] = 1
		UNION ALL
		select id, 'Tierra' as producto from [db_floristeria_fiorella].[dbo].[venta] where [tierra] = 1
		UNION ALL
		select id, 'Girsaoles' as producto from [db_floristeria_fiorella].[dbo].[venta] where [girasole] = 1
		UNION ALL
		select id, 'Hortensia' as producto from [db_floristeria_fiorella].[dbo].[venta] where [hortensia] = 1
		UNION ALL
		select id, 'Globos' as producto from [db_floristeria_fiorella].[dbo].[venta] where [globo] = 1
		UNION ALL
		select id, 'Tarjeta' as producto from [db_floristeria_fiorella].[dbo].[venta] where [tarjeta] = 1
		UNION ALL
		select id, 'Orquidea' as producto from [db_floristeria_fiorella].[dbo].[venta] where [orquidea] = 1
		UNION ALL
		select id, 'Carmesi' as producto from [db_floristeria_fiorella].[dbo].[venta] where [carmesi] = 1
		UNION ALL
		select id, 'Lirios' as producto from [db_floristeria_fiorella].[dbo].[venta] where [lirios] = 1
		UNION ALL
		select id, 'Aurora' as producto from [db_floristeria_fiorella].[dbo].[venta] where [aurora] = 1
		UNION ALL
		select id, 'Tulipan' as producto from [db_floristeria_fiorella].[dbo].[venta] where [tulipan] = 1
		UNION ALL
		select id, 'Listón' as producto from [db_floristeria_fiorella].[dbo].[venta] where [liston] = 1) b

	WHERE b.id = tab.id
	FOR XML PATH('')), 1, 2, '')
FROM (
select id, 'Rosas' as producto from [db_floristeria_fiorella].[dbo].[venta] where [rosa] = 1
UNION ALL
select id, 'Claveles' as producto from [db_floristeria_fiorella].[dbo].[venta] where [clavel] = 1
UNION ALL
select id, 'Macetas' as producto from [db_floristeria_fiorella].[dbo].[venta] where [maceta] = 1
UNION ALL
select id, 'Tierra' as producto from [db_floristeria_fiorella].[dbo].[venta] where [tierra] = 1
UNION ALL
select id, 'Girsaoles' as producto from [db_floristeria_fiorella].[dbo].[venta] where [girasole] = 1
UNION ALL
select id, 'Hortensia' as producto from [db_floristeria_fiorella].[dbo].[venta] where [hortensia] = 1
UNION ALL
select id, 'Globos' as producto from [db_floristeria_fiorella].[dbo].[venta] where [globo] = 1
UNION ALL
select id, 'Tarjeta' as producto from [db_floristeria_fiorella].[dbo].[venta] where [tarjeta] = 1
UNION ALL
select id, 'Orquidea' as producto from [db_floristeria_fiorella].[dbo].[venta] where [orquidea] = 1
UNION ALL
select id, 'Carmesi' as producto from [db_floristeria_fiorella].[dbo].[venta] where [carmesi] = 1
UNION ALL
select id, 'Lirios' as producto from [db_floristeria_fiorella].[dbo].[venta] where [lirios] = 1
UNION ALL
select id, 'Aurora' as producto from [db_floristeria_fiorella].[dbo].[venta] where [aurora] = 1
UNION ALL
select id, 'Tulipan' as producto from [db_floristeria_fiorella].[dbo].[venta] where [tulipan] = 1
UNION ALL
select id, 'Listón' as producto from [db_floristeria_fiorella].[dbo].[venta] where [liston] = 1) tab
group by id) tab_combinaciones
group by tab_combinaciones.combinacion;

--Aunque este fue un buen intento, los datos serán complicados de procesar. Por favor revisar el segundo intento.