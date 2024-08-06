CREATE TABLE top_rated_films(
  title VARCHAR NOT NULL, 
  release_year SMALLINT
);

CREATE TABLE most_popular_films(
  title VARCHAR NOT NULL, 
  release_year SMALLINT
);

INSERT INTO top_rated_films(title, release_year) 
VALUES 
   ('The Shawshank Redemption', 1994), 
   ('The Godfather', 1972), 
   ('The Dark Knight', 2008),
   ('12 Angry Men', 1957);

INSERT INTO most_popular_films(title, release_year) 
VALUES 
  ('An American Pickle', 2020), 
  ('The Godfather', 1972), 
  ('The Dark Knight', 2008),
  ('Greyhound', 2020);
  
 select * from most_popular_films
 union all
 select * from top_rated_films
 
 select * from most_popular_films mpf 
 except
 select * from top_rated_films trf
 
select
	d2."franchise_id",
	coalesce(d2."mid_abbreviation",
	d2."nickname"),
	d2."city",
	d2."nickname",
	regexp_replace(regexp_replace(lower(d2."city" || '-' || d2."nickname"),
	' +',
	'-',
	'g'),
	'[^a-z0-9-]',
	'',
	'g'),
	s0."column_1",
	s0."column_2",
	f3."val",
	s0."column_4",
	s0."column_5",
	s0."column_6",
	s0."column_7",
	s0."column_8",
	s0."column_9",
	s0."column_10",
	s0."column_11",
	f4."val",
	s0."column_13",
	s0."column_14",
	f5."val",
	s0."column_16",
	f6."val",
	s0."column_18",
	f7."val",
	f8."val",
	s0."column_21",
	s0."column_22",
	s0."column_23",
	s0."column_24",
	f9."val",
	s0."column_26",
	s0."column_27",
	s0."column_28"
from
	(
	select
		coalesce(sum(coalesce(sk6."avoided_tackle", 0)),
		0) as "column_1",
		coalesce(sum(coalesce(sp7."avoided_tackle", 0)),
		0) as "column_2",
		count(distinct sk8."play_id") as "column_4",
		coalesce(max(sp9."yards"),
		0) as "column_5",
		count(distinct ss5."play_id") as "column_6",
		count(distinct sd10."play_id") as "column_7",
		count(distinct sk11."play_id") as "column_8",
		count(distinct sp12."play_id") as "column_9",
		coalesce(sum(coalesce(sp9."yards", 0)),
		0) as "column_10",
		count(distinct sp3."play_id") as "column_11",
		(coalesce((coalesce(count(sk13."id"),
		1) * coalesce(100,
		1)),
		0) - coalesce(sum(sk13."yard_line"),
		0)) as "column_13",
		count(distinct sk4."play_id") as "column_14",
		coalesce(sum(coalesce(sk14."yards", 0)),
		0) as "column_16",
		count(distinct sf15."play_id") as "column_18",
		count(distinct sf16."play_id") as "column_21",
		count(distinct sf17."id") as "column_22",
		count(distinct sf18."id") as "column_23",
		count(distinct sp19."play_id") as "column_24",
		coalesce(max(sk14."yards"),
		0) as "column_26",
		count(distinct sf20."play_id") as "column_27",
		count(distinct sp21."play_id") as "column_28",
		max(sd0."season_id") as "season",
		sd1."franchise_id" as "franchise_id"
	from
		"dm_plays" as sd0
	inner join "dm_rosters" as sd1 on
		sd0."game_id" = sd1."game_id"
	inner join "dm_leagues" as sd2 on
		sd2."id" = sd0."league_id"
	left outer join "punt_returning_return_attempts" as sp3 on
		(sd0."id" = sp3."play_id")
		and (sp3."player_id" = sd1."player_id")
	left outer join "kickoff_returning_return_attempts" as sk4 on
		(sd0."id" = sk4."play_id")
		and (sk4."player_id" = sd1."player_id")
	inner join "special_team_snaps" as ss5 on
		(sd0."id" = ss5."play_id")
		and (ss5."player_id" = sd1."player_id")
	left outer join "kickoff_returning_avoided_tackles" as sk6 on
		(sd0."id" = sk6."play_id")
		and (sk6."player_id" = sd1."player_id")
	left outer join "punt_returning_avoided_tackles" as sp7 on
		(sd0."id" = sp7."play_id")
		and (sp7."player_id" = sd1."player_id")
	left outer join "kickoff_returning_fair_catches" as sk8 on
		(sd0."id" = sk8."play_id")
		and (sk8."player_id" = sd1."player_id")
	left outer join "punt_returning_return_yards" as sp9 on
		(sd0."id" = sp9."play_id")
		and (sp9."player_id" = sd1."player_id")
	left outer join "dm_scores" as sd10 on
		(sd0."id" = sd10."play_id")
		and (sd10."type" = 'TD')
	left outer join "kickoff_returning_touchdowns" as sk11 on
		(sd0."id" = sk11."play_id")
		and (sk11."player_id" = sd1."player_id")
	left outer join "punt_returning_touchdowns" as sp12 on
		(sd0."id" = sp12."play_id")
		and (sp12."player_id" = sd1."player_id")
	left outer join "kickoff_returning_returned_to_locations" as sk13 on
		(sd0."id" = sk13."play_id")
		and (sk13."player_id" = sd1."player_id")
	left outer join "kickoff_returning_return_yards" as sk14 on
		(sd0."id" = sk14."play_id")
		and (sk14."player_id" = sd1."player_id")
	left outer join lateral (
		select
			play_id as id,
			play_id,
			player_id,
			return
		from
			punt_returning_return_snaps
		where
			play_id = sd0."id"
			and player_id = sd1."player_id"
	union
		select
			play_id as id,
			play_id,
			player_id,
			blocking
		from
			punt_returning_return_blocking_snaps
		where
			play_id = sd0."id"
			and player_id = sd1."player_id"
	union
		select
			play_id as id,
			play_id,
			player_id,
			vice
		from
			punt_returning_vice_snaps
		where
			play_id = sd0."id"
			and player_id = sd1."player_id"
	union
		select
			play_id as id,
			play_id,
			player_id,
			hold_up
		from
			punt_returning_hold_up_snaps
		where
			play_id = sd0."id"
			and player_id = sd1."player_id"
	union
		select
			play_id as id,
			play_id,
			player_id,
			rush
		from
			punt_returning_rush_snaps
		where
			play_id = sd0."id"
			and player_id = sd1."player_id"
)
 as sf15 on
		(sd0."id" = sf15."play_id")
		and (sf15."player_id" = sd1."player_id")
	left outer join lateral (
		select
			id,
			blocking,
			game_id,
			play_id,
			player_id,
			franchise_id
		from
			kickoff_returning_return_blocking_snaps
		where
			play_id = sd0."id"
			and player_id = sd1."player_id"
	union
		select
			id,
			return,
			game_id,
			play_id,
			player_id,
			franchise_id
		from
			kickoff_returning_return_snaps
		where
			play_id = sd0."id"
			and player_id = sd1."player_id")
 as sf16 on
		(sd0."id" = sf16."play_id")
		and (sf16."player_id" = sd1."player_id")
	left outer join "fumbles" as sf17 on
		((sd0."id" = sf17."play_id")
			and (sf17."player_id" = sd1."player_id"))
		and not (sp3."id" is null)
	left outer join "fumbles" as sf18 on
		((sd0."id" = sf18."play_id")
			and (sf18."player_id" = sd1."player_id"))
		and not (sk4."id" is null)
	left outer join "punt_returning_fair_catches" as sp19 on
		(sd0."id" = sp19."play_id")
		and (sp19."player_id" = sd1."player_id")
	left outer join lateral (
		select
			id,
			return,
			game_id,
			play_id,
			player_id,
			franchise_id
		from
			kickoff_returning_return_attempts
		where
			play_id = sd0."id"
			and player_id = sd1."player_id"
	union
		select
			id,
			return,
			game_id,
			play_id,
			player_id,
			franchise_id
		from
			punt_returning_return_attempts
		where
			play_id = sd0."id"
			and player_id = sd1."player_id")
 as sf20 on
		(sf20."player_id" = sd1."player_id")
		and (sd0."id" = sf20."play_id")
	left outer join "punt_returning_muffed_returns" as sp21 on
		(sd0."id" = sp21."play_id")
		and (sp21."player_id" = sd1."player_id")
	where
		((sd0."season_week" = $1)
			and ((sd2."abbreviation" = $2)
				and (sd0."game_id" = $3)))
	group by
		sd1."franchise_id") as s0
inner join "dm_franchises" as d1 on
	s0."franchise_id" = d1."id"
inner join "dm_teams" as d2 on
	((d2."franchise_id" = d1."id")
		and (d2."start_season" <= s0."season"))
	and (d2."end_season" >= s0."season")
inner join lateral (
	select
		coalesce(s0."column_1",
		0) + coalesce(s0."column_2",
		0) as val) as f3 on
	true
inner join lateral (
	select
		coalesce(ROUND(s0."column_10"::numeric / nullif(s0."column_11",
		0)::numeric,
		2),
		0)::float as val) as f4 on
	true
inner join lateral (
	select
		coalesce(ROUND(s0."column_13"::numeric / nullif(s0."column_14",
		0)::numeric,
		2),
		0)::float as val) as f5 on
	true
inner join lateral (
	select
		coalesce(ROUND(s0."column_2"::numeric / nullif(s0."column_11",
		0)::numeric,
		2),
		0)::float as val) as f6 on
	true
inner join lateral (
	select
		coalesce(ROUND(s0."column_1"::numeric / nullif(s0."column_14",
		0)::numeric,
		2),
		0)::float as val) as f7 on
	true
inner join lateral (
	select
		coalesce(ROUND(s0."column_16"::numeric / nullif(s0."column_14",
		0)::numeric,
		2),
		0)::float as val) as f8 on
	true
inner join lateral (
	select
		coalesce(s0."column_21",
		0) + coalesce(s0."column_18",
		0) as val) as f9 on
	true ["2023.1",
	"NFL",
	23796]




