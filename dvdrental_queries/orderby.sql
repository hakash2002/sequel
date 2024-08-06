select
	*
from
	customer c
order by
	c.first_name desc, c.last_name asc 
	
select 
	first_name , LENGTH(first_name) len
from
	customer
order by
	len desc