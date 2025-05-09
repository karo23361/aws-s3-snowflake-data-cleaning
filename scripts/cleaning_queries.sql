--Purpose: Cleaning data to get rid of missing, incorrect values etc.
--Results: Data is clean and ready to deploy for data analyst.

--Cleaning martial_status

SELECT CASE 
    WHEN martial_status is null THEN 'n/a'
    WHEN martial_status = 'divored' THEN 'divorced'
    ELSE martial_status
    END as martial_status
FROM club_members;

--Cleaing Age

SELECT CASE 
    WHEN age < 0 THEN null
    WHEN age > 100 THEN null
    ELSE age
    END as age
FROM CLUB_MEMBERS;

--Cleaning Emial - Unecessery

--Cleaning Phone 

select 
    IFNULL(phone, 'n/a')
from club_members;

--Cleaning Full Address 

SELECT LEFT(full_address, POSITION(',' IN full_address) - 1) as street FROM club_members;

WITH state_cte AS (SELECT 
    LTRIM(SUBSTR(full_address, POSITION(',' IN full_address) + 1)) as city_state
FROM club_members)
SELECT LTRIM(SUBSTR(city_state, POSITION(',' IN city_state) + 1)) as state FROM state_cte;

WITH state_cte AS (SELECT 
    LTRIM(SUBSTR(full_address, POSITION(',' IN full_address) + 1)) as city_state
FROM club_members)
SELECT TRIM(LEFT(city_state, POSITION(',' IN city_state) - 1)) as city FROM state_cte;

--Cleaning Full_name

SELECT CASE 
    WHEN SUBSTR(full_name, 3, 1) = '?' THEN TRIM(SUBSTR(INITCAP(full_name), 4))
    ELSE TRIM(INITCAP(full_name))
END as full_name
FROM club_members;

WITH temp_clean_full_name AS (
SELECT CASE 
    WHEN SUBSTR(full_name, 3, 1) = '?' THEN TRIM(SUBSTR(INITCAP(full_name), 4))
    ELSE TRIM(INITCAP(full_name))
END as full_name
FROM club_members) 
SELECT RTRIM(SUBSTR(full_name, POSITION(' ' IN full_name))) AS last_name, TRIM(LEFT(full_name, POSITION(' ' IN full_name) - 1)) AS first_name FROM temp_clean_full_name;

--Cleaning Job Title

SELECT 
IFNULL(job_title, 'n/a')
FROM club_members;

--Cleaning Membership Date

SELECT 
TO_DATE(membership_date, 'MM/DD/YYYY') as membership_date
FROM club_members;

