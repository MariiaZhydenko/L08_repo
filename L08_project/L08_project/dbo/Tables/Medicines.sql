CREATE TABLE [dbo].[Medicines] (
    [MedicineId]   INT          IDENTITY (1, 1) NOT NULL,
    [MedicineName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Medicines] PRIMARY KEY CLUSTERED ([MedicineId] ASC),
    CONSTRAINT [UQ_Medicines_MedicineName] UNIQUE NONCLUSTERED ([MedicineName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_OrdersLine_MedicineId]
    ON [dbo].[Medicines]([MedicineId] ASC);

