/*
Script de implementación para DBPrac1

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DBPrac1"
:setvar DefaultFilePrefix "DBPrac1"
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
PRINT N'Quitando Clave externa [dbo].[FK_INSCRITO_ALUMNO]...';


GO
ALTER TABLE [dbo].[INSCRITO] DROP CONSTRAINT [FK_INSCRITO_ALUMNO];


GO
PRINT N'Quitando Clave externa [dbo].[FK_INSCRITO_CURSO]...';


GO
ALTER TABLE [dbo].[INSCRITO] DROP CONSTRAINT [FK_INSCRITO_CURSO];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[INSCRITO]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_INSCRITO] (
    [Id]        INT IDENTITY (1, 1) NOT NULL,
    [Id_Al]     INT NOT NULL,
    [Cod_Curso] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[INSCRITO])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_INSCRITO] ON;
        INSERT INTO [dbo].[tmp_ms_xx_INSCRITO] ([Id], [Id_Al], [Cod_Curso])
        SELECT   [Id],
                 [Id_Al],
                 [Cod_Curso]
        FROM     [dbo].[INSCRITO]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_INSCRITO] OFF;
    END

DROP TABLE [dbo].[INSCRITO];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_INSCRITO]', N'INSCRITO';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Clave externa [dbo].[FK_INSCRITO_ALUMNO]...';


GO
ALTER TABLE [dbo].[INSCRITO] WITH NOCHECK
    ADD CONSTRAINT [FK_INSCRITO_ALUMNO] FOREIGN KEY ([Id_Al]) REFERENCES [dbo].[ALUMNO] ([Id]);


GO
PRINT N'Creando Clave externa [dbo].[FK_INSCRITO_CURSO]...';


GO
ALTER TABLE [dbo].[INSCRITO] WITH NOCHECK
    ADD CONSTRAINT [FK_INSCRITO_CURSO] FOREIGN KEY ([Cod_Curso]) REFERENCES [dbo].[CURSO] ([Cod]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[INSCRITO] WITH CHECK CHECK CONSTRAINT [FK_INSCRITO_ALUMNO];

ALTER TABLE [dbo].[INSCRITO] WITH CHECK CHECK CONSTRAINT [FK_INSCRITO_CURSO];


GO
PRINT N'Actualización completada.';


GO
