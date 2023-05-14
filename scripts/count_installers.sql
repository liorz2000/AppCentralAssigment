with 
count_installers as (
	select 
		count(*) as installers,
		sum(is_paying) as payers
	from user_data
),
get_first_last_insdt as (
	select 
		min(install_dt) as firstd,
		max(install_dt) as lastd,
		(SELECT min(install_dt)
		FROM user_data
		WHERE is_paying = 1) as firstd_pay,
		(SELECT MAX(install_dt)
		FROM user_data
		WHERE is_paying = 1) as lastd_pay
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
		count(week) as ins_num,
		sum(is_paying) as payers
	from add_week
	group by week
)
select * from count_installers_by_week
where count_installers_by_week."min(install_dt)" >= "2021-03-26"
