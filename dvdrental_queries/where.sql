select
	*
from
	actor a
where 
	a.last_update > '2013-05-26 14:47:57';

--------------------------------------------------

select
	*
from
	actor a
where
	LENGTH(a.first_name) > 7
	and LENGTH(A.last_name) > 7;
--------------------------------------------------

select
	*
from
	actor a
where
	a.first_name in ('Micheal')
--------------------------------------------------

select
	a.first_name
from
	actor a
where
	a.first_name like 'A%'
	and a.first_name like '%a';
--------------------------------------------------

select 
	first_name 
from
	actor a 
where 
	a.first_name like 'A%a_'
--------------------------------------------------

select 
	c.first_name 
from 
	payment p, customer c 
where 
	p.amount <> 0.99 

