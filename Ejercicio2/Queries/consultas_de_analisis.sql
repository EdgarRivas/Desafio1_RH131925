--select * from [dbo].[venta] v inner join [dbo].[producto] p on p.id = v.fk_producto_id;


with consulta_recursiva(cliente, departamento, productos_diferentes, combinacion, ultimo_item) as (
	select tab.cliente, tab.nombre_departamento, 1, cast(tab.nombre as varchar(max)) as combinacion, tab.fk_producto_id from 
		(
			select v.cliente, p.nombre, v.fk_producto_id, d.nombre as nombre_departamento
			from [dbo].[venta] v
			inner join [dbo].[producto] p on p.id = v.fk_producto_id
			inner join [dbo].[departamento] d on d.id = v.fk_departamento_id
		) tab

	union all
	select cr.cliente, cr.departamento, productos_diferentes + 1, cr.combinacion + ' - ' + tab.nombre, tab.fk_producto_id
	from consulta_recursiva cr
	join 
	(
		select v.cliente, p.nombre, v.fk_producto_id, d.nombre as nombre_departamento
		from [dbo].[venta] v
		inner join [dbo].[producto] p on p.id = v.fk_producto_id
		inner join [dbo].[departamento] d on d.id = v.fk_departamento_id
	) tab
	on cr.cliente = tab.cliente
	and tab.fk_producto_id > cr.ultimo_item
	where cr.productos_diferentes < 7
)
select top 10 departamento, productos_diferentes, combinacion, count(*) as cantidad
from consulta_recursiva
where
productos_diferentes in (6)
and 
departamento = 'San Miguel'
group by departamento, productos_diferentes, combinacion
order by departamento desc, cantidad desc

-- top 3 combinaciones de 3 productos para Santa Ana
/*select top 3 departamento, productos_diferentes, combinacion, count(*) as cantidad
from consulta_recursiva
where
productos_diferentes in (3)
and 
departamento = 'Santa Ana'
group by departamento, productos_diferentes, combinacion
order by departamento desc, cantidad desc
*/


/*

select count(*) as [veces comprado], p.nombre from venta v inner join producto p on p.id = v.fk_producto_id
group by p.nombre

select top 3 d.nombre as departamento, count(*) as [veces comprado], p.nombre as producto from venta v
inner join producto p on p.id = v.fk_producto_id
inner join departamento d on d.id = v.fk_departamento_id
where d.nombre = 'San Miguel'
group by d.nombre, p.nombre
order by d.nombre, count(*) desc

select top 3 d.nombre as departamento, count(*) as [veces comprado], p.nombre as producto from venta v
inner join producto p on p.id = v.fk_producto_id
inner join departamento d on d.id = v.fk_departamento_id
where d.nombre = 'San Salvador'
group by d.nombre, p.nombre
order by d.nombre, count(*) desc

select top 3 d.nombre as departamento, count(*) as [veces comprado], p.nombre as producto from venta v
inner join producto p on p.id = v.fk_producto_id
inner join departamento d on d.id = v.fk_departamento_id
where d.nombre = 'Santa Ana'
group by d.nombre, p.nombre
order by d.nombre, count(*) desc

*/