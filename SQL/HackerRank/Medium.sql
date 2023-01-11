-- Occupation


-- The PADS
SELECT *, 'There are a total of', (SELECT Occupation, COUNT(*)
                                   FROM OCCUPATIONS
                                   GROUP BY Occupation)
FROM OCCUPATIONS
-- 더 고민해 보기