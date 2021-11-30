CREATE PROCEDURE [dbo].[GetFacturas]
	@id int
AS
	SELECT id_factura,monto_total,monto_iva,fecha FROM Facturacion WHERE cc_cliente=@id
RETURN 0
