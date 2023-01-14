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
-- 나의 풀이 230114
SELECT hacker_id, name, SUM(score)
FROM (SELECT H.hacker_id, challenge_id, name, MAX(score) AS score
      FROM Hackers H
      JOIN Submissions S ON S.hacker_id = H.hacker_id
      GROUP BY 1, 2, 3) AS SUB
GROUP BY 1, 2
HAVING SUM(score) <> 0
ORDER BY 3 DESC, 1

-- New Companies
SELECT C.company_code, founder, COUNT(DISTINCT(LM.lead_manager_code)), 
       COUNT(DISTINCT(SM.senior_manager_code)),COUNT(DISTINCT(M.manager_code)), 
       COUNT(DISTINCT(E.employee_code))
FROM Company C
JOIN Lead_Manager LM ON LM.company_code = C.company_code
JOIN Senior_Manager SM ON SM.company_code = C.company_code
JOIN Manager M ON M.company_code = C.company_code
JOIN Employee E ON E.company_code = C.company_code
GROUP BY 1, 2

