with base as (
	SELECT month, prod, sum(quant) as s
	FROM sales
	GROUP BY month, prod
), minmax as (
	SELECT month, max(s) as maxq, min(s) as minq
	FROM base 
	GROUP BY month
), mostpop as (
	SELECT base.month, base.prod as MPP, maxq as MPPQ
	FROM base, minmax
	WHERE base.month = minmax.month and base.s = minmax.maxq
), leastpop as (
	Select base.month, base.prod as LPP, minq as LPP
	FROM base, minmax
	where base.month = minmax.month and base.s = minmax.minq)

select *
from mostpop
natural join leastpop
order by month



