--Finding the cheapest skiing resorts in Europe

select resort, country, price as price_per_day_EUR, season from resorts 
where continent = 'Europe' and price != 0
order by 3 asc;

select resort, country, price*7 as price_for_7_days_EUR, season from resorts 
where continent = 'Europe' and price != 0
order by 3 asc;

-- The first query, but with additional columns
-- for the purposes exportation and Tableau mapping

select country, resort, price as price_per_day_EUR, season, latitude, longitude, continent from resorts 
where continent = 'Europe' and price != 0
order by 3 asc;

-- Two simple queries for the purposes of finding
-- out the number of countries (spoiler, 38) and continents (5) 
-- with skiing resorts in this dataset

select count(distinct country) as no_of_countries from resorts r; 

select count(distinct continent) as no_of_continents from resorts r; 


-- European countries with the lowest
-- average resort prices per day and week
-- along with the queries which check 
-- how many European countries have exactly
-- one resort and how many have more

select country, ROUND(avg(price), 0) as avg_price_per_day_EUR from resorts 
where continent = 'Europe' and price != 0
group by 1
order by 2 asc;

select country, ROUND (avg(price*7), 0) as avg_price_7_days_EUR from resorts 
where continent = 'Europe' and price != 0
group by 1
order by 2 asc;


select count (country) as one_resort_countries
from (SELECT country, COUNT(resort) as no_of_resorts
FROM resorts r
where continent = 'Europe'
GROUP BY 1
HAVING COUNT(resort) = 1) as sub;

SELECT count (country) as "> 1-resort_countries" 
from (select country, COUNT(resort) as no_of_resorts
FROM resorts r
where continent = 'Europe'
GROUP BY 1
HAVING COUNT(resort) > 1) as sub_2


-- Countries with the lowest
-- average resort prices per day and week (worldwide, including Europe)

select country, continent, ROUND (avg(price), 0) as avg_price_per_day from resorts 
where price != 0
group by 1, 2
order by 3 asc;

select country, continent, ROUND (avg(price*7), 0) as avg_7_days from resorts 
where price != 0
group by 1, 2
order by 3 asc;

-- Continents with the lowest
-- average resort prices per day and week

select continent, ROUND (avg(price), 0) as avg_price_per_day_EUR from resorts 
where price != 0
group by 1
order by 2 asc;

select continent, ROUND (avg(price*7), 0) as avg_price_7_days_EUR from resorts 
where price != 0
group by 1
order by 2 asc;


--Skiing resorts in Europe which offer 
--the possibility of summer skiing

select resort, country, season, price as price_per_day_EUR from resorts 
where continent = 'Europe' and price != 0 and "Summer skiing" = 'Yes'
order by 4 asc;

-- The number of skiing resorts per country and contient

select continent, count (distinct resort) as no_of_resorts from resorts r 
group by 1
order by 2 desc;

select country, count (distinct resort) as no_of_resorts from resorts r 
group by 1
order by 2 desc;

-- Resorts whose price is stated as zero in this dataset

select * from resorts r 
where price = 0

-- Counting the number of skiing resorts
-- per country and continent which offer additional 
-- features and the possiblity of skiing during nighttime

select country, count(resort) as no_of_resorts from (SELECT * FROM resorts
WHERE snowparks = 'Yes' AND nightskiing = 'Yes') as additional_features
group by 1
order by 2 desc;

select continent, count(resort) as no_of_resorts from (SELECT * FROM resorts
WHERE snowparks = 'Yes' AND nightskiing = 'Yes') as additional_features
group by 1
order by 2 desc;

-- I wrote the next three queries for the purposes of practicing
-- subqueries and getting simple and valuable insights
-- from complicated queries


-- European skiing resorts with prices lower than the average
-- while displaying both the resort's and the average price 
-- in Europe

SELECT resort, price as resort_price_per_day,
       (SELECT ROUND (AVG(price), 0) FROM resorts WHERE continent = 'Europe' AND price != 0) AS avg_price_per_day_EUR,
       season, country
FROM resorts
WHERE price < (SELECT AVG(price) FROM resorts WHERE continent = 'Europe' AND price != 0)
AND price != 0
ORDER BY price ASC;

-- The number of skiing resorts in Europe
-- with prices lower than the average price while displaying
-- the average price, the number of resorts whose price
-- per day is lower than the average and the total number of 
-- skiing resorts in Europe

select 
(SELECT ROUND (AVG(price), 0) 
FROM resorts WHERE continent = 'Europe' AND price != 0) AS avg_price_per_day_EUR, 
count (resorts) as lower_than_avg,
(select count (resort) from resorts r 
where continent = 'Europe') as total_resorts_Europe from resorts

WHERE price < (select AVG(price) FROM resorts 
WHERE continent = 'Europe' AND price != 0)
and continent = 'Europe';

-- The number of skiing resorts in Europe
-- with prices higher than the average price while displaying
-- the average price, the number of resorts whose price
-- per day is higher than the average price and the total number of 
-- skiing resorts in Europe

select 
(SELECT ROUND (AVG(price), 0) 
FROM resorts WHERE continent = 'Europe' AND price != 0) AS avg_price_per_day_EUR, 
count(resorts) as higher_or_equal,
(select count (resort) from resorts r 
where continent = 'Europe') as total_resorts_Europe from resorts 

WHERE price >= (SELECT AVG(price) FROM resorts 
WHERE continent = 'Europe' AND price != 0)
and continent = 'Europe';







