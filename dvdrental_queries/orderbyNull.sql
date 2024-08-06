create table somerandom(
	a int
);

insert
	into
	somerandom (a)
values 
(1),
(2),
(3),
(null);

select
	a
from
	somerandom s
order by 
	a nulls first;

drop  table somerandom ;

