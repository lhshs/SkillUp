# 진료과별 총 예약 횟수 출력
SELECT MCDP_CD AS '진료과코드', COUNT(APNT_NO) as '5월예약건수'
FROM APPOINTMENT
WHERE DATE_FORMAT(APNT_YMD, '%Y%m')='202205' 
GROUP BY 1
ORDER BY 2, 1 

# 고양이와 개 몇 마리?
SELECT ANIMAL_TYPE, COUNT(ANIMAL_ID)
FROM ANIMAL_INS
GROUP BY 1
ORDER BY 1

# 성분으로 구분한 아이스크림 총 주문량
SELECT INGREDIENT_TYPE, SUM(TOTAL_ORDER)
FROM FIRST_HALF FH
JOIN ICECREAM_INFO II ON FH.FLAVOR = II.FLAVOR
GROUP BY 1

# 동명 동물 수 찾기
SELECT NAME, COUNT(*) AS 'COUNT'
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT >= 2
ORDER BY NAME

# 입양 시각 구하기(1)
SELECT HOUR(DATETIME) AS HOUR, COUNT(*) AS COUNT
FROM ANIMAL_OUTS
GROUP BY 1
HAVING HOUR >= 9 AND HOUR < 20
ORDER BY 1

# 가격대 별 상품 개수 구하기
SELECT TRUNCATE(PRICE, -4) AS PRICE_GROUP -- BETWEEN이 아닌 TRUNCATE로 간단하게 범위 설정해 버리기..
     , COUNT(*) AS PRODUCTS 
FROM PRODUCT
GROUP BY 1
ORDER BY 1

# 카테고리 별 도서 판매량 집계
SELECT CATEGORY, SUM(SALES) AS TOTAL_SALES
FROM BOOK B
JOIN BOOK_SALES BS ON B.BOOK_ID = BS.BOOK_ID
WHERE SALES_DATE LIKE '2022-01%'
-- WHERE DATE_FORMAT(SALES_DATE, '%Y%m') = '202201'
GROUP BY 1
ORDER BY 1

# 즐겨찾기 많은 식당~
-- # SELECT FOOD_TYPE, REST_ID, REST_NAME, MAX(FAVORITES) AS FAVORITES
-- # FROM REST_INFO 
-- # GROUP BY 1
-- # ORDER BY 1 DESC

SELECT A.FOOD_TYPE, A.REST_ID, A.REST_NAME, A.FAVORITES
FROM REST_INFO A 
JOIN(SELECT FOOD_TYPE, MAX(FAVORITES) AS FAVORITES
     FROM REST_INFO
     GROUP BY FOOD_TYPE) B
    ON A.FAVORITES = B.FAVORITES 
    AND A.FOOD_TYPE = B.FOOD_TYPE
ORDER BY FOOD_TYPE DESC

-- # SELECT FOOD_TYPE, MAX(FAVORITES) AS FAVORITES
-- # FROM REST_INFO
-- # GROUP BY FOOD_TYPE

# 입양 시각 구하기 2
SET @HOUR = -1;
SELECT @HOUR := @HOUR+1 AS HOUR, (SELECT COUNT(*) 
                                  FROM ANIMAL_OUTS 
                                  WHERE HOUR(DATETIME) = @HOUR) AS COUNT
FROM ANIMAL_OUTS
WHERE @HOUR < 23
GROUP BY 1
ORDER BY 1
-- 서브쿼리와 SET 함수 사용!