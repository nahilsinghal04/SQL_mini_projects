DROP TABLE IF EXISTS cleaned_salary_data;

CREATE TABLE cleaned_salary_data AS
SELECT
    -- Handling Missing Values (COALESCE) & String Trimming (TRIM)
    TRIM(COALESCE(`Company Name`, 'Unknown Company')) AS company_name,
    TRIM(COALESCE(`Job Title`, 'Unspecified Role')) AS job_title,
    COALESCE(`Salaries Reported`, 1) AS salaries_reported,
    TRIM(COALESCE(`Location`, 'Remote / Unspecified')) AS location,
    `Salary` AS raw_salary_text,

    -- Extracting Pay Period Frequency using Pattern Matching (CASE + LIKE)
    CASE
        WHEN `Salary` LIKE '%/yr%' THEN 'Annual'
        WHEN `Salary` LIKE '%/mo%' THEN 'Monthly'
        WHEN `Salary` LIKE '%/hr%' THEN 'Hourly'
        ELSE 'Other'
    END AS pay_period,

    -- String Manipulation & Data Standardisation (Annualizing all pay rates to INR)
    CASE
        WHEN `Salary` LIKE '%/yr%'
            THEN CAST(REPLACE(REPLACE(REPLACE(SUBSTR(`Salary`, 2, INSTR(`Salary`, '/') - 2), ',', ''), ' ', ''), '₹', '') AS REAL)
        WHEN `Salary` LIKE '%/mo%'
            THEN CAST(REPLACE(REPLACE(REPLACE(SUBSTR(`Salary`, 2, INSTR(`Salary`, '/') - 2), ',', ''), ' ', ''), '₹', '') AS REAL) * 12
        WHEN `Salary` LIKE '%/hr%'
            THEN CAST(REPLACE(REPLACE(REPLACE(SUBSTR(`Salary`, 2, INSTR(`Salary`, '/') - 2), ',', ''), ' ', ''), '₹', '') AS REAL) * 2080
        ELSE 0
    END AS annualised_salary_inr

FROM raw_salary_data;



SELECT company_name, job_title, location, salaries_reported
FROM cleaned_salary_data
WHERE company_name = 'Unknown Company' OR location = 'Remote / Unspecified';



SELECT company_name, job_title, raw_salary_text, pay_period, annualised_salary_inr
FROM cleaned_salary_data
WHERE pay_period IN ('Monthly', 'Hourly')
LIMIT 5;



SELECT company_name, job_title, location, annualised_salary_inr, COUNT(*) AS duplicate_count
FROM cleaned_salary_data
GROUP BY company_name, job_title, location, annualised_salary_inr
HAVING duplicate_count > 1;
