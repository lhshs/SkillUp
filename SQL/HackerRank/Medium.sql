-- Weather Obervation Station 18
SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)), 4)
FROM STATION
-- Manhattan Distance에 대한 인지
-- x좌표 차이 절대값 + y좌표 차이 절대값


-- The PADS
SELECT CONCAT(NAME, "(", LEFT(OCCUPATION, 1), ")")
FROM OCCUPATIONS
ORDER BY NAME;

SELECT 'There are a total of', COUNT(OCCUPATION), CONCAT(LOWER(OCCUPATION),'s.')
FROM OCCUPATIONS
GROUP BY 3
ORDER BY 2, 3;
-- 쿼리를 두 개 쓸 수 있는 가능성
-- CONCAT에 대한 인식

-- Placements
SELECT SUB.NAME
FROM(SELECT S.ID, S.NAME, F.Friend_ID, P.Salary AS MY_SALARY
     FROM Students S
     JOIN Friends F ON F.ID = S.ID 
     JOIN Packages P ON P.ID = S.ID) SUB
JOIN Packages P ON P.ID = SUB.Friend_ID
WHERE SUB.MY_SALARY < P.Salary
ORDER BY P.Salary
-- 다시 풀어보기