CREATE PROCEDURE [dbo].[MoverAgondola]
	@n int,
	@codigo int
AS
	UPDATE LugarStock SET cantidad_gondola = cantidad_gondola +@n, cantidad_bodega = cantidad_bodega -@n WHERE barcode_producto = @codigo
RETURN 0
