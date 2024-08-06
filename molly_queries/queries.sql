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
	f.id,
	tsc.cap_space
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
	pih.inserted_at)
	and pih.status in ('IR', 'INACTIVE', 'QUESTIONABLE', 'OUT')
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
	-------------------Player's franchise names in the past 10 years--------------

select
	p.first_name || ' ' || p.last_name as full_name,
	f."name",
	case
		when MIN(c.start_year) <> MAX(c.start_year)
		and sum(c.years) > 1 then
			MIN(c.start_year::text) || '-' || MAX(c.start_year)
		when MIN(c.start_year) = MAX(c.start_year) then
			MIN(c.start_year::text)
	end served_years
from
	contracts c
inner join 
    franchises f on
		c.franchise_id = f.id
left join
    players p on
		p.id = c.player_id
where
	c.year_signed between extract(year
from
		CURRENT_DATE) - 10 
	and extract(year
from
		CURRENT_DATE)
	and c.start_year <> 0
group by
		p.id,
		f."name"
order by
		p.id,
		served_years
	------------------Games with franchise names--------------
select 
	g."start",
	g.home_franchise_id,
	g.away_franchise_id,
	(
	select
		t.city || ' ' || t.nickname
	from
		franchises f,
		teams t
	where
		f.id = g.home_franchise_id
		and t.franchise_id = f.id
		and
		g.season_id between t.start_season and t.end_season
		) as home_team,
	(
	select
		t.city || ' ' || t.nickname
	from
		franchises f,
		teams t
	where
		f.id = g.away_franchise_id
		and t.franchise_id = f.id
		and
	g.season_id between t.start_season and t.end_season) as away_team
from
	games g
inner join 
	franchises f on
	g.home_franchise_id = f.id
	---------------Given a game id find the players played----------------
with gamedetails as (
	select 
		"start",
		home_franchise_id,
		away_franchise_id,
		season_id seasonid
	from
		games
	where 
		id = 4358
)

select 
	p.first_name || ' ' || p.last_name full_name,
	ps."position" ,
	'HOME' team_type,
	f.name
from
	team_members tm
inner join gamedetails on
	home_franchise_id = tm.franchise_id
inner join 
	players p on
	p.id = tm.player_id
inner join 
	player_seasons ps on
	p.id = ps.player_id
	and ps.season_id = seasonid
inner join 
	franchises f on
	f.id = tm.franchise_id
where 
	"start" between tm.effective_start and tm.effective_end
order by 
	team_type,
	ps."position"
union 
select 
	p.first_name || ' ' || p.last_name full_name,
	ps."position" ,
	'AWAY' team_type,
	f.name
from
	team_members tm
inner join gamedetails on
	away_franchise_id = tm.franchise_id
inner join 
	players p on
	p.id = tm.player_id
inner join 
	player_seasons ps on
	p.id = ps.player_id
	and ps.season_id = seasonid
inner join 
	franchises f on
	f.id = tm.franchise_id
where 
	"start" between tm.effective_start and tm.effective_end
order by
	team_type,
	ps."position"
	
	
	
	
	
	
	
	
	
	
