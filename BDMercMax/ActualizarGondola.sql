CREATE PROCEDURE [dbo].[ActualizarGondola]
	@id int,
	@n int

AS
	UPDATE LugarStock SET cantidad_gondola=cantidad_gondola-@n WHERE barcode_producto=(SELECT barcode FROM Producto WHERE id_producto=@id)
RETURN 0
