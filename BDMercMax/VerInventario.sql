CREATE VIEW [dbo].[VerInventario]
	AS SELECT barcode_producto,cantidad_gondola,cantidad_bodega FROM [LugarStock]
