# 조건에 맞는 도서와 저자 리스트 출력하기
SELECT BOOK_ID, AUTHOR_NAME, DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK B
JOIN AUTHOR A ON A.AUTHOR_ID = B.AUTHOR_ID
WHERE CATEGORY = '경제'
ORDER BY 3

# 상품 별 오프라인 매출 구하기
SELECT PRODUCT_CODE, SUM(PRICE * SALES_AMOUNT) AS SALES
FROM PRODUCT PD
JOIN OFFLINE_SALE OS ON OS.PRODUCT_ID = PD.PRODUCT_ID
GROUP BY 1
ORDER BY 2 DESC, 1

# 있었는데.. 없었어요..
SELECT AI.ANIMAL_ID, AI.NAME
FROM ANIMAL_INS AI
JOIN ANIMAL_OUTS AO ON AO.ANIMAL_ID = AI.ANIMAL_ID
WHERE AI.DATETIME > AO.DATETIME
ORDER BY AI.DATETIME

# 없어진 기록 찾기
SELECT AO.ANIMAL_ID, AO.NAME
FROM ANIMAL_INS AI
RIGHT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.DATETIME IS NULL
ORDER BY 1

# 오랜 기간 보호 동물(1)
SELECT AI.NAME, AI.DATETIME
FROM ANIMAL_INS AI
LEFT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AO.DATETIME IS NULL
GROUP BY 1
ORDER BY 2 
LIMIT 3

# 주문량이 많은 아이스크림
SELECT J.FLAVOR
FROM FIRST_HALF FH
RIGHT JOIN JULY J ON FH.SHIPMENT_ID = J.SHIPMENT_ID
GROUP BY 1 
ORDER BY SUM(FH.TOTAL_ORDER) + SUM(J.TOTAL_ORDER) DESC
LIMIT 3

# 그룹별 조건에 맞는 식당
# XXXX #

# 보호소에서 중성화한 동물
SELECT AI.ANIMAL_ID, AI.ANIMAL_TYPE, AI.NAME
FROM ANIMAL_INS AI
JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.SEX_UPON_INTAKE <> AO.SEX_UPON_OUTCOME
ORDER BY 1

# 5월 식품들 총 매출 조회
SELECT FP.PRODUCT_ID, PRODUCT_NAME, SUM(PRICE*AMOUNT) AS TOTAL_SALES
FROM FOOD_PRODUCT FP
JOIN FOOD_ORDER FO ON FO.PRODUCT_ID = FP.PRODUCT_ID
WHERE PRODUCE_DATE LIKE '2022-05%'
GROUP BY 1, 2
ORDER BY 3 DESC, 1

# 