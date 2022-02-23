with base as (
	select cust, prod, state
	from sales 
	group by cust, prod, state
--Quarter 1 months
), q1 as (
	select cust, prod, avg(quant) as quant 
	from sales 
	where month > 0 and month < 4 
	group by cust, prod
--Quarter 2 months
), q2 as (
	select cust, prod, avg(quant) as quant 
	from sales 
	where month > 3 and month < 7
	group by cust, prod
--Quarter 3 months
), q3 as (
	select cust, prod, avg(quant) as quant 
	from sales 
	where month > 6 and month < 10
	group by cust, prod
--Quarter 4 months 
), q4 as (
	select cust, prod, avg(quant) as quant 
	from sales 
	where month > 9 and month <= 12 
	group by cust, prod
--Takes the quarter after and makes the before null
), q1final as ( 
	select b.cust, b.prod, state, cast('1' as int) as q, cast(null as numeric) as before_avg, q2.quant as after_avg 
 	from base as b 
 	left join q2 using(cust, prod)
--Takes the quarter before(q1) and then the quarter after (q3)
), q2final as (
	select b.cust, b.prod, state, cast('2' as int) as q, q1.quant as before_avg, q3.quant as after_avg 
	from base as b 
	left join q1 using(cust, prod) left join q3 using(cust, prod)
--Takes the quarter before(q2) and then the quarter after (q4)
), q3final as (
	select b.cust, b.prod, state, cast('3' as int) as q, q2.quant as before_avg, q4.quant as after_avg 
	from base as b 
	left join q2 using(cust, prod) left join q4 using(cust, prod)
--Takes the quarter before and makes the after null
), q4final as (
	select b.cust, b.prod, state, cast('4' as int) as q, q3.quant as before_avg, cast(null as numeric) as after_avg 
	from base as b 
	left join q3 using(cust, prod)
--this combines all the tables to make one final table where all the quarters are combined
), finaltable as (
	select * 
	from q1final 
	union 
	select * 
	from q2final
	union 
	select * 
	from q3final 
	union 
	select * 
	from q4final
)

select * 
from finaltable
order by cust, prod, state, q