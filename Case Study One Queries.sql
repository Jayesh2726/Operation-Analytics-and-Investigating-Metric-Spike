# Case Study 1 (Job Data)
#  1 Calculate the number of jobs reviewed per hour per day for November 2020?
SELECT ds AS Dates,ROUND((COUNT(job_id)/SUM(time_spent))*3600) AS "Jobs Reviewed per Hour per Day"
from job_data
where ds between'2020-11-01' and '2020-11-30'
group by ds;

# 2. Calculate 7 day rolling average of throughput? For throughput, do you prefer daily metric or 7-day rolling and why?
SELECT ROUND(COUNT(event)/sum(time_spent),2)as "Weekly Throughput" from job_data;

SELECT ds AS Dates, ROUND(COUNT(event)/SUM(time_spent), 2) AS "Daily Throughput" FROM job_data
GROUP BY ds ORDER BY ds;

# 3.	Calculate the percentage share of each language in the last 30 days?
SELECT language AS Languages, ROUND(100 * COUNT(*)/total, 2) AS Percentage, sub.total
FROM job_data
CROSS JOIN (SELECT COUNT(*) AS total FROM job_data) AS sub
GROUP BY language, sub.total;

# 4.Let’s say you see some duplicate rows in the data. How will you display duplicates from the table?
SELECT actor_id, COUNT(*) AS Duplicates FROM job_data
GROUP BY actor_id HAVING COUNT(*) > 1;
