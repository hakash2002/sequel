-----------financial insights-----------------
select 
	s."name" ,
	c."name" ,
	count(s.id) no_of_matches
from 
	games g
inner join stadiums s on
	s.id = g.stadium_id
inner join cities c on
	s.city_id = c.id
group by
	s."name",
	c."name"
order by 
	no_of_matches desc
	
select 
	f."name" ,
	sum(cdm.dead) dead_money,
	tsc.cap_space 
from
	franchises f
inner join contract_dead_money cdm on
	f.id = cdm.franchise_id
inner join team_salary_caps tsc on
	tsc.franchise_id = f.id 
group by 	
	f.id, tsc.cap_space 
order by 
	tsc.cap_space asc
	

----------------Max appearances of officials in each stadiums--------------------
with OfficialCounts as (
select 
			s."name" name,
		o.first_name || ' ' || o.last_name full_name,
	count(go2.id) official_counts
from 
	officials o
inner join
		game_officials go2 on
	go2.official_id = o.id
inner join 
		games g on
	go2.game_id = g.id
inner join 
		stadiums s on
	s.id = g.stadium_id
group by 
		s."name" ,
	o.id
order by
	s.name,
	official_counts desc
	)
	
select 
	name,
	full_name,
	official_counts
from
	OfficialCounts
where 
	(name,
	official_counts) in 
	(
	select
		name,
		max(official_counts)
	from
		OfficialCounts
	group by
		name)
	

----------------------Which grass causing more injuries------------------------


select
	gt."name" ,
	count(gt.id)
from 
	player_injuries_history pih
inner join
	contracts c on
	c.player_id = pih.player_id
	and c.start_year = extract (year
from
	pih.inserted_at) and pih.status in ('IR', 'INACTIVE', 'QUESTIONABLE', 'OUT')
	and pih.inserted_at notnull
inner join
	games g on
	g."start"::date = pih.inserted_at::date
	and c.franchise_id in (g.home_franchise_id, g.away_franchise_id)
inner join 
	stadiums s on
	s.id = g.stadium_id
left join 
	grass_types gt on
	gt.id = s.grass_type_id
group by 	
	gt.id
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
