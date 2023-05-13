with 
count_installers as (
	select 
		count(*) as installers
	from user_data
),
get_first_last_insdt as (
	select 
		max(install_dt) as lastd,
		min(install_dt) as firstd
	from user_data
),
add_week AS (
    SELECT
    	*,
        cast((JULIANDAY(install_dt) - JULIANDAY("2021-01-01"))/7 as int) week
    FROM user_data
),
count_installers_by_week as (
	select
		min(install_dt),
		count(week) as ins_num
	from add_week
	group by week
)
select * from count_installers_by_week
