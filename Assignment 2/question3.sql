with base as (
	select prod, quant
	from sales
	group by prod, quant
	order by prod, quant 
-- formula for median is (n+1)/2
-- this finds the rows that the median are on
), median as (
	select prod, ((count(quant)/2)+1) as median
	from base
	group by prod
-- this converts the index to the value
), finalt as (
	select b1.prod, b1.quant, count(b2.quant)
	from base as b1, base as b2
	where b2.quant <= b1.quant and b1.prod = b2.prod
	group by b1.prod, b1.quant 
	order by b1.prod, b1.quant
)

select ft.prod as product, ft.quant as median_quant
from finalt as ft, median as m
where ft.prod = m.prod and ft.count = m.median
