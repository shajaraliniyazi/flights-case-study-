create database flights;
--  1. Find the month with most number of flights
SELECT MONTHNAME(Date_of_Journey) as 'months' , Airline, count(*) from  flights
group by months
order by count(*)  desc limit 1;

-- 2. Which week day has most costly flights

 Which week day has most costly flights;
 select dayname(Date_of_Journey) as 'weekday', avg(price) as 'avg_price' from flights
 group by weekday
 order by avg_price desc limit 1;


-- 3. Find number of indigo flights every month
 select Airline,    monthname(Date_of_Journey) as 'months'  ,count(*) as no_of_flight
 from flights
 where Airline='IndiGo'
 group by Airline,months;

-- 4. Find list of all flights that depart between 10AM and 2PM from banglore to
-- delhi
 SELECT * FROM flights
 WHERE Source= 'Banglore' and Destination= 'Delhi'
 and Dep_Time > '10:00:00' and dep_Time < '14:00:00';
 
 
-- 5. Find the number of flights departing on weekends from Bangalore
SELECT count(*) FROM flights
WHERE source= 'banglore'
AND DAYNAME(Date_of_Journey) in ('saturday','sunday');

-- 6. Calculate the arrival time for all flights by adding the duration to the departure
  -- time.
  
  ALTER TABLE flights ADD COLUMN departure DATETIME;
UPDATE flights
SET departure = STR_TO_DATE(CONCAT(date_of_journey,' ',dep_time),'%Y-%m-%d %H:%i' );
ALTER TABLE flights
ADD COLUMN duration_mins INTEGER,
ADD COLUMN arrival DATETIME;
SELECT Duration,
REPLACE(SUBSTRING_INDEX(duration,' ',1),'h','')*60 +
CASE
WHEN SUBSTRING_INDEX(duration,' ',-1) = SUBSTRING_INDEX(duration,' ',1) THEN 0
ELSE REPLACE(SUBSTRING_INDEX(duration,' ',-1), 'm','')
END AS 'mins'
FROM flights;
select * from flights;
UPDATE flights
SET duration_mins = 
    CASE 
        WHEN duration LIKE '%h%m%' THEN 
            CAST(REPLACE(SUBSTRING_INDEX(duration, ' ', 1), 'h', '') AS UNSIGNED) * 60 +
            CAST(REPLACE(SUBSTRING_INDEX(duration, ' ', -1), 'm', '') AS UNSIGNED)
        WHEN duration LIKE '%h' THEN 
            CAST(REPLACE(duration, 'h', '') AS UNSIGNED) * 60
        WHEN duration LIKE '%m' THEN 
            CAST(REPLACE(duration, 'm', '') AS UNSIGNED)
        ELSE NULL
    END;
    select * from flights;
    
    --  so here i add 2 columns one is departue it contain date and time in standard fromat and another is duration_min wehere i convert duration into minutes for the purpose of effectiveness and efficinecy 
    
   ALTER TABLE flights DROP COLUMN arrival;

ALTER TABLE flights ADD COLUMN arrival DATETIME;

UPDATE flights
SET arrival = DATE_ADD(departure, INTERVAL duration_mins MINUTE)
WHERE departure IS NOT NULL AND duration_mins IS NOT NULL;


  -- Q6 Calculate the arrival time for all flights by adding the duration to the departure
  -- time.
     select time(arrival), airline from flights;
    

-- 7. Calculate the arrival date for all the flights
SELECT DATE(arrival) FROM flights;


-- 8. Find the number of flights which travel on multiple dates.
SELECT COUNT(*) FROM flights
WHERE DATE(Departure) != date(arrival);


-- 9. Calculate the average duration of flights between all city pairs.
select source,destination,
time_format(sec_to_time(avg(duration_mins)*60),'%kh:%im') 
as avg_time_duration  from flights
group by source,destination ;

-- 10. Find all flights which departed before midnight but arrived at their destination

-- after midnight having only 0 stop.
SELECT * FROM flights
where Total_Stops= 'non-stop'
and
date(departure) < date(arrival);


-- 11. Find quarter wise number of flights for each airline

SELECT airline, quarter(departure) as 'q_time' , count(*) as 'no_of_flights'
from flights
group by airline, quarter(departure) ;

-- 12. Find the longest flight distance(between cities in terms of time) in India


SELECT  airline , avg(duration_mins)
from flights
group by airline
order by avg(duration_mins) desc limit 1;

-- 13. Average time duration for flights that have 1 stop vs more than 1 stops

with temp_table as (
SELECT *, 
CASE 
WHEN Total_Stops = 'non-stop' then 'non-stop'
else 'with-stops'
end as 'temp'
from flights)
select temp,time_format(sec_to_time(avg(duration_mins)*60),'%kh:%im') 
as avg_time_duration from temp_table
group by  temp;

-- 14. Find all Air India flights in a given date range example(   2019- 1st march to 10th march)  originating from Delhi
SELECT * FROM flights
WHERE Source ='delhi' and 
date(departure)  between '2019-03-01' and '2019-03-10';

-- 15. Find the longest flight of each airline
select airline, max(duration) as journey_time 
from flights
group by Airline;

-- 16. Find all the pair of cities having average time duration > 3 hours
SELECT source , destination , time_format(sec_to_time(avg(duration_mins)*60),'%kh:%im') 

from flights
group by source , destination
having avg(duration_mins) >180;

-- 17. Make a weekday vs time grid showing frequency of flights from Banglore and
-- Delhi
SELECT DAYNAME(departure),
SUM(CASE WHEN HOUR(departure) BETWEEN 0 AND 5 THEN 1 ELSE 0 END) AS '12AM - 6AM',
SUM(CASE WHEN HOUR(departure) BETWEEN 6 AND 11 THEN 1 ELSE 0 END) AS '6AM - 12PM',
SUM(CASE WHEN HOUR(departure) BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS '12PM - 6PM',
SUM(CASE WHEN HOUR(departure) BETWEEN 18 AND 23 THEN 1 ELSE 0 END) AS '6PM - 12PM'
FROM flights
WHERE source = 'Banglore' AND destination = 'Delhi'
GROUP BY DAYNAME (departure)
ORDER BY DAYOFWEEK(departure) ASC;

-- 18. Make a weekday vs time grid showing avg flight price  of flights from Banglore and
-- Delhi

SELECT DAYNAME(departure),
avg(CASE WHEN HOUR(departure) BETWEEN 0 AND 5 THEN Price ELSE null END) AS '12AM - 6AM',
avg(CASE WHEN HOUR(departure) BETWEEN 6 AND 11 THEN Price ELSE null END) AS '6AM - 12PM',
avg(CASE WHEN HOUR(departure) BETWEEN 12 AND 17 THEN Price ELSE null END) AS '12PM - 6PM',
avg(CASE WHEN HOUR(departure) BETWEEN 18 AND 23 THEN Price ELSE null END) AS '6PM - 12PM'
FROM flights
WHERE source = 'Banglore' AND destination = 'Delhi'
GROUP BY DAYNAME (departure)
ORDER BY DAYOFWEEK(departure) ASC;
