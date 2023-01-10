library(dplyr)
library(data.table)
library(lubridate)
library(stringr)
library(clipr)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website")

ListOfOrders = fread("practices/List of Orders.csv") %>% tibble()
OrderDetails = fread("practices/Order Details.csv") %>% tibble()

# 주문 정보 테이블에서 주, 고객명 순서로 출력
ListOfOrders %>% 
  select(state, cust_nm)
;

# 주문 상품 테이블에서 주문번호와 주문금액만 출력
OrderDetails %>% 
  select(ord_cd, ord_amt)
;  

# 주문 상품 테이블에서 카테고리 (대분류)와 판매량을 출력
OrderDetails %>% 
  select(catg_1, qty)
  
# 주문 상품 테이블에서 카테고리 (catg) 컬럼만 출력
# 그리고 이 값을 catg_info라는 객체로 할당하여 만들어보아
catg_info = OrderDetails %>% 
  select(starts_with('catg'))

# 주문 상품 테이블에서 주문번호, 주문금액과 수익액 컬럼만 출력
# 그리고 이 값을 sales_info라는 객체로 할당하여 만들어보아
sales_info = OrderDetails %>% 
  select(starts_with('ord'))

# distinct 활용
catg_info %>% 
  head(10) %>%   
  distinct(catg_1, catg_2)

catg_info %>% 
  head(10) %>%   
  distinct(catg_2)






