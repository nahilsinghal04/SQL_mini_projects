-- 1. Create Table & Insert Data
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    department TEXT NOT NULL,
    salary REAL NOT NULL,
    hire_date DATE NOT NULL,
    performance_rating TEXT DEFAULT 'Meets Expectations'
);

INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('Rohan', 'Sharma', 'Engineering', 75000.00, '2021-03-15'),
('Priya', 'Verma', 'HR', 55000.00, '2020-06-20'),
('Amit', 'Patel', 'Engineering', 85000.00, '2019-01-10'),
('Neha', 'Gupta', 'Marketing', 62000.00, '2022-08-01'),
('Siddharth', 'Singh', 'Finance', 90000.00, '2018-11-12'),
('Ananya', 'Rao', 'Engineering', 80000.00, '2021-07-19'),
('Vikas', 'Kumar', 'HR', 50000.00, '2023-02-10');

-- 2. Aggregation by Department
SELECT
    department,
    COUNT(employee_id) AS total_employees,
    AVG(salary) AS average_salary,
    SUM(salary) AS total_department_payout
FROM employees
GROUP BY department
ORDER BY average_salary DESC;

-- 3. High Paying Departments
SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING average_salary > 60000;

-- 4. Salary Categorization
SELECT
    employee_id,
    first_name || ' ' || last_name AS full_name,
    department,
    salary,
    CASE
        WHEN salary >= 85000 THEN 'High Tier'
        WHEN salary >= 60000 THEN 'Mid Tier'
        ELSE 'Entry Tier'
    END AS salary_bracket
FROM employees
ORDER BY salary DESC;