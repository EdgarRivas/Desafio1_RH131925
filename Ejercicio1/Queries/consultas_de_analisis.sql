SELECT 
	suc.nombre as sucursal,
	COUNT(*) as cantidad,
	CONVERT(DECIMAL(10,1), AVG(promedio_visitas)) as [visitas promedio],
	CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as [visitas total aprox.],
	CONVERT(DECIMAL(10,2), (
		(CAST(COUNT(*) AS real) / CAST((SELECT COUNT(*) FROM [db_diego_spa].[dbo].[visita]) AS real)) * 100
	)) as [Porcentaje (%)]
FROM [db_diego_spa].[dbo].[visita] vis
INNER JOIN [db_diego_spa].[dbo].[sucursal] suc ON vis.fk_sucursal_id = suc.id
group by suc.nombre
order by cantidad;

SELECT
	CASE WHEN sexo = 0 THEN 'Hombres' ELSE 'Mujeres' END AS sexo,
	COUNT(*) as cantidad,
	CONVERT(DECIMAL(10,1), AVG(promedio_visitas)) as [visitas promedio],
	CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as [visitas total aprox.],
	CONVERT(DECIMAL(10,2), (
		(CAST(COUNT(*) AS real) / CAST((SELECT COUNT(*) FROM [db_diego_spa].[dbo].[visita]) AS real)) * 100
	)) as [Porcentaje (%)]
FROM [db_diego_spa].[dbo].[visita] vis
INNER JOIN [db_diego_spa].[dbo].[sucursal] suc ON vis.fk_sucursal_id = suc.id
group by vis.sexo
order by cantidad;

SELECT 
	suc.nombre as sucursal,
	CASE WHEN sexo = 0 THEN 'Hombres' ELSE 'Mujeres' END AS sexo,
	COUNT(*) as cantidad,
	CONVERT(DECIMAL(10,1), AVG(promedio_visitas)) as [visitas promedio],
	CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as [visitas total aprox.],
	CONVERT(DECIMAL(10,2), (
		(CAST(COUNT(*) AS real) / CAST((SELECT COUNT(*) FROM [db_diego_spa].[dbo].[visita]) AS real)) * 100
	)) as [Porcentaje (%)]
FROM [db_diego_spa].[dbo].[visita] vis
INNER JOIN [db_diego_spa].[dbo].[sucursal] suc ON vis.fk_sucursal_id = suc.id
group by vis.sexo, suc.nombre
order by cantidad;


/* 
Datos de interés:
- La sucursal del Centro es la que menos clientela recibe
- La sucursal Escalón es la que cuenta con mayor clientela
- La mayoría de las mujeres, prefieren visitar la sucursal Escalón
*/

/*
SELECT ing.ingresos as media_ingresos, COUNT(*) FROM
(SELECT CASE
	WHEN ingresos < 300 then '1. 300 o menos'
	WHEN ingresos BETWEEN 301 AND 500 then '2. 500 o menos'
	WHEN ingresos BETWEEN 501 AND 700 then '3. 700 o menos'
	WHEN ingresos BETWEEN 701 AND 900 then '4. 900 o menos'
	WHEN ingresos BETWEEN 901 AND 1100 then '5. 1100 o menos'
	WHEN ingresos BETWEEN 1101 AND 1500 then '6. 1500 o menos'
	WHEN ingresos > 1500 then '7. mas de 1500'
	ELSE 'sin clasificar'
	END AS ingresos
FROM [db_diego_spa].[dbo].[visita]) ing
GROUP BY ing.ingresos;
-- Resultados muy decantados a +1500 de ingresos. Desglozando más

SELECT ing.ingresos as media_ingresos, COUNT(*) FROM
(SELECT CASE
	WHEN ingresos <= 1500 then '1. 1500 o menos'
	WHEN ingresos > 1500 then '2. mas de 1500'
	ELSE 'sin clasificar'
	END AS ingresos
FROM [db_diego_spa].[dbo].[visita]) ing
GROUP BY ing.ingresos;
-- mas del doble de clientes ganan más de 1500. Volviendo a crear segmentos

SELECT COUNT(*), ing.rango_ingresos, AVG(ingresos) as media_ingresos FROM
(SELECT CASE
	WHEN ingresos < 500 then '1. 500 o menos'
	WHEN ingresos BETWEEN 500.01 AND 1000 then '2. 1000 o menos'
	WHEN ingresos BETWEEN 1000.01 AND 1500 then '3. 1500 o menos'
	WHEN ingresos BETWEEN 1500.01 AND 2000 then '4. 2000 o menos'
	WHEN ingresos BETWEEN 2000.01 AND 2500 then '5. 2500 o menos'
	WHEN ingresos BETWEEN 2500.01 AND 3000 then '6. 3000 o menos'
	WHEN ingresos > 3000 then '7. mas de 3000'
	ELSE 'sin clasificar'
	END AS rango_ingresos,
	ingresos AS ingresos
FROM [db_diego_spa].[dbo].[visita]) ing
GROUP BY ing.rango_ingresos;
-- Datos de interes: muy pocos clientes con ingresos de 500 y menos. No hay clientes que ganen más de 3000. Desglozando sección de 2000 a 3000

SELECT COUNT(*), ing.rango_ingresos, AVG(ingresos) as media_ingresos FROM
(SELECT CASE
	WHEN ingresos < 2000 then '01. 2000 o menos'
	WHEN ingresos BETWEEN 2000.01 AND 2100 then '02. 2100 o menos'
	WHEN ingresos BETWEEN 2100.01 AND 2200 then '03. 2200 o menos'
	WHEN ingresos BETWEEN 2200.01 AND 2300 then '04. 2300 o menos'
	WHEN ingresos BETWEEN 2300.01 AND 2400 then '05. 2400 o menos'
	WHEN ingresos BETWEEN 2400.01 AND 2500 then '06. 2500 o menos'
	WHEN ingresos BETWEEN 2500.01 AND 2600 then '07. 2600 o menos'
	WHEN ingresos BETWEEN 2600.01 AND 2700 then '08. 2700 o menos'
	WHEN ingresos BETWEEN 2700.01 AND 2800 then '09. 2800 o menos'
	WHEN ingresos BETWEEN 2800.01 AND 2900 then '10. 2900 o menos'
	WHEN ingresos BETWEEN 2900.01 AND 3000 then '11. 3000 o menos'
	WHEN ingresos > 3000 then '12. mas de 3000'
	ELSE 'sin clasificar'
	END AS rango_ingresos,
	ingresos AS ingresos
FROM [db_diego_spa].[dbo].[visita]) ing
GROUP BY ing.rango_ingresos;
-- Datos de interes: la distribución en este segmento es uniforme.


-- Agregando columna sexo
SELECT 
COUNT(*) as cantidad,
sexo,
ing.rango_ingresos,
AVG(ingresos) as media_ingresos FROM (
SELECT
	CASE
		WHEN ingresos < 500 then '1. 500 o menos'
		WHEN ingresos BETWEEN 500.01 AND 1000 then '2. 1000 o menos'
		WHEN ingresos BETWEEN 1000.01 AND 1500 then '3. 1500 o menos'
		WHEN ingresos BETWEEN 1500.01 AND 2000 then '4. 2000 o menos'
		WHEN ingresos BETWEEN 2000.01 AND 2500 then '5. 2500 o menos'
		WHEN ingresos BETWEEN 2500.01 AND 3000 then '6. 3000 o menos'
		WHEN ingresos > 3000 then '7. mas de 3000'
		ELSE 'sin clasificar'
	END AS rango_ingresos,
	ingresos AS ingresos,
	CASE
		WHEN sexo = 0 THEN 'Hombre' 
		ELSE 'Mujer'
	END AS sexo
FROM [db_diego_spa].[dbo].[visita]) ing
GROUP BY sexo, ing.rango_ingresos;
--Dato de interes: en ingresos debajo de 2000 la tendencia de más clientes hombres que mujeres aumenta. Subiendo de los 2000 de ingreso empiezan a tener valores más similares.
*/

SELECT
ing.rango_ingresos,
sexo,
COUNT(*) as cantidad,
CONVERT(DECIMAL(10,1), AVG(promedio_visitas)) as [visitas promedio],
CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as [visitas total aprox.],
AVG(ingresos) as media_ingresos FROM (
SELECT
	CASE
		WHEN ingresos < 500 then '0 - 500'
		WHEN ingresos BETWEEN 500.01 AND 1000 then '500 - 1000'
		WHEN ingresos BETWEEN 1000.01 AND 2000 then '1000 - 2000'
		WHEN ingresos BETWEEN 2000.01 AND 3000 then '2000 - 3000'
		WHEN ingresos > 3000 then '3000+'
		ELSE 'N/A'
	END AS rango_ingresos,
	ingresos AS ingresos,
	promedio_visitas AS promedio_visitas,
	CASE
		WHEN sexo = 0 THEN 'Hombre' 
		ELSE 'Mujer'
	END AS sexo
FROM [db_diego_spa].[dbo].[visita] vis
INNER JOIN [db_diego_spa].[dbo].[sucursal] suc ON vis.fk_sucursal_id = suc.id) ing
GROUP BY sexo, ing.rango_ingresos
ORDER BY cantidad ASC;
-- Los clientes que menos gastan son los hombres y mujeres con ingresos menores a 500 y los que más lo hacen son los hombres con ingresos entre 1000 y 2000

-- Basados en estos datos, segregamos los siguientes grupos
SELECT Paquete, visita_total as [visitas total aprox.] FROM
(select 'Sauna' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 1 AND masaje = 0 AND hidro = 0 AND yoga = 0
UNION ALL
select 'Masaje' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 0 AND masaje = 1 AND hidro = 0 AND yoga = 0
UNION ALL
select 'Hidro' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 0 AND masaje = 0 AND hidro = 1 AND yoga = 0
UNION ALL
select 'Yoga' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 0 AND masaje = 0 AND hidro = 0 AND yoga = 1

UNION ALL

select 'Sauna y Masaje' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 1 AND masaje = 1 AND hidro = 0 AND yoga = 0
UNION ALL
select 'Sauna e Hidro' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 1 AND masaje = 0 AND hidro = 1 AND yoga = 0
UNION ALL
select 'Sauna y Yoga' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 1 AND masaje = 0 AND hidro = 0 AND yoga = 1

UNION ALL

select 'Masaje e Hidro' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 0 AND masaje = 1 AND hidro = 1 AND yoga = 0
UNION ALL
select 'Masaje y Yoga' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 0 AND masaje = 1 AND hidro = 0 AND yoga = 1

UNION ALL

select 'Hidro y Yoga' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 0 AND masaje = 0 AND hidro = 1 AND yoga = 1

UNION ALL

select 'Completo (4 Servicios)' as Paquete, CONVERT(INT, AVG(promedio_visitas) * COUNT(*)) as visita_total from [db_diego_spa].[dbo].[visita]
WHERE sauna = 1 AND masaje = 1 AND hidro = 1 AND yoga = 1) tab
ORDER BY visita_total;