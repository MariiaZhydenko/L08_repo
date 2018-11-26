CREATE TABLE [dbo].[PurchaseInvoicesHeader] (
    [PurchaseInvoiceHeaderID]   INT      IDENTITY (1, 1) NOT NULL,
    [SupplierId]                INT      NULL,
    [PurchaseInvoiceHeaderDate] DATETIME NULL,
    CONSTRAINT [PK_PurchaseInvoicesHeader] PRIMARY KEY CLUSTERED ([PurchaseInvoiceHeaderID] ASC),
    CONSTRAINT [FK_PurchaseInvoicesHeader_SupplierId] FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Suppliers] ([SupplierId])
);


GO
CREATE NONCLUSTERED INDEX [IX_PurchaseInvoicesHeader_SupplierId]
    ON [dbo].[PurchaseInvoicesHeader]([SupplierId] ASC);

