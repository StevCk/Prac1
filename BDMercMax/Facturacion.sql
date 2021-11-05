CREATE TABLE [dbo].[Facturacion]
(
	[id_factura] INT NOT NULL PRIMARY KEY, 
    [monto_toral] DECIMAL(18, 2) NOT NULL, 
    [fecha] DATE NOT NULL, 
    [monto_iva] DECIMAL(18, 2) NOT NULL, 
    [cc_cliente] INT NOT NULL, 
    [cc_personal] INT NOT NULL, 
    [id_venta] INT NOT NULL, 
    CONSTRAINT [FK_Facturacion_Cliente] FOREIGN KEY ([cc_cliente]) REFERENCES [Cliente]([cc_cliente]), 
    CONSTRAINT [FK_Facturacion_Personal] FOREIGN KEY ([cc_personal]) REFERENCES [Personal]([cc_personal]), 
    CONSTRAINT [FK_Facturacion_Venta] FOREIGN KEY ([id_venta]) REFERENCES [Venta]([id_venta])
)
