-- Credit to http://www.dwhworld.com/2010/08/date-dimension-sql-scripts-mysql/
-- Small-numbers table

SET @start_date = '2002-01-01';
SET @end_date = '2006-12-31';

DROP TABLE IF EXISTS classicmodels_olap.numbers_small;
CREATE TABLE classicmodels_olap.numbers_small (number INT);
INSERT INTO classicmodels_olap.numbers_small VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

-- Main-numbers table
DROP TABLE IF EXISTS classicmodels_olap.numbers;
CREATE TABLE classicmodels_olap.numbers (number BIGINT);
INSERT INTO classicmodels_olap.numbers
SELECT thousands.number * 1000 + hundreds.number * 100 + tens.number * 10 + ones.number
FROM classicmodels_olap.numbers_small thousands, classicmodels_olap.numbers_small hundreds, classicmodels_olap.numbers_small tens, classicmodels_olap.numbers_small ones
LIMIT 1000000;

-- Create Date Dimension table
DROP TABLE IF EXISTS classicmodels_olap.date_d;
CREATE TABLE classicmodels_olap.date_d (
date_id          BIGINT PRIMARY KEY,
date             DATE NOT NULL,
year             INT,
month            CHAR(10),
month_of_year    CHAR(2),
day_of_month     INT,
day              CHAR(10),
day_of_week      INT,
weekend          CHAR(10) NOT NULL DEFAULT "Weekday",
day_of_year      INT,
week_of_year     CHAR(2),
quarter  INT,
previous_day     date ,
next_day         date ,
UNIQUE KEY `date` (`date`));

-- First populate with ids and Date
-- Change year start and end to match your needs. The above sql creates records for year 2010.
INSERT INTO classicmodels_olap.date_d (date_id, date)
SELECT year(DATE_ADD( @start_date, INTERVAL number DAY ))*10000+
month(DATE_ADD( @start_date, INTERVAL number DAY ))*100+
day(DATE_ADD( @start_date, INTERVAL number DAY ))date_id
, 

DATE_ADD( @start_date, INTERVAL number DAY )
FROM classicmodels_olap.numbers
WHERE DATE_ADD( @start_date, INTERVAL number DAY ) BETWEEN @start_date AND @end_date
ORDER BY number;
SET SQL_SAFE_UPDATES = 0;
-- Update other columns based on the date.
UPDATE classicmodels_olap.date_d SET
year            = DATE_FORMAT( date, "%Y" ),
month           = DATE_FORMAT( date, "%M"),
month_of_year   = DATE_FORMAT( date, "%m"),
day_of_month    = DATE_FORMAT( date, "%d" ),
day             = DATE_FORMAT( date, "%W" ),
day_of_week     = DAYOFWEEK(date),
weekend         = IF( DATE_FORMAT( date, "%W" ) IN ('Saturday','Sunday'), 'Weekend', 'Weekday'),
day_of_year     = DATE_FORMAT( date, "%j" ),
week_of_year    = DATE_FORMAT( date, "%V" ),
quarter         = QUARTER(date),
previous_day    = DATE_ADD(date, INTERVAL -1 DAY),
next_day        = DATE_ADD(date, INTERVAL 1 DAY);