
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
