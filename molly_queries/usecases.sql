-----1. Get a count of plays played in Stadium (Over all) and also get a info for which seasons a particular Stadiums a play has been played--------------

-----Info on no of plays played in the respective stadium for a particular play------------
create table season_wise_stadium_stats(
	stadium_id INT,
	name VARCHAR(100),
	season_id INT,
	no_of_games_played INT,
	primary key (stadium_id,
season_id ),
	constraint stadium_id
		foreign key (stadium_id)
		references stadiums(id)
);

insert
	into
	season_wise_stadium_stats(stadium_id,
	name,
	season_id,
	no_of_games_played)

select 
	s.id ,
	s."name" ,
	g.season_id ,
	count(g.id) no_of_games_played
from
	stadiums s
inner join 
	games g 
	on 
	g.stadium_id = s.id
group by 
	s.id ,
	g.season_id
order by 
	s."name" ,
	g.season_id
	
	-------	Count of playes played in a particular stadium all over the seasons---
select 
	stadium_id,
	name,
	sum(no_of_games_played) total_games_played
from
	season_wise_stadium_stats
group by
	stadium_id,
	name
order by 
	total_games_played desc
	
	-----3. Season wise player injury details --------------
select 
	player_id,
	player_fullname,
	injury_location,
	injury_category,
	injury_timing,
	injury_type,
	season
from
	(
	select  
		pid.player_id player_id, 
		p.first_name || ' ' || p.last_name player_fullname,
		ilt."name" injury_location,
		ict."name" injury_category,
		itt."name" injury_timing,
		it."name" injury_type,
		case 
			when extract(month
		from
			pid.effective_start) < 2
			or(extract(day
		from
			pid.effective_start) < 15
			and extract(month
		from
			pid.effective_start) = 2)
			then extract(year
		from
			pid.effective_start) - 1
			when extract(month
		from
			pid.effective_start) > 2
			then extract(year
		from
			pid.effective_start)
		end as season
	from 
		player_injury_details pid
	left join 
		players p 
		on
		pid.player_id = p.id
	left join 
		injury_location_types ilt 
		on
		pid.injury_location_type_id = ilt.id
	left join 
		injury_category_types ict 
		on
		ict.id = pid.injury_category_type_id
	left join 
		injury_timing_types itt 
		on
		itt.id = pid.injury_timing_type_id
	left join 
		injury_types it 
		on
		it.id = pid.injury_type_id
	where not
		(extract(month
	from
		pid.effective_start ) > 3
		and extract(month
	from
		pid.effective_end ) < 9
		and extract(year
	from
		pid.effective_start ) = extract(year
	from
		pid.effective_end ))
	)
order by
	season
		
		
	
