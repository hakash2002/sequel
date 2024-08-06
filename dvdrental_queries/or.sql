select
	fl.title , fl.category 
from 
	film_list fl 
where 
	fl.category = 'Action' or fl.category = 'Family';
	
select 
	nbsfl.title ,
	nbsfl.rating,
	nbsfl.actors ,
	nbsfl.price
from
	nicer_but_slower_film_list nbsfl
where 
	nbsfl.actors like '%JohnnyLollobrigida%'
	or nbsfl.actors like '%WoodyJolie%'

select 
	fl.title , fl.description 
from
	film_list fl 
where 
	fl.description ilike '%unbelieveable%'
	