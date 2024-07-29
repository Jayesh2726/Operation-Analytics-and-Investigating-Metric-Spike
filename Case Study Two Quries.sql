# Case Study 2 (Investigating Metric Spike)\
# 1.	Calculate the weekly user engagement?
SELECT Extract(week from occurred_at) as week_num,
count(DISTINCT user_id)
FROM events
group by week_num


# 2.	Calculate the user growth for product?

select Months,Users,ROUND(((Users/LAG(Users,1)OVER (ORDER BY Months) - 1)*100), 2) AS "Growth in %" 
FROM
(
SELECT EXTRACT(MONTH FROM created_at) AS Months, COUNT(activated_at) AS Users 
FROM users
WHERE activated_at NOT IN("") 
GROUP BY 1
ORDER BY 1
) sub;



# 3.	Calculate the weekly retention of users-sign up cohort?

select extract(week from occurred_at) as week, extract(year from occurred_at) as year, device,
count(distinct user_id) as count from events
where event_type='engagement'
group by 1,2,3
order by 1,2,3

# 4.	Calculate the weekly engagement per device?
SELECT *  from email_events;
select action from email_events group by action
select distinct action from email_events
select count(*) as count, action from email_events group by action

# 5.	Calculate the email engagement metrics?
SELECT
    100.0 * SUM(CASE WHEN email_category = 'email_open' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN email_category = 'email_sent' THEN 1 ELSE 0 END) AS open_rate,
    100.0 * SUM(CASE WHEN email_category = 'email_click' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN email_category = 'email_sent' THEN 1 ELSE 0 END) AS click_rate
FROM
(
    SELECT
        CASE
            WHEN action IN ('sent_weekly_digest', 'sent_reengagement_email') THEN 'email_sent'
            WHEN action = 'email_open' THEN 'email_open'
            WHEN action = 'email_clickthrough' THEN 'email_click'
            ELSE NULL
        END AS email_category
    FROM email_events
) a;
