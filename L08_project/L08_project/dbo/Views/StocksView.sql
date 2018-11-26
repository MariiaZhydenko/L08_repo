
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
CREATE UNIQUE CLUSTERED INDEX [IX_StockView]
    ON [dbo].[StocksView]([MedicineId] ASC);

