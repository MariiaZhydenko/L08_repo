CREATE TABLE [dbo].[OrdersLine] (
    [OrderHeaderID] INT             NOT NULL,
    [MedicineId]    INT             NOT NULL,
    [Quantity]      INT             NULL,
    [Price]         DECIMAL (10, 2) NULL,
    [Sum]           AS              ([Quantity]*[Price]),
    CONSTRAINT [PK_OrdersLine] PRIMARY KEY CLUSTERED ([OrderHeaderID] ASC, [MedicineId] ASC),
    CONSTRAINT [CK_OrdersLineLine] CHECK ([Quantity]>(0)),
    CONSTRAINT [FK_OrdersLine_MedicineId] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[Medicines] ([MedicineId]),
    CONSTRAINT [FK_OrdersLine_OrderHeaderID] FOREIGN KEY ([OrderHeaderID]) REFERENCES [dbo].[OrdersHeader] ([OrderHeaderID])
);

