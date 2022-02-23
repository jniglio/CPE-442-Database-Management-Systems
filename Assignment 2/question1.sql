with base as (
select cust, prod, month, state, avg(quant) as Cust_Average
from sales
group by cust, prod, month, state
--need to find out how to do the "other" columns and the natural join them which is making the values not equal to each other

), otherState as (
select s1.cust, s1.prod, s1.month, s1.state, avg(quant) as Other_State_Average
from base as s1, sales as s2
where s1.month = s2.month and s1.state != s2.state and s1.prod = s2.prod
group by s1.cust, s1.prod, s1.month, s1.state

), otherMonth as (
select s1.cust, s1.prod, s1.month, s1.state, avg(quant) as Other_Month_Average
from base as s1, sales as s2
where s1.month != s2.month and s1.state = s2.state and s1.prod = s2.prod
group by s1.cust, s1.prod, s1.month, s1.state

), otherProd as (
select s1.cust, s1.prod, s1.month, s1.state, avg(quant) as Other_Prod_Average
from base as s1, sales as s2
where s1.month = s2.month and s1.state = s2.state and s1.prod != s2.prod
group by s1.cust, s1.prod, s1.month, s1.state
)

select * 
from base 
natural join otherState
natural join otherMonth 
natural join otherProd
order by cust