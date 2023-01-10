library(dplyr)
library(data.table)
library(stringr)
library(lubridate)
library(clipr)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website")

ListOfOrders <- fread("practices/List of Orders.csv") %>% tibble()
OrderDetails <- fread("practices/Order Details.csv") %>% tibble()

# 주문 정보 테이블에서 Pooja라는 고객의 주문 내역을 모두 출력하세요. 
ListOfOrders %>% 
  filter(cust_nm == "Pooja")

# 주문 정보 테이블에서 Pooja라는 고객의 주문 내역 중 Goa 주에서 주문한 내역만 출력하세요.
ListOfOrders %>% 
  filter(cust_nm == "Pooja",
         state == "Goa")

# 주문 상품 테이블에서 카테고리 (대분류)가 의류인 상품만 출력해보세요.
OrderDetails %>% 
  filter(catg_1 == "Clothing")

# 주문 상품 테이블에서 카테고리 (대분류)가 의류인 상품 내역 중 카테고리 (중분류) 가 티셔츠 이면서
# 판매량이 10개 이상인 내역을 출력해보세요.
OrderDetails %>% 
  filter(catg_1 == "Clothing",
         catg_2 == "T-shirt",
         qty >= 10)

# 주문 상품 테이블에서 주문금액이 1000원 이상이지만, 주문 수익이 음수인 것을 출력해보세요.
OrderDetails %>% 
  filter(ord_amt >= 1000,
         ord_profit < 0)

# 주문 상품 테이블에서 주문금액이 1000원 이상이지만, 주문수익이 음수인 내역 중 카테고리 (대분류)가 전자제품이거나
# 의류인 내역만 출력해보세요.
OrderDetails %>% 
  filter(ord_amt >= 1000, 
         ord_profit < 0,
         catg_1 %in% c("Electronics", "Clothing"))

# 주문 상품 테이블에서 카테고리 (대분류)가 P가 포함된 내역 중
# 주문수익이 0인 값이면서,
# 판매량이 2개 이하인 것만 출력해보세요.
OrderDetails %>% 
  filter(catg_1 %>% str_detect("P"),
         ord_profit == 0,
         qty <= 2) 

