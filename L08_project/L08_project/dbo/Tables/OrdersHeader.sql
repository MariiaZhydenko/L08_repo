CREATE TABLE [dbo].[OrdersHeader] (
    [OrderHeaderID]   INT      IDENTITY (1, 1) NOT NULL,
    [CustomerId]      INT      NULL,
    [OrderHeaderDate] DATETIME NULL,
    CONSTRAINT [PK_OrdersHeader] PRIMARY KEY CLUSTERED ([OrderHeaderID] ASC),
    CONSTRAINT [FK_OrdersHeader_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([CustomerId])
);

