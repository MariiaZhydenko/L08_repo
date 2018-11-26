

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
