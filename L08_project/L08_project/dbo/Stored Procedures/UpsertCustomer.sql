
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
