CREATE PROCEDURE [dbo].[GetInfoCompra]
	@codigo int
AS
	(SELECT nombre_proveedor,agente_ventas,telefono_proveedor FROM Proveedor WHERE nit=(SELECT nit FROM Producto WHERE barcode=@codigo))
RETURN 0
