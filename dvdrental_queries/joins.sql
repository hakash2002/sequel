create table bigbasket(
	a int primary key,
	fruit varchar(100) not null
);

create table sallbasket(
	b serial primary key,
	fruit varchar(100) not null
);

insert
	into
	bigbasket(
	a,
	fruit
)
values (1,
'orange'),
(2,
'lemon'),
(3,
'carrot')

insert
	into
	sallbasket(
	fruit
)
values (
'orange'),
(
'lemon'),
(
'carrot'),
(
'pineapple')

select
	b.a,
	b.fruit ,
	s.b ,
	s.fruit
from
	bigbasket b
inner join smallbasket s on
	b.fruit = s.fruit ;

select 
	s.b ,
	s.fruit ,
	b.a ,
	b.fruit
from
	smallbasket s
left join bigbasket b on
	s.fruit = b.fruit
	

select 
	b.a,
	b.fruit ,
	s.b ,
	s.fruit
from
	bigbasket b
right join
	smallbasket s on
	b.fruit = s.fruit;

select 
	b.a,
	b.fruit ,
	s.b ,
	s.fruit
from
	bigbasket b
full join
	smallbasket s on
	b.fruit = s.fruit;

select 
	c.first_name || ' ' || c.last_name , p.amount 
from
	customer c inner join payment p using(customer_id)
order by 
	p.amount desc, p.payment_date asc;
	

select 
	c.first_name , p.staff_id , s.staff_id 
from
	customer c inner join payment p using(customer_id) inner join staff s using(staff_id);

select 
	f.title , c."name" 
from
	film f left join film_category fc using(film_id) left join category c using(category_id)
order by
	f.title ;
	
select
	c.city , cc.country 
from
	city c natural LEFT JOIN country cc


	
	

	
	
	
	
	
	
	
	
	
	
	
	
	