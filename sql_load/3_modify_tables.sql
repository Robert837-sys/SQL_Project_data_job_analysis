/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM '[Insert File Path]/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


\copy skills_dim FROM '[Insert File Path]/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM '[Insert File Path]/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy job_postings_fact FROM 'C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\job_postings_fact.csv

\copy skills_job_dim FROM '[Insert File Path]/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy skills_job_dim FROM 'C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\skills_job_dim.csv

*/

-- NOTE: This has been updated from the video to fix issues with encoding

COPY company_dim
FROM 'C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\Administrator\Desktop\Data_Nerd\SQL_Project_data_job_analysis\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- DateTime in sql
-- ::(double colon will be used for casting meaning converting a value from one data type to another)
-- e.g., ::DATE converts a value to Date Format YYYY-MM-DD
SELECT job_posted_date 
FROM job_postings_fact
LIMIT 10

SELECT '2025-11-9'::DATE,
        '123'::INTEGER,
        'true'::BOOLEAN,
        '3.14'::REAL;

SELECT 
    job_title_short AS title,
    job_location AS location,
    --job_posted_date::DATE AS date
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS Year 
FROM job_postings_fact
LIMIT 5;
-- AT TIME ZONE- Converts timestamps between different time zones
-- e.g., SELECT 
--             column_name AT TIME ZONE 'EST'
--              column_name AT TIME ZONE 'UTC' AT TIME ZONE 'EST' Converts from one time zone to another
--             FROM table_name;
-- Extract- gets field(e.g., year,month,day) from a date/time value
-- e.g., SELECT 
--          EXTRACT(MONTH FROM column_name) AS column_month
--       FROM table_name
SELECT
    COUNT(job_id) AS number_of_jobs,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE job_title_short='Data Scientist'
GROUP BY month
ORDER BY number_of_jobs DESC;

SELECT 
    job_schedule_type,
    AVG(salary_year_avg),
    AVG(salary_hour_avg)
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

SELECT
    COUNT(job_id),
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS month
    
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') = 2023
GROUP BY month,date_time
ORDER BY month

SELECT c.name
FROM job_postings_fact AS jb
INNER JOIN company_dim AS c ON jb.company_id=c.company_id
WHERE   
        jB.job_health_insurance = TRUE AND 
        EXTRACT(YEAR FROM jb.job_posted_date) = 2023 AND 
        EXTRACT(QUARTER FROM jb.job_posted_date) = 2;
-- January
CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1;
-- February
CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- April
CREATE TABLE april_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

-- May
CREATE TABLE may_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

-- June
CREATE TABLE june_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 6;

-- July
CREATE TABLE july_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 7;

-- August
CREATE TABLE august_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 8;

-- September
CREATE TABLE september_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 9;

-- October
CREATE TABLE october_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 10;

-- November
CREATE TABLE november_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 11;

-- December
CREATE TABLE december_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 12;

SELECT *
FROM january_jobs;

-- CASE Expression in SQL is a way to apply conditional logic within your SQL queries
/*
e.g., 
SELECT 
    CASE
        WHEN column_name = 'value1' THEN 'Description for value1'
        WHEN column_name = 'value2' THEN 'Description for value2'
        ELSE 'Other'
    END AS column_description
FROM table_name;
*/
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location ='Anywhere' THEN 'Remote' 
        WHEN job_location ='New York, NY' THEN 'Local' 
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short='Data Analyst'
GROUP BY location_category;

SELECT *
FROM job_postings_fact
ORDER BY salary_year_avg DESC
;


SELECT 
    job_title_short,
    company_id,
    job_location,
    job_posted_date,
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 60000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 60000 AND 100000 THEN 'Standard'
        WHEN salary_year_avg > 100000 THEN 'High'
        ELSE 'Not Specified'
    END AS salary_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;
/* 
Subqueries and CTEs
Subqueries and Common Table Expressions (CTEs): Used for organizing and simplifying
complex queries.
-- Helps break down query into smaller, more manageable parts
-- When to use one over the other?
    -- Subqueries are for simpler queries
    -- CTEs are for more complex queries
SELECT *
FROM (
    SELECT * 
    FROM job_postings_fact 
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
) AS january_jobs
-- Subquery ends here
CTEs 
WITH january_jobs AS (
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
) --CTE definition ends here
SELECT *
FROM january_jobs
*/

SELECT *
FROM (
    SELECT * 
    FROM job_postings_fact 
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
) AS january_jobs

WITH january_jobs AS (
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
) --CTE definition ends here
SELECT *
FROM january_jobs

SELECT name as company_name,
        company_id
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE 
        job_no_degree_mention=True
)
WITH company_job_count AS(
    SELECT 
    company_id,
    COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS company_name,company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id=company_dim.company_id
ORDER BY total_jobs DESC

WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id=skills_to_job.job_id
    WHERE job_postings.job_work_from_home=True 
    GROUP BY skill_id
)
SELECT
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id=remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5

/*
UNION Operators
Combine result sets of 2 or more SELECT statements into a single result set.
UNION:Remove duplicate rows 
UNION ALL: Includes all duplicate rows
N/B: Each SELECT statement within the UNION must have the same number of columns in the result sets with similar data types.
*/
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs



SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

SELECT *
FROM job_postings_fact
LIMIT 5

SELECT *
FROM skills_dim
LIMIT 5

SELECT *
FROM skills_job_dim
LIMIT 5

SELECT 
    skills,
    type
FROM skills_dim
LIMIT 5

-- Get skills and skill types for each job in Q1 with salary > $70,000
-- Include jobs without any skills using UNION

-- Q1 includes January, February, and March

SELECT
    job_postings_fact.job_id,
    skills_dim.skill_id,
    skills_dim.skills,
    skills_dim.type
FROM job_postings_fact
LEFT JOIN job_postings_skills
    ON job_postings_fact.job_id = job_postings_skills.job_id
LEFT JOIN skills_dim
    ON job_postings_skills.skill_id = skills_dim.skill_id
WHERE EXTRACT(MONTH FROM job_postings_fact.job_posted_date) IN (1, 2, 3)
  AND salary_year_avg > 70000

UNION

-- Include jobs without any matching skill entries
SELECT
    job_postings_fact.job_id,
    NULL AS skill_id,
    NULL AS skills,
    NULL AS type
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_postings_fact.job_posted_date) IN (1, 2, 3)
  AND salary_year_avg > 70000
  AND job_id NOT IN (
      SELECT job_id FROM job_postings_skills
  )
ORDER BY job_id;

SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)AS quarter1_job_postings
WHERE 
    quarter1_job_postings.salary_year_avg>70000 AND quarter1_job_postings.job_title_short='Data Analyst'
ORDER BY 
    quarter1_job_postings.salary_year_avg DESC
