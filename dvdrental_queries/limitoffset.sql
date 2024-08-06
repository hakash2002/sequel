select
	sbfc.category, sbfc.total_sales 
from
	sales_by_film_category sbfc
order by
	sbfc.total_sales desc 
limit 
	1
offset 
	1
	
select
	sbs.store, sbs.total_sales 
from
	sales_by_store sbs
order by
	sbs.total_sales desc
limit 2

select 
	a.first_name || ' ' || a.last_name as fullname
from
	 actor a
order by
	length(a.first_name) desc 
fetch first 10 rows only


