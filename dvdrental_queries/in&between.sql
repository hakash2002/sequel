select
	p.payment_id ,
	p.payment_date
from 
	payment p
where 
	p.payment_date::time between '22:25:46' AND '23:00:00';
	
select 
	fl.title, fl.description, fl.category 
from
	film_list fl 
where 
	fl.category in ('Sports','Action','Sci-fi');
	
select 
	*
from
	address a
where 
	(a.city_id between 22 and 150)
	and a.postal_code::integer between 30000 and 50000