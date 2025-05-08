--Main SELECT

SELECT
full_name,
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
phone,
full_address,
job_title,
membership_date
FROM CLUB_MEMBERS;

--Testing martial_status

SELECT martial_status FROM club_members where martial_status != trim(martial_status);

SELECT count(martial_status) FROM club_members where martial_status IN ('separated');

SELECT DISTINCT martial_status FROM club_members;

WITH martial_testing AS (SELECT CASE 
    WHEN martial_status is null THEN 'n/a'
    WHEN martial_status = 'divored' THEN 'divorced'
    ELSE martial_status
    END as martial_status
FROM club_members) 
SELECT DISTINCT martial_status FROM martial_testing;

--Cleaning martial_status
SELECT CASE 
    WHEN martial_status is null THEN 'n/a'
    WHEN martial_status = 'divored' THEN 'divorced'
    ELSE martial_status
    END as martial_status
FROM club_members;


--Testing Age
SELECT age FROM club_members WHERE age <0 OR age > 100 OR age IS NULL; -- Discovered few nulls and values above 100

WITH age_test as (
SELECT CASE 
    WHEN age < 0 THEN null
    WHEN age > 100 THEN null
    ELSE age
    END as age
FROM CLUB_MEMBERS) 
SELECT age from age_test where age > 100 OR age < 0;


--Cleaing Age
SELECT CASE 
    WHEN age < 0 THEN null
    WHEN age > 100 THEN null
    ELSE age
    END as age
FROM CLUB_MEMBERS;


--Testing email

SELECT email FROM club_members WHERE email != trim(email);
SELECT email
FROM club_members 
    WHERE 
    email not like '%@%.%' OR
    email like '% %' OR 
    email like '%,%' OR 
    email like '%.@%';

--Cleaning Emial - Unecessery


