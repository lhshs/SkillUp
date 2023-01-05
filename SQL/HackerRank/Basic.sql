-- Revising the Select Query 2
select NAME
from CITY
where POPULATION > 120000 AND COUNTRYCODE = 'USA'


-- SELECT BY ID
SELECT *
FROM CITY
WHERE ID=1661


-- Japanese Cities' Attributes
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN'


-- Japanese Cities' Names
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'JPN'


-- Weather Observation Station 1
SELECT CITY, STATE
FROM STATION


-- Weather Observation Station 3
SELECT DISTINCT(CITY)
FROM STATION
WHERE ID % 2 = 0


-- Weather Observation Station 4
SELECT COUNT(CITY) - COUNT(DISTINCT(CITY))
FROM STATION


-- Weather Observation Station 5
SELECT CITY, LENGTH(CITY)
FROM STATION
WHERE LENGTH(CITY) = (SELECT MIN(LENGTH(CITY))
                      FROM STATION)
ORDER BY 1
LIMIT 1
;

SELECT CITY, LENGTH(CITY)
FROM STATION
WHERE LENGTH(CITY) = (SELECT MAX(LENGTH(CITY))
                      FROM STATION)
;
-- another solve --
select city c, length(city) l
from   station
order by l desc, c asc
limit 1;

select city c, length(city) l
from   station
order by l asc, c asc
limit 1;

--
