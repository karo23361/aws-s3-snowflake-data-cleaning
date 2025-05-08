create or replace storage integration s3_integr
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = ''
  STORAGE_ALLOWED_LOCATIONS = ('s3://<your-bucket-name>/<your-path>/')
   COMMENT = 'Snowflake Interation' ;

DESC integration s3_integr;

CREATE OR replace TABLE OUR_FIRST_DB.PUBLIC.CLUB_MEMBERS(
    full_name varchar(50),
    age int,
    martial_status varchar(50),
    email varchar(50),
    phone varchar(50),
    full_address varchar(150),
    job_title varchar(50),
    membership_date varchar(50)
);


CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_f_format
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"';


CREATE OR REPLACE stage MANAGE_DB.external_stages.csv_club
    URL = 's3://snowflakeminiprojekt231/data/'
    STORAGE_INTEGRATION = s3_integr
    FILE_FORMAT = MANAGE_DB.file_formats.CSV_F_FORMAT;

LIST @MANAGE_DB.external_stages.csv_club;


COPY INTO OUR_FIRST_DB.PUBLIC.CLUB_MEMBERS
    FROM @MANAGE_DB.external_stages.csv_club;
