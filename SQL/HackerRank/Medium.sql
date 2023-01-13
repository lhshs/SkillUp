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

-- Binary Tree Nodes
SELECT N, CASE WHEN P IS NULL THEN 'Root'
               WHEN N NOT IN (SELECT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
               ELSE 'Inner'
               END
FROM BST
ORDER BY N

-- Weather Obervation Station 18
SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)), 4)
FROM STATION

-- Weather Obervation Station 20
SELECT ROUND(LAT_N, 4)
FROM (SELECT LAT_N, PERCENT_RANK() OVER (ORDER BY LAT_N) PERCENT
      FROM STATION) A
WHERE PERCENT = 0.5
-- PERCENT_RANK() 함수에 대한 인지


-- Contest Leaderboard
SELECT H.hacker_id, name, SUM(SUB.TOTAL_SCORE)
FROM (SELECT hacker_id, MAX(score) AS TOTAL_SCORE FROM Submissions GROUP BY challenge_id, hacker_id) SUB
JOIN Hackers H ON H.hacker_id = SUB.hacker_id
GROUP BY 1, 2
HAVING SUM(SUB.TOTAL_SCORE) <> 0
ORDER BY 3 DESC, 1
-- subquery의 생각이 쉽지 않다