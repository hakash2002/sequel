select 
	c."name" , count(fc.film_id)
from 
	film_category fc join category c using(category_id)

group by
	c.category_id 
	
select 
	c.first_name ,
	sum(p.amount)
from
	customer c ,
	payment p
where 
	c.customer_id = p.customer_id
group by
	c.customer_id
order by 
	sum desc
	
select 
	s.first_name ,
	sum(p.amount)
from
	staff s ,
	payment p
where 
	s.staff_id = p.staff_id 
group by 
	s.staff_id 
	

select 
	extract (month from p.payment_date) m, sum(p.amount)
from
	payment p 
group by
	m
order by 
	m 
	
select
	l."name" , sum(f.rental_rate)
from 
	"language" l , film f 
where
	l.language_id = f.language_id 
group by	
	l.language_id 
	
select 
	f.rating , count(r.rental_id), sum(f.rental_rate)
from
	rental r , inventory i, film f
where 
	r.inventory_id = i.inventory_id and i.film_id = f.film_id 
group by
	f.rating 
order by 
	count desc
	
select 
	f.title , count(r.rental_id), sum(f.rental_rate)
from
	rental r , inventory i, film f
where 
	r.inventory_id = i.inventory_id and i.film_id = f.film_id 
group by
	f.title 
order by 
	sum desc
	
	