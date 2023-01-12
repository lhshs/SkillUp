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


-- Type Of Triangle
SELECT CASE WHEN A+B <= C OR A+C <= B OR B+C <= A THEN 'Not A Triangle'
            WHEN A=B AND B=C THEN 'Equilateral'
            WHEN A=B OR B=C OR A=C THEN 'Isosceles'
            ELSE 'Scalene'
            END
FROM TRIANGLES
-- 순서가 중요한 문제였다..


-- Revising Aggregations - The Count Function
SELECT COUNT(*)
FROM CITY
WHERE POPULATION > 100000


-- Revising Aggregations - The Sum Function
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT='California'


-- Revising Aggregations - Averages
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California'


-- Average Population
SELECT FLOOR(AVG(POPULATION))
FROM CITY
-- 가장 가까운 정수로 내림 'FLOOR'


-- Revising the Select Query 1
SELECT *
FROM CITY
WHERE POPULATION > 100000 AND COUNTRYCODE = 'USA'


-- Population Density Difference 
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY


-- Weather Observation Station 2
SELECT ROUND(SUM(LAT_N), 2), ROUND(SUM(LONG_W), 2)
FROM STATION


-- Weather Observation Station 13
SELECT TRUNCATE(SUM(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7880 AND LAT_N < 137.2345


-- Weather Observation Station 14
SELECT TRUNCATE(MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345


-- Weather Observation Station 15
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MAX(LAT_N)
               FROM STATION
               WHERE LAT_N < 137.2345)


-- Weather Observation Station 16
SELECT ROUND(MIN(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7780


-- Weather Observation Station 17
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N > 38.7780
ORDER BY LAT_N
LIMIT 1
;
-- 서브 쿼를 이용한 풀이
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N)
               FROM STATION
               WHERE LAT_N > 38.7780)
;


-- Population Census
SELECT SUM(CI.POPULATION)
FROM CITY CI
JOIN COUNTRY CO ON CO.CODE = CI.COUNTRYCODE
WHERE CONTINENT = 'Asia'


-- African Cities
SELECT CI.NAME
FROM CITY CI
JOIN COUNTRY CO ON CO.CODE = CI.COUNTRYCODE
WHERE CONTINENT = 'Africa'


-- Average Population of Each Continent
SELECT CO.Continent, FLOOR(AVG(CI.Population))
FROM CITY CI
JOIN COUNTRY CO ON CO.CODE = CI.COUNTRYCODE
GROUP BY 1
-- FLOOR 소수 첫째 자리에서 버림하는 함수


-- Draw the Triangle 1
SET @T = 21;
SELECT REPEAT("* ", @T := @T-1)
FROM INFORMATION_SCHEMA.TABLES
LIMIT 21
-- SET, REPEAT를 활용
-- INFORMATION_SCHEMA 인지

-- Draw the Triangle 2
SET @T = 0;
SELECT REPEAT('* ', @T := @T+1)
FROM INFORMATION_SCHEMA.TABLES
LIMIT 20
