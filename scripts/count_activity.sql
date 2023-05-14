with
life_data as (
	select 
		user_id,
		count(dt) as active_days,
		sum(total_revenue) as total_revenue,
		sum(energy_used) energy_used,
		sum(quests_completed) as quests_completed
	from daily_data
	group by user_id
),
active_days_grouped as (
	select
		active_days,
		count(user_id) as players
	from life_data
	group by 1
	order by 1
),
active_days_grouped_plus as (
	select
		adgp1.active_days active_days,
		adgp1.players players_played_x,
		sum(adgp2.players) players_played_at_least_x,
		cast(100 as float) * sum(adgp2.players)/2319 as  "players_played_at_least_x%"
	from active_days_grouped adgp1
	join active_days_grouped adgp2 on True
		and adgp2.active_days >= adgp1.active_days
	group by 1
)
select * from active_days_grouped_plus
