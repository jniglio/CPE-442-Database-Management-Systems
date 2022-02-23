with base as (
	select prod, cust, state, sum(quant) as s
	from sales
	GROUP BY prod, cust, state
), ctavg as (
	select prod, cust, avg(s) as CTAVG
	from base
	where base.state = 'CT'
	GROUP BY prod, cust
), nyavg as (
	select prod, cust, avg(s) as NYAVG
	from base 
	where base.state = 'NY'
	GROUP BY prod, cust
), paavg as (
	select prod, cust, avg(s) as PAAVG
	from base 
	where base.state = 'PA'
	GROUP BY prod, cust
), njavg as (
	select prod, cust, avg(s) as NJAVG
	from base
	where base.state = 'NJ'
	GROUP BY prod, cust
), atc as (
	select prod, cust, avg(quant) as AVERAGE, count(quant) as COUNTT, sum(quant) as TOTAL
	from sales
	group by prod, cust
)

select * 
from ctavg
natural join nyavg
natural join paavg
natural join njavg 
natural join atc

