CREATE TABLE [dbo].[PurchaseInvoicesLine] (
    [PurchaseInvoiceHeaderID] INT             NOT NULL,
    [MedicineId]              INT             NOT NULL,
    [Quantity]                INT             NULL,
    [Price]                   DECIMAL (10, 2) NULL,
    [Sum]                     AS              ([Quantity]*[Price]),
    CONSTRAINT [PK_PurchaseInvoicesLine] PRIMARY KEY CLUSTERED ([PurchaseInvoiceHeaderID] ASC, [MedicineId] ASC),
    CONSTRAINT [CK_PurchaseInvoicesLine] CHECK ([Quantity]>(0)),
    CONSTRAINT [FK_PurchaseInvoicesLine_MedicineId] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[Medicines] ([MedicineId]),
    CONSTRAINT [FK_PurchaseInvoicesLine_PurchaseInvoiceHeaderID] FOREIGN KEY ([PurchaseInvoiceHeaderID]) REFERENCES [dbo].[PurchaseInvoicesHeader] ([PurchaseInvoiceHeaderID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PurchaseInvoicesLine_MedicineId]
    ON [dbo].[PurchaseInvoicesLine]([MedicineId] ASC);

