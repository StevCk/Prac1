/*
Script de implementación para BDMercaMax

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDMercaMax"
:setvar DefaultFilePrefix "BDMercaMax"
:setvar DefaultDataPath "C:\Users\steve\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\steve\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Modificando Procedimiento [dbo].[ActualizarGondola]...';


GO
ALTER PROCEDURE [dbo].[ActualizarGondola]
	@id int,
	@n int

AS
	UPDATE LugarStock SET cantidad_gondola=cantidad_gondola-@n WHERE barcode_producto=(SELECT barcode FROM Producto WHERE id_producto=@id)
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[ActualizarPuntos]...';


GO
CREATE PROCEDURE [dbo].[ActualizarPuntos]
	@id int,
	@n int
AS
	UPDATE Cliente SET puntos_acumulados = puntos_acumulados + @n WHERE cc_cliente=@id
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[CrearCliente]...';


GO
CREATE PROCEDURE [dbo].[CrearCliente]
	@cc int,
	@nombre nvarchar(max),
	@telefono nvarchar(max),
	@email nvarchar(max),
	@direccion nvarchar(max),
	@fecha date
AS
	INSERT INTO Cliente (cc_cliente,nombre_apellido_cliente,telefono_cliente,email_cliente,direccion_cliente,fecha_nacimiento,puntos_acumulados) VALUES (@cc,@nombre,@telefono,@email,@direccion,@fecha,0)
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[CrearFactura]...';


GO
CREATE PROCEDURE [dbo].[CrearFactura]
	@id int,
	@monto decimal(18,2),
	@date date,
	@montolva decimal(18,2),
	@cliente int,
	@personal int

AS
	INSERT INTO Facturacion (id_factura,monto_total,fecha,monto_iva,cc_cliente,cc_personal) VALUES (@id,@monto,@date,@montolva,@cliente,@personal) 
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[GetIvaPuntos]...';


GO
CREATE PROCEDURE [dbo].[GetIvaPuntos]
	@id int
AS
	SELECT iva, puntos FROM Tipo_Producto WHERE id_tipo=(SELECT id_tipo FROM Producto WHERE  id_producto=@id)
RETURN 0
GO
PRINT N'Actualización completada.';


GO
