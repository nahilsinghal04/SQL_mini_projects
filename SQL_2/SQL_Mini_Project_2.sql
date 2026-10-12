SELECT
    `Company Name`,
    `Job Title`,
    `Location`,
    `Salaries Reported`
FROM salary_dataset
WHERE `Location` IN ('Bangalore', 'Hyderabad')
AND `Job Title` LIKE '%Data Scientist%'
ORDER BY `Salaries Reported` DESC
LIMIT 5;


SELECT 
    "Location",
    COUNT(*) AS total_job_listings,
    SUM("Salaries Reported") AS total_salaries_reported,
    AVG("Salaries Reported") AS avg_reports_per_company
FROM salary_dataset
GROUP BY "Location"
HAVING total_job_listings > 10
ORDER BY total_salaries_reported DESC;