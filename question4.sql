with base as (
	SELECT month, prod, sum(quant) as s
	FROM sales
	GROUP BY month, prod
	order by month, prod
), minmax as (
	SELECT prod, max(s) as maxq, min(s) as minq
	FROM base 
	GROUP BY prod
), mostfav as (
	SELECT base.month as MFM, minmax.prod as product
	FROM base, minmax
	WHERE base.prod = minmax.prod and base.s = minmax.maxq
), leastfav as (
	Select base.month as LFM, minmax.prod as product
	FROM base, minmax
	where base.prod = minmax.prod and base.s = minmax.minq)

select *
from mostfav
natural join leastfav

