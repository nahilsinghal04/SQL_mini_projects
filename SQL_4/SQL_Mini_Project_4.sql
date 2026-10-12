DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS job_titles;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS companies;

-- Dimension Table 1: Companies
CREATE TABLE companies (
    company_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_name TEXT UNIQUE NOT NULL
);

-- Dimension Table 2: Locations
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    city_name TEXT UNIQUE NOT NULL
);

-- Dimension Table 3: Job Titles
CREATE TABLE job_titles (
    title_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title_name TEXT UNIQUE NOT NULL
);

-- Fact Table 4: Salaries (Relational Foreign Keys)
CREATE TABLE salaries (
    salary_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_id INTEGER NOT NULL,
    title_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    salaries_reported INTEGER NOT NULL,
    annual_salary_inr REAL NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (title_id) REFERENCES job_titles(title_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Populate Companies
INSERT OR IGNORE INTO companies (company_name)
SELECT DISTINCT TRIM(COALESCE(`Company Name`, 'Unknown Company')) FROM raw_salary_data;

-- Populate Locations
INSERT OR IGNORE INTO locations (city_name)
SELECT DISTINCT TRIM(COALESCE(`Location`, 'Remote / Unspecified')) FROM raw_salary_data;

-- Populate Job Titles
INSERT OR IGNORE INTO job_titles (title_name)
SELECT DISTINCT TRIM(COALESCE(`Job Title`, 'Unspecified Role')) FROM raw_salary_data;

-- Populate Salaries Fact Table via Primary-Foreign Key Mapping
INSERT INTO salaries (company_id, title_id, location_id, salaries_reported, annual_salary_inr)
SELECT
    c.company_id,
    j.title_id,
    l.location_id,
    COALESCE(r.`Salaries Reported`, 1),
    CAST(REPLACE(REPLACE(REPLACE(SUBSTR(r.`Salary`, 2, INSTR(r.`Salary`, '/') - 2), ',', ''), ' ', ''), '₹', '') AS REAL)
FROM raw_salary_data r
JOIN companies c ON TRIM(COALESCE(r.`Company Name`, 'Unknown Company')) = c.company_name
JOIN job_titles j ON TRIM(COALESCE(r.`Job Title`, 'Unspecified Role')) = j.title_name
JOIN locations l ON TRIM(COALESCE(r.`Location`, 'Remote / Unspecified')) = l.city_name;

SELECT
    c.company_name,
    j.title_name,
    l.city_name,
    s.salaries_reported,
    s.annual_salary_inr
FROM salaries s
INNER JOIN companies c ON s.company_id = c.company_id
INNER JOIN job_titles j ON s.title_id = j.title_id
INNER JOIN locations l ON s.location_id = l.location_id
ORDER BY s.annual_salary_inr DESC
LIMIT 5;



SELECT
    c.company_name,
    COUNT(DISTINCT s.location_id) AS total_cities_present,
    COUNT(s.salary_id) AS total_roles_offered,
    AVG(s.annual_salary_inr) AS avg_annual_salary
FROM companies c
LEFT JOIN salaries s ON c.company_id = s.company_id
GROUP BY c.company_name
HAVING total_roles_offered >= 3
ORDER BY avg_annual_salary DESC
LIMIT 5;



SELECT
    c.company_name,
    j1.title_name AS role_1,
    s1.annual_salary_inr AS salary_role_1,
    j2.title_name AS role_2,
    s2.annual_salary_inr AS salary_role_2,
    (s1.annual_salary_inr - s2.annual_salary_inr) AS salary_gap
FROM salaries s1
JOIN salaries s2 ON s1.company_id = s2.company_id AND s1.location_id = s2.location_id
JOIN companies c ON s1.company_id = c.company_id
JOIN job_titles j1 ON s1.title_id = j1.title_id
JOIN job_titles j2 ON s2.title_id = j2.title_id
WHERE j1.title_name = 'Data Scientist'
AND j2.title_name = 'Data Analyst'
ORDER BY salary_gap DESC
LIMIT 5;
