
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
