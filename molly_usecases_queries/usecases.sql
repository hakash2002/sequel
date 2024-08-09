-----1. Get a count of plays played in Stadium (Over all) and also get a info for which seasons a particular Stadiums a play has been played--------------

-----Info on no of plays played in the respective stadium for a particular play------------

create table teams_with_names (
    franchise_id INT,
    league_abbrevation VARCHAR(10),
    start_season INT,
    end_season INT,
    team_name VARCHAR(255)
);

insert into teams_with_names(franchise_id, league_abbrevation, start_season, end_season, team_name)
(select 
	t.franchise_id ,
	l.abbreviation as league_abbrevation,
	t.start_season ,
	t.end_season ,
	t.city || ' ' || t.nickname team_name
	from
		teams t
		left join franchises f on 
		t.franchise_id = f.id 
		left join leagues l on
		l.id = f.league_id 
	);

select 
	stadium_id,
	stadium_name,
	game_season,
	games_info,
	json_array_length(games_info) as games_count
from
	(
	select
			stadium_id,
			stadium_name,
			game_season,
			JSON_AGG(
	        JSON_BUILD_OBJECT(
	            'play_date',
			play_date,
			'home_team',
			home_team,
			'away_team',
			away_team,
			'league',
			league_abbrevation
		)) as games_info
	from
			(
		select
				s.id stadium_id,
				s."name" stadium_name,
				g.season_id game_season,
				g."start"::date play_date,
				(
			select
					team_name
			from
					teams_with_names
			where
					g.home_franchise_id = franchise_id
				and g.season_id between start_season and end_season
			) as home_team,
				(
			select
					team_name
			from
					teams_with_names
			where
					g.away_franchise_id = franchise_id
				and g.season_id between start_season and end_season
			) as away_team,
				(
			select
					league_abbrevation
			from
					teams_with_names
			where
					g.home_franchise_id = franchise_id
				and g.season_id between start_season and end_season
			) as league_abbrevation
		from
				stadiums s
		inner join 
			games g 
			on
				g.stadium_id = s.id)
	group by
		stadium_id,
		stadium_name,
		game_season
	order by
		stadium_name,
		game_season
	);
		-------	Count of plays played in a particular stadium all over the seasons---
		select
			s.id ,
			s."name",
			count(g.id) total_games_played
		from
			games g
			inner join stadiums s on g.stadium_id = s.id 
		group by
			s.id ,
			s."name" 
		order by
			total_games_played desc;
		
		
	-----3. Season wise player injury details --------------
	select
		player_id,
		player_fullname,
		injury_location,
		injury_category,
		injury_timing,
		injury_type,
		effective_start_of_injury,
		effective_end_of_injury,
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
				pid.effective_start effective_start_of_injury,
				pid.effective_end effective_end_of_injury,
				case
					when 
						extract(month from pid.effective_start) < 2
						or
						(extract(day from pid.effective_start) < 15
						and 
						extract(month from pid.effective_start) = 2)
					then 
						extract(year from pid.effective_start) - 1
					when 
						extract(month from pid.effective_start) > 2
					then 
						extract(year from pid.effective_start)
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
		)
		order by
			season;
