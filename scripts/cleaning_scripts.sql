--The Main structure of main SQL query 

SELECT
full_name,
age,
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

