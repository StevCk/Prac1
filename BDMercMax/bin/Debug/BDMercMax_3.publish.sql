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
/*
Se está quitando la columna [dbo].[Facturacion].[id_venta]; puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[Facturacion])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
/*
Se está quitando la columna [dbo].[LugarStock].[id_lugar]; puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[LugarStock])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
/*
Se está quitando la columna [dbo].[Venta].[id_venta]; puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[Venta])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'La siguiente operación se generó a partir de un archivo de registro de refactorización e475e38d-0dc7-45ee-9a9f-4f145cffb61a';

PRINT N'Cambiar el nombre de [dbo].[Facturacion].[monto_toral] a monto_total';


GO
EXECUTE sp_rename @objname = N'[dbo].[Facturacion].[monto_toral]', @newname = N'monto_total', @objtype = N'COLUMN';


GO
PRINT N'La siguiente operación se generó a partir de un archivo de registro de refactorización dcdb1a05-c594-4864-a5c7-84086e468504';

PRINT N'Cambiar el nombre de [dbo].[Cliente].[fecha_nacimiento_cliente] a fecha_nacimiento';


GO
EXECUTE sp_rename @objname = N'[dbo].[Cliente].[fecha_nacimiento_cliente]', @newname = N'fecha_nacimiento', @objtype = N'COLUMN';


GO
PRINT N'Quitando Clave externa [dbo].[FK_Facturacion_Venta]...';


GO
ALTER TABLE [dbo].[Facturacion] DROP CONSTRAINT [FK_Facturacion_Venta];


GO
PRINT N'Quitando Clave principal restricción sin nombre en [dbo].[LugarStock]...';


GO
ALTER TABLE [dbo].[LugarStock] DROP CONSTRAINT [PK__LugarSto__B172B1F8690C4110];


GO
PRINT N'Quitando Clave principal restricción sin nombre en [dbo].[Venta]...';


GO
ALTER TABLE [dbo].[Venta] DROP CONSTRAINT [PK__Venta__459533BF705B79D3];


GO
PRINT N'Modificando Tabla [dbo].[Facturacion]...';


GO
ALTER TABLE [dbo].[Facturacion] DROP COLUMN [id_venta];


GO
PRINT N'Modificando Tabla [dbo].[LugarStock]...';


GO
ALTER TABLE [dbo].[LugarStock] DROP COLUMN [id_lugar];


GO
PRINT N'Modificando Tabla [dbo].[Venta]...';


GO
ALTER TABLE [dbo].[Venta] DROP COLUMN [id_venta];


GO
PRINT N'Creando Vista [dbo].[GetCountFacturas]...';


GO
CREATE VIEW [dbo].[GetCountFacturas]
	AS SELECT id_factura FROM [Facturacion]
GO
PRINT N'Creando Vista [dbo].[VerClientes]...';


GO
CREATE VIEW [dbo].[VerClientes]
	AS SELECT cc_cliente,nombre_apellido_cliente,puntos_acumulados FROM [Cliente]
GO
PRINT N'Creando Vista [dbo].[VerProductoPrecio]...';


GO
CREATE VIEW [dbo].[VerProductoPrecio]
	AS SELECT id_producto,nombre_producto FROM [Producto]
GO
PRINT N'Creando Procedimiento [dbo].[ActualizarGondola]...';


GO
CREATE PROCEDURE [dbo].[ActualizarGondola]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'Actualizando Procedimiento [dbo].[VerProductoBodega]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[VerProductoBodega]';


GO
PRINT N'Actualizando Procedimiento [dbo].[VerProductoGondola]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[VerProductoGondola]';


GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e475e38d-0dc7-45ee-9a9f-4f145cffb61a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e475e38d-0dc7-45ee-9a9f-4f145cffb61a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'dcdb1a05-c594-4864-a5c7-84086e468504')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('dcdb1a05-c594-4864-a5c7-84086e468504')

GO

GO
PRINT N'Actualización completada.';


GO
