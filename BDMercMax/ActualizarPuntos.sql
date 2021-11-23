CREATE PROCEDURE [dbo].[ActualizarPuntos]
	@id int,
	@n int
AS
	UPDATE Cliente SET puntos_acumulados = puntos_acumulados + @n WHERE cc_cliente=@id
RETURN 0
