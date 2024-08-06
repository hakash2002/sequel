select
	distinct
	c.first_name,
	c.last_name
from
	customer c
where 
	LENGTH(c.first_name) < LENGTH(C.last_name);
	
select 
	distinct on
	(rental_rate) rental_rate , rental_duration 
from
	film 
order by rental_rate asc ;

