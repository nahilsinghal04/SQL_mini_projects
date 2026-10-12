DROP TABLE IF EXISTS analytics_salary_data;

CREATE TABLE analytics_salary_data AS
SELECT
    TRIM(COALESCE(`Company Name`, 'Unknown Company')) AS company_name,
    TRIM(COALESCE(`Job Title`, 'Unspecified Role')) AS job_title,
    TRIM(COALESCE(`Location`, 'Remote / Unspecified')) AS location,
    COALESCE(`Salaries Reported`, 1) AS salaries_reported,
    CAST(REPLACE(REPLACE(REPLACE(SUBSTR(`Salary`, 2, INSTR(`Salary`, '/') - 2), ',', ''), ' ', ''), '₹', '') AS REAL) AS annual_salary_inr
FROM raw_salary_data;



SELECT
    company_name,
    job_title,
    location,
    annual_salary_inr,
    ROW_NUMBER() OVER(PARTITION BY location ORDER BY annual_salary_inr DESC) AS row_num,
    RANK() OVER(PARTITION BY location ORDER BY annual_salary_inr DESC) AS rank_val,
    DENSE_RANK() OVER(PARTITION BY location ORDER BY annual_salary_inr DESC) AS dense_rank_val
FROM analytics_salary_data
WHERE location IN ('Bangalore', 'Hyderabad')
LIMIT 10;



WITH LocationSummary AS (
    SELECT
        location,
        company_name,
        annual_salary_inr
    FROM analytics_salary_data
    WHERE location = 'Mumbai' AND annual_salary_inr > 0
    ORDER BY annual_salary_inr DESC
    LIMIT 5
)
SELECT
    company_name,
    annual_salary_inr,
    SUM(annual_salary_inr) OVER(ORDER BY annual_salary_inr DESC) AS running_total_payout,
    AVG(annual_salary_inr) OVER() AS mumbai_top5_avg_salary
FROM LocationSummary;



WITH TitleSalaries AS (
    SELECT
        company_name,
        job_title,
        annual_salary_inr,
        DENSE_RANK() OVER(PARTITION BY job_title ORDER BY annual_salary_inr DESC) AS salary_rank
    FROM analytics_salary_data
    WHERE job_title = 'Machine Learning Engineer'
)
SELECT
    company_name,
    annual_salary_inr,
    LAG(annual_salary_inr, 1) OVER(ORDER BY annual_salary_inr DESC) AS previous_higher_salary,
    (LAG(annual_salary_inr, 1) OVER(ORDER BY annual_salary_inr DESC) - annual_salary_inr) AS salary_gap_from_prev
FROM TitleSalaries
WHERE salary_rank <= 5;
