﻿/*
Deployment script for Test

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Test"
:setvar DefaultFilePrefix "Test"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE Latin1_General_100_CI_AS
GO
PRINT N'Creating [secondary]...';


GO
ALTER DATABASE [$(DatabaseName)]
    ADD FILEGROUP [secondary];


GO
ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [secondary_35C5FFEA], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_secondary_35C5FFEA.mdf') TO FILEGROUP [secondary];


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Customers]...';


GO
CREATE TABLE [dbo].[Customers] (
    [CustomerId]   INT          IDENTITY (1, 1) NOT NULL,
    [CustomerName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerId] ASC),
    CONSTRAINT [UQ_Customers_CustomerName] UNIQUE NONCLUSTERED ([CustomerName] ASC)
);


GO
PRINT N'Creating [dbo].[Customers].[IX_OrdersHeader_CustomerId]...';


GO
CREATE NONCLUSTERED INDEX [IX_OrdersHeader_CustomerId]
    ON [dbo].[Customers]([CustomerId] ASC);


GO
PRINT N'Creating [dbo].[DBVersion]...';


GO
CREATE TABLE [dbo].[DBVersion] (
    [Version]   CHAR (10) NOT NULL,
    [DateStart] DATE      NOT NULL,
    [DateEnd]   DATE      NULL,
    PRIMARY KEY CLUSTERED ([Version] ASC)
);


GO
PRINT N'Creating [dbo].[Medicines]...';


GO
CREATE TABLE [dbo].[Medicines] (
    [MedicineId]   INT          IDENTITY (1, 1) NOT NULL,
    [MedicineName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Medicines] PRIMARY KEY CLUSTERED ([MedicineId] ASC),
    CONSTRAINT [UQ_Medicines_MedicineName] UNIQUE NONCLUSTERED ([MedicineName] ASC)
);


GO
PRINT N'Creating [dbo].[Medicines].[IX_OrdersLine_MedicineId]...';


GO
CREATE NONCLUSTERED INDEX [IX_OrdersLine_MedicineId]
    ON [dbo].[Medicines]([MedicineId] ASC);


GO
PRINT N'Creating [dbo].[OrdersHeader]...';


GO
CREATE TABLE [dbo].[OrdersHeader] (
    [OrderHeaderID]   INT      IDENTITY (1, 1) NOT NULL,
    [CustomerId]      INT      NULL,
    [OrderHeaderDate] DATETIME NULL,
    CONSTRAINT [PK_OrdersHeader] PRIMARY KEY CLUSTERED ([OrderHeaderID] ASC)
);


GO
PRINT N'Creating [dbo].[OrdersLine]...';


GO
CREATE TABLE [dbo].[OrdersLine] (
    [OrderHeaderID] INT             NOT NULL,
    [MedicineId]    INT             NOT NULL,
    [Quantity]      INT             NULL,
    [Price]         DECIMAL (10, 2) NULL,
    [Sum]           AS              ([Quantity] * [Price]),
    CONSTRAINT [PK_OrdersLine] PRIMARY KEY CLUSTERED ([OrderHeaderID] ASC, [MedicineId] ASC)
);


GO
PRINT N'Creating [dbo].[PurchaseInvoicesHeader]...';


GO
CREATE TABLE [dbo].[PurchaseInvoicesHeader] (
    [PurchaseInvoiceHeaderID]   INT      IDENTITY (1, 1) NOT NULL,
    [SupplierId]                INT      NULL,
    [PurchaseInvoiceHeaderDate] DATETIME NULL,
    CONSTRAINT [PK_PurchaseInvoicesHeader] PRIMARY KEY CLUSTERED ([PurchaseInvoiceHeaderID] ASC)
);


GO
PRINT N'Creating [dbo].[PurchaseInvoicesHeader].[IX_PurchaseInvoicesHeader_SupplierId]...';


GO
CREATE NONCLUSTERED INDEX [IX_PurchaseInvoicesHeader_SupplierId]
    ON [dbo].[PurchaseInvoicesHeader]([SupplierId] ASC);


GO
PRINT N'Creating [dbo].[PurchaseInvoicesLine]...';


GO
CREATE TABLE [dbo].[PurchaseInvoicesLine] (
    [PurchaseInvoiceHeaderID] INT             NOT NULL,
    [MedicineId]              INT             NOT NULL,
    [Quantity]                INT             NULL,
    [Price]                   DECIMAL (10, 2) NULL,
    [Sum]                     AS              ([Quantity] * [Price]),
    CONSTRAINT [PK_PurchaseInvoicesLine] PRIMARY KEY CLUSTERED ([PurchaseInvoiceHeaderID] ASC, [MedicineId] ASC)
);


GO
PRINT N'Creating [dbo].[PurchaseInvoicesLine].[IX_PurchaseInvoicesLine_MedicineId]...';


GO
CREATE NONCLUSTERED INDEX [IX_PurchaseInvoicesLine_MedicineId]
    ON [dbo].[PurchaseInvoicesLine]([MedicineId] ASC);


GO
PRINT N'Creating [dbo].[StockChanges]...';


GO
CREATE TABLE [dbo].[StockChanges] (
    [MedicineId] INT      NOT NULL,
    [DocID]      INT      NOT NULL,
    [DocType]    TINYINT  NOT NULL,
    [ChangeDate] DATETIME NULL,
    [Quantity]   INT      NOT NULL,
    CONSTRAINT [PK_StockChanges] PRIMARY KEY CLUSTERED ([MedicineId] ASC, [DocID] ASC, [DocType] ASC)
);


GO
PRINT N'Creating [dbo].[Suppliers]...';


GO
CREATE TABLE [dbo].[Suppliers] (
    [SupplierId]   INT          IDENTITY (1, 1) NOT NULL,
    [SupplierName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierId] ASC),
    CONSTRAINT [UQ_Suppliers_SupplierName] UNIQUE NONCLUSTERED ([SupplierName] ASC)
);


GO
PRINT N'Creating [dbo].[FK_OrdersHeader_CustomerId]...';


GO
ALTER TABLE [dbo].[OrdersHeader]
    ADD CONSTRAINT [FK_OrdersHeader_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([CustomerId]);


GO
PRINT N'Creating [dbo].[FK_OrdersLine_MedicineId]...';


GO
ALTER TABLE [dbo].[OrdersLine]
    ADD CONSTRAINT [FK_OrdersLine_MedicineId] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[Medicines] ([MedicineId]);


GO
PRINT N'Creating [dbo].[FK_OrdersLine_OrderHeaderID]...';


GO
ALTER TABLE [dbo].[OrdersLine]
    ADD CONSTRAINT [FK_OrdersLine_OrderHeaderID] FOREIGN KEY ([OrderHeaderID]) REFERENCES [dbo].[OrdersHeader] ([OrderHeaderID]);


GO
PRINT N'Creating [dbo].[FK_PurchaseInvoicesHeader_SupplierId]...';


GO
ALTER TABLE [dbo].[PurchaseInvoicesHeader]
    ADD CONSTRAINT [FK_PurchaseInvoicesHeader_SupplierId] FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Suppliers] ([SupplierId]);


GO
PRINT N'Creating [dbo].[FK_PurchaseInvoicesLine_MedicineId]...';


GO
ALTER TABLE [dbo].[PurchaseInvoicesLine]
    ADD CONSTRAINT [FK_PurchaseInvoicesLine_MedicineId] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[Medicines] ([MedicineId]);


GO
PRINT N'Creating [dbo].[FK_PurchaseInvoicesLine_PurchaseInvoiceHeaderID]...';


GO
ALTER TABLE [dbo].[PurchaseInvoicesLine]
    ADD CONSTRAINT [FK_PurchaseInvoicesLine_PurchaseInvoiceHeaderID] FOREIGN KEY ([PurchaseInvoiceHeaderID]) REFERENCES [dbo].[PurchaseInvoicesHeader] ([PurchaseInvoiceHeaderID]);


GO
PRINT N'Creating [dbo].[CK_OrdersLineLine]...';


GO
ALTER TABLE [dbo].[OrdersLine]
    ADD CONSTRAINT [CK_OrdersLineLine] CHECK ([Quantity]>(0));


GO
PRINT N'Creating [dbo].[CK_PurchaseInvoicesLine]...';


GO
ALTER TABLE [dbo].[PurchaseInvoicesLine]
    ADD CONSTRAINT [CK_PurchaseInvoicesLine] CHECK ([Quantity]>(0));


GO
PRINT N'Creating [dbo].[StocksView]...';


GO

create view dbo.StocksView
with schemabinding
as 
select 
	  MedicineId
	, sum(Quantity) as Stock
	, count_big(*) as Row_Count
from dbo.StockChanges
group by MedicineId
GO
PRINT N'Creating [dbo].[StocksView].[IX_StockView]...';


GO
CREATE UNIQUE CLUSTERED INDEX [IX_StockView]
    ON [dbo].[StocksView]([MedicineId] ASC);


GO
PRINT N'Creating [dbo].[UpsertCustomer]...';


GO

create procedure dbo.UpsertCustomer @CustomerName varchar(50)
as
begin try
set nocount, xact_abort on

if isnull(@CustomerName,'') = ''
	throw 50000, 'Invalid parameter', 1

insert into dbo.Customers (CustomerName)
values (@CustomerName)

end try
begin catch
	throw
end catch
GO
PRINT N'Creating [dbo].[UpsertMedicine]...';


GO

--drop procedure dbo.UpsertMedicine
--go
--drop procedure dbo.UpsertSupplier
--go
--drop procedure dbo.UpsertCustomer
--go
--drop procedure dbo.UpsertPurchaseInvoice
--go
--drop procedure dbo.UpsertOrder
--go

create procedure dbo.UpsertMedicine @MedicineName varchar(50)
as
begin try
set nocount, xact_abort on

if isnull(@MedicineName,'') = ''
	throw 50000, 'Invalid parameter', 1

insert into dbo.Medicines (MedicineName)
values (@MedicineName)

end try
begin catch
	throw
end catch
GO
PRINT N'Creating [dbo].[UpsertOrder]...';


GO


create procedure dbo.UpsertOrder
	@CustomerId int
	, @OrderHeaderDate datetime  = null
	, @MedicineId int
	, @Quantity int
	, @Price decimal (10,2)

as
begin try
set nocount, xact_abort on

if isnull(@CustomerId, 0) = '' or
	isnull(@MedicineId, 0) = '' or
	isnull(@Quantity, 0) = 0 or
	isnull(@Price, 0) = 0
	throw 50000, 'Invalid parameter', 1

begin tran

	if @OrderHeaderDate is null
		set @OrderHeaderDate = getdate()

	insert into dbo.OrdersHeader (CustomerId, OrderHeaderDate)
	values (@CustomerId, @OrderHeaderDate)

	declare @OrderHeaderID int 
	set @OrderHeaderID = @@identity

	insert into dbo.OrdersLine (OrderHeaderID, MedicineId, Quantity, Price)
	values (@OrderHeaderID, @MedicineId, @Quantity, @Price)

	insert into dbo.StockChanges (MedicineId, DocID, DocType, ChangeDate, Quantity)
	values (@MedicineId, @OrderHeaderID, 2, @OrderHeaderDate, 0-@Quantity)

commit

end try
begin catch
	if xact_state() <> 0
		rollback
	;throw
end catch
GO
PRINT N'Creating [dbo].[UpsertPurchaseInvoice]...';


GO


--------------------------------
create procedure dbo.UpsertPurchaseInvoice
				@SupplierId int
				, @PurchaseInvoiceHeaderDate datetime  = null
				, @MedicineId int
				, @Quantity int
				, @Price decimal (10,2)

	as
	begin try
	set nocount, xact_abort on

if isnull(@SupplierId,'') = '' or
	isnull(@MedicineId,'') = '' or
	isnull(@Quantity, 0) = 0 or
	isnull(@Price, 0) = 0
	throw 50000, 'Invalid parameter', 1

begin tran

	if @PurchaseInvoiceHeaderDate is null
		set @PurchaseInvoiceHeaderDate = getdate()

	insert into dbo.PurchaseInvoicesHeader (SupplierId, PurchaseInvoiceHeaderDate)
	values (@SupplierId, @PurchaseInvoiceHeaderDate)

	declare @PurchaseInvoiceHeaderID int 
	set @PurchaseInvoiceHeaderID = @@identity

	insert into dbo.PurchaseInvoicesLine (PurchaseInvoiceHeaderID, MedicineId, Quantity, Price)
	values (@PurchaseInvoiceHeaderID, @MedicineId, @Quantity, @Price)

	insert into dbo.StockChanges (MedicineId, DocID, DocType, ChangeDate, Quantity)
	values (@MedicineId, @PurchaseInvoiceHeaderID, 1, @PurchaseInvoiceHeaderDate, @Quantity)

commit

end try
begin catch
	if xact_state() <> 0
		rollback
	;throw
end catch
GO
PRINT N'Creating [dbo].[UpsertSupplier]...';


GO

create procedure dbo.UpsertSupplier @SupplierName varchar(50)
as
begin try
set nocount, xact_abort on

if isnull(@SupplierName,'') = ''
	throw 50000, 'Invalid parameter', 1

insert into dbo.Suppliers (SupplierName)
values (@SupplierName)

end try
begin catch
	throw
end catch
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO