--Important note: The query was written in Snowflake SQL. Some functions may not work in other environments.

WITH temp_clean as (
SELECT
CASE 
    WHEN SUBSTR(full_name, 3, 1) = '?' THEN TRIM(SUBSTR(INITCAP(full_name), 4))
    ELSE TRIM(INITCAP(full_name))
END as full_name,
CASE 
    WHEN age < 0 THEN null
    WHEN age > 100 THEN null
    ELSE age
    END as age,
CASE 
    WHEN martial_status is null THEN 'n/a'
    WHEN martial_status = 'divored' THEN 'divorced'
    ELSE martial_status
    END as martial_status,
email,
IFNULL(phone, 'n/a') as phone,
LEFT(full_address, POSITION(',' IN full_address) - 1) as street,
LTRIM(SUBSTR(full_address, POSITION(',' IN full_address) + 1)) as city_state,
IFNULL(job_title, 'n/a') as job_title,
CASE 
    WHEN TO_DATE(membership_date, 'MM/DD/YYYY') < '2012-01-01' THEN NULL
    ELSE TO_DATE(membership_date, 'MM/DD/YYYY')
    END as membership_date
FROM CLUB_MEMBERS )
SELECT 
TRIM(LEFT(full_name, POSITION(' ' IN full_name) - 1)) AS first_name,
RTRIM(SUBSTR(full_name, POSITION(' ' IN full_name))) AS last_name, 
age, 
martial_status,
email,
phone,
street,
TRIM(LEFT(city_state, POSITION(',' IN city_state) - 1)) as city,
LTRIM(SUBSTR(city_state, POSITION(',' IN city_state) + 1)) as state,
job_title,
membership_date
FROM temp_clean;






--- Creating table from cleaning query

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.CLUB_MEMBERS_CLEANED AS
WITH cleaned AS (
    SELECT
    CASE 
        WHEN SUBSTR(full_name, 3, 1) = '?' THEN TRIM(SUBSTR(INITCAP(full_name), 4))
        ELSE TRIM(INITCAP(full_name))
    END as full_name,
    CASE 
        WHEN age < 0 THEN null
        WHEN age > 100 THEN null
        ELSE age
        END as age,
    CASE 
        WHEN martial_status is null THEN 'n/a'
        WHEN martial_status = 'divored' THEN 'divorced'
        ELSE martial_status
        END as martial_status,
    email,
    IFNULL(phone, 'n/a') as phone,
    LEFT(full_address, POSITION(',' IN full_address) - 1) as street,
    LTRIM(SUBSTR(full_address, POSITION(',' IN full_address) + 1)) as city_state,
    IFNULL(job_title, 'n/a') as job_title,
    CASE 
    WHEN TO_DATE(membership_date, 'MM/DD/YYYY') < '2012-01-01' THEN NULL
    ELSE TO_DATE(membership_date, 'MM/DD/YYYY')
    END as membership_date
    FROM CLUB_MEMBERS 
)
SELECT
TRIM(LEFT(full_name, POSITION(' ' IN full_name) - 1)) AS first_name,
RTRIM(SUBSTR(full_name, POSITION(' ' IN full_name))) AS last_name, 
age, 
martial_status,
email,
phone,
street,
TRIM(LEFT(city_state, POSITION(',' IN city_state) - 1)) as city,
LTRIM(SUBSTR(city_state, POSITION(',' IN city_state) + 1)) as state,
job_title,
membership_date
FROM cleaned;
