--Purpose: Testing data columns in case of typos, missing data, invalid data etc.
--Results: Columns have been tested deeply to avoid incorrect data. 

--Testing Martial Status

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

--Testing Age

SELECT age FROM club_members WHERE age <0 OR age > 100 OR age IS NULL;

WITH age_test as (
SELECT CASE 
    WHEN age < 0 THEN null
    WHEN age > 100 THEN null
    ELSE age
    END as age
FROM CLUB_MEMBERS) 
SELECT age from age_test where age > 100 OR age < 0;

--Testing Email

SELECT email FROM club_members WHERE email != trim(email);
SELECT email
FROM club_members 
    WHERE 
    email not like '%@%.%' OR
    email like '% %' OR 
    email like '%,%' OR 
    email like '%.@%';

--Testing Phone

SELECT phone from CLUB_MEMBERS where phone != trim(phone);
select phone, length(phone) as phone_len from club_members where phone_len > 12 OR phone_len < 12 OR phone_len is null;

--Testing Full Address

select full_address from club_members;
select full_address from club_members where full_address != trim(full_address);

--Testing Full Name
SELECT full_name 
FROM club_members 
WHERE full_name != trim(full_name) OR full_name IS NULL OR NOT REGEXP_LIKE(full_name, '^[A-Z]');

WITH full_name_test AS (
SELECT CASE 
    WHEN SUBSTR(full_name, 3, 1) = '?' THEN TRIM(SUBSTR(INITCAP(full_name), 4))
    ELSE TRIM(INITCAP(full_name))
END as full_name
FROM club_members)
SELECT full_name
FROM full_name_test 
WHERE full_name != trim(full_name) OR full_name IS NULL OR REGEXP_LIKE(full_name, '^[A-Z]');


--Testing Job Title
SELECT job_title FROM club_members WHERE job_title != TRIM(job_title) OR job_title IS NULL;

--Testing Membership date
SELECT membership_date FROM club_members;
SELECT membership_date FROM club_members WHERE membership_date != TRIM(membership_date) OR membership_date IS NULL;


