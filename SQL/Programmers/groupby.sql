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