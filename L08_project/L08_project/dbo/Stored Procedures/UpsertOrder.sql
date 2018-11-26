

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
