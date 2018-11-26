CREATE TABLE [dbo].[Customers] (
    [CustomerId]   INT          IDENTITY (1, 1) NOT NULL,
    [CustomerName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerId] ASC),
    CONSTRAINT [UQ_Customers_CustomerName] UNIQUE NONCLUSTERED ([CustomerName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_OrdersHeader_CustomerId]
    ON [dbo].[Customers]([CustomerId] ASC);

