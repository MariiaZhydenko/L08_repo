CREATE TABLE [dbo].[Suppliers] (
    [SupplierId]   INT          IDENTITY (1, 1) NOT NULL,
    [SupplierName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierId] ASC),
    CONSTRAINT [UQ_Suppliers_SupplierName] UNIQUE NONCLUSTERED ([SupplierName] ASC)
);

