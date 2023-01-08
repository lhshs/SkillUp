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
-- -- another solve -- --
select city c, length(city) l
from   station
order by l desc, c asc
limit 1;

select city c, length(city) l
from   station
order by l asc, c asc
limit 1;

-- Weather Observation Station 5
SELECT DISTINCT(CITY)
FROM STATION
WHERE CITY LIKE ('A%')
OR CITY LIKE ('E%')
OR CITY LIKE ('I%')
OR CITY LIKE ('O%')
OR CITY LIKE ('U%')
;

-- --> another solve -- --
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiou]'
;


-- Weather Observation Station 7
SELECT DISTINCT(CITY)
FROM STATION
WHERE CITY REGEXP '[aeiou]$'
;


-- Weather Observation Station 8
SELECT DISTINCT(CITY)
FROM STATION
WHERE CITY REGEXP '^[AEIOU]' AND CITY REGEXP '[AEIOU]$'


-- Weather Observation Station 9
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[^AEIOU]'

-- Weather Observation Station 10
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[^AEIOU]$'


-- Weather Observation Station 11
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[^AEIOU]' OR CITY REGEXP '[^AEIOU]$'


-- Weather Observation Station 12
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[^AEIOU]' AND CITY REGEXP '[^AEIOU]$'


-- Higher Then 75 Marks
SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME, 3), ID

-- Employee Names
SELECT NAME
FROM Employee
ORDER BY 1

-- Employee Salaries
SELECT NAME
FROM Employee
WHERE SALARY > 2000 AND MONTHS < 10
ORDER BY employee_id
