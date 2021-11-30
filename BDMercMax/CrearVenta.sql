CREATE PROCEDURE [dbo].[CrearVenta]
	@id int,
	@n int,
	@factura int
AS
	INSERT INTO Venta( barcode_producto,cantidad,id_factura) VALUES ( (SELECT barcode FROM Producto WHERE id_producto=@id),@n,@factura)
RETURN 0
