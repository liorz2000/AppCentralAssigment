DROP TABLE IF EXISTS user_summary;

CREATE TABLE user_summary AS
SELECT 
    user_id,
    count(dt) as active_days,
    count(dt) as active_days2,
    sum(total_revenue) as total_revenue,
    sum(energy_used) energy_used,
    sum(quests_completed) as quests_completed
FROM daily_data
GROUP BY user_id;