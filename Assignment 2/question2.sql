with base as (
	select cust, prod, state
	from sales 
	group by cust, prod, state
), q1 as (
	select cust, prod, avg(quant) as quant1
	from sales
	where month between 1 and 3
	group by cust, prod
), q2 as (
	select cust, prod, avg(quant) as quant2
	from sales
	where month between 4 and 6
	group by cust, prod, quant
), q3 as (
	select cust, prod, avg(quant) as quant3
	from sales
	where month between 7 and 9
	group by cust, prod
), q4 as (
	select cust, prod, avg(quant) as quant4
	from sales
	where month between 10 and 12
	group by cust, prod
), q1final as (
	select b.cust, b.prod, state, cast('1' as int) as q, cast(null as numeric) as before_avg, q2.quant2 as after_avg
	from base as b, q2 as q2
	where b.cust = q2.cust and b.prod = q2.prod
), q2final as (
	select b.cust, b.prod, state, cast('2' as int) as q, q1.quant1 as before_avg, q3.quant3 as after_avg
	from base as b, q1 as q1, q3 as q3
	where b.cust = q1.cust and b.cust = q3.cust and b.prod = q1.prod and b.prod = q3.prod
), q3final as (
	select b.cust, b.prod, state, cast('3' as int) as q, q2.quant2 as before_avg, q4.quant4 as after_avg
	from base as b, q2 as q2, q4 as q4
	where b.cust = q2.cust and b.cust = q4.cust and b.prod = q2.prod and b.prod = q4.prod
), q4final as ( 
	select b.cust, b.prod, state, cast('4' as int) as q, cast(null as numeric) as after_avg, q3.quant3 as before_avg
	from base as b, q3 as q3
	where b.cust = q3.cust and b.prod = q3.prod
)

select *
from q1final
natural join q2final
natural join q3final
natural join q4final


