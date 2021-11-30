CREATE PROCEDURE [dbo].[CrearFactura]
	@id int,
	@monto decimal(18,2),
	@date date,
	@montoIva decimal(18,2),
	@cliente int,
	@personal int

AS
	INSERT INTO Facturacion (id_factura,monto_total,fecha,monto_iva,cc_cliente,cc_personal) VALUES (@id,@monto,@date,@montoIva,@cliente,@personal) 
RETURN 0
