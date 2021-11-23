CREATE PROCEDURE [dbo].[GetIvaPuntos]
	@id int
AS
	SELECT iva, puntos FROM Tipo_Producto WHERE id_tipo=(SELECT id_tipo FROM Producto WHERE  id_producto=@id)
RETURN 0
