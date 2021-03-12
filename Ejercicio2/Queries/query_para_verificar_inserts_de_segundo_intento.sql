/****** Script for SelectTopNRows command from SSMS  ******/
SELECT v.[id]
      ,[cliente]
      ,[fk_departamento_id]
      ,p.nombre
  FROM [second_try].[dbo].[venta] v
  INNER JOIN [second_try].[dbo].[producto] p ON p.id = v.fk_producto_id
  WHERE [cliente] = 'Loren Pritty'