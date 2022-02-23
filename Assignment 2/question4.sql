with base as (
	select cust, prod, month, sum(quant) as SUMQ
	from sales 
	group by cust, prod, month
	order by cust, prod, month
), a1 as (
	select cust, prod, sum(SUMQ)
	from base
	group by cust, prod
-- this is for the running sum
), a2 as (
	select base.cust, base.prod, base.month, base.SUMQ, sum(b.SUMQ) as sum1
	from base as base, base as b
	where b.month <= base.month and base.cust = b.cust and base.prod = b.prod
	group by base.cust, base.prod, base.month, base.SUMQ
	order by cust, prod, month
--this takes the running sum and multiplies it by 75% to get the 75% purchased
), a3 as (
	select t.cust, t.prod, t.month 
	from a2 as t, a1 as b
	where t.cust = b.cust and t.prod = b.prod and t.sum1 >= (3.0/4.0 * b.sum)
	order by cust, prod, month
)

select cust, prod, min(month) as "75% purchased"
from a3
group by cust, prod
order by cust, prod