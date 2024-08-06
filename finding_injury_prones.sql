select 
	p.first_name || ' ' || p.last_name full_name,
	pcr.height_in_inches,
	pcr.weight_in_pounds,
	pcr.bench_press_in_reps,
	pcr."position"
from 
	player_combine_results pcr
left join
	players p on
	pcr.player_id = p.id
where 
	(pcr.height_in_inches,
	pcr.weight_in_pounds,
	pcr.bench_press_in_reps) notnull
	
	and 
	pcr."position" = 'DB'
	and
	
	(pcr.height_in_inches,
	pcr.weight_in_pounds,
	pcr.bench_press_in_reps) > 
(
	select
		AVG(pcr.height_in_inches),
		AVG(pcr.weight_in_pounds),
		AVG(pcr.bench_press_in_reps)
	from
		player_injuries_history pi2
	left join
	player_combine_results pcr
			using(player_id)
	where
		pi2.status = 'QUESTIONABLE'
		and 
		
		(pcr.height_in_inches,
		pcr.weight_in_pounds,
		pcr.bench_press_in_reps) notnull
		and
		
		pcr."position" = 'DB'
	)

----------------------------------------------------------------------------------------------------------------

create table height_ranges(
	id SERIAL primary key,
	min INT,
	max INT
)
insert into height_ranges (
min, max)
values (65,70), (70,75),(75,81);

update height_ranges 
set max = 82
where id = 3


create table position_wise_injury(
	id SERIAL primary key,
	position VARCHAR(3),
	weight_in_pounds FLOAT,
	benchpress_in_reps INT,
	height_range_id INT,
	CONSTRAINT height_range_id
        FOREIGN KEY (height_range_id)
        references height_ranges(id)
);
drop table position_wise_injury 
insert
	into 
	position_wise_injury(
		"position" ,
		weight_in_pounds ,
		benchpress_in_reps,
		height_range_id
)
select
		pcr."position" ,
		AVG(pcr.weight_in_pounds),
		ROUND(AVG(pcr.bench_press_in_reps),
	0),
		hr.id
from
		player_injuries_history pi2
left join
	player_combine_results pcr
		using(player_id)
left join 
		height_ranges hr on
		(pcr.height_in_inches >= hr.min
		and pcr.height_in_inches < hr.max )
where
		pi2.status = 'OUT'
	and 
		(pcr.height_in_inches,
		pcr.weight_in_pounds,
		pcr.bench_press_in_reps) notnull
group by
		pcr."position",
	hr.id
order by 
		pcr."position",
	hr.id;


CREATE TABLE prevent_injury (
    id SERIAL PRIMARY KEY,
    player_id INT,
    full_name VARCHAR(50),
    increase_weight_by INT,
    increase_benchpress_reps_by INT ,
    position VARCHAR(3),
    CONSTRAINT player_id
        FOREIGN KEY (player_id)
        REFERENCES players(id)
);
drop table prevent_injury 

insert
	into
	prevent_injury (
	player_id,
	full_name,
	increase_weight_by ,
	increase_benchpress_reps_by,
	"position")

select  
	p.id,
	p.first_name || ' ' || p.last_name full_name,
	case 
		when pwi2.weight_in_pounds - pcr.weight_in_pounds > 0.0 then pwi2.weight_in_pounds - pcr.weight_in_pounds
		else 0.0
	end as increase_weight,
	case 
		when pwi2.benchpress_in_reps - pcr.bench_press_in_reps > 0 then pwi2.benchpress_in_reps - pcr.bench_press_in_reps
		else 0
	end as increase_benchpress,
	pcr."position" 
from 
	player_combine_results pcr
left join
	players p on
	pcr.player_id = p.id
left join 
	height_ranges hr on
	pcr.height_in_inches >= hr."min"
	and pcr.height_in_inches < hr."max"
left join 
	position_wise_injury pwi2 on
	pwi2."position" = pcr."position"
	and hr.id = pwi2.height_range_id
where 
	(pcr.weight_in_pounds,
	pcr.bench_press_in_reps) < (
	pwi2.weight_in_pounds ,
	pwi2.benchpress_in_reps 
	)
	
