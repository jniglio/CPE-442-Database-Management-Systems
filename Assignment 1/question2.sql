with oct as (
	select distinct cust, prod, date as octdate, max(quant) as OCTMAX
	from sales
	where month = 10 and year > 2017 
	group by cust, prod, date
), nov as (
	select distinct cust, prod, date as novdate, min(quant) as NOVMIN
	from sales 
	where month = 11 
	group by cust, prod, date
), dece as (
	select distinct cust, prod, date as decdate, min(quant) as DECMIN
	from sales 
	where month = 12 
	group by cust, prod, date)
	
select distinct * 
from oct
natural join nov
natural join dece