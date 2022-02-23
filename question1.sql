with agg as (
	SELECT cust, min(quant) as minq, max(quant) as maxq, avg(quant)as avgq
	FROM sales
	GROUP BY cust)
		SELECT s.cust, a.minq, a.maxq, a.avgq, s.prod, s.date, s.state
		FROM agg a, sales s
		WHERE a.cust = s.cust AND a.minq = s.quant
			--SELECT m.cust, m.minq, m.maxq, m.avgq, s.p, s.d, s.s
			--FROM mini m, sales s
			--WHERE m.cust = s.cust AND m.maxq = s.q