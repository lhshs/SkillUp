-- The Blunder
SELECT CEIL(AVG(Salary) - AVG(replace(Salary,'0','')))
FROM EMPLOYEES



-- Top Earners
select months*salary
     , count(*)
from Employee
where months*salary = (select max(months*salary)
                       from Employee)
group by 1
### select절에 max(months*salary)를 받고 group by를 쓰지 않는 방법도 있음



-- Weather Observation Station 15

select round(LONG_W,4)
from STATION
where LAT_N = (select max(LAT_N)
               from STATION
               where LAT_N < 137.2345)



-- Weather Observation Station 19

-- a = min(LAT_N)
-- b = max(LAT_N)
-- c = min(LONG_W)
-- d = max(LONG_W)

-- Euclidean Distance
-- sqrt((a-b)^2 + (c-d)^2)

select round(sqrt(power(MIN(LAT_N)-MAX(LAT_N), 2) + power(MIN(LONG_W)-MAX(LONG_W), 2)),4)
from STATION


-- Weather Observation Station 20


