library(dplyr)
library(data.table)
library(stringr)
library(lubridate)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website/practices")

ord_info = fread('List of Orders.csv') %>% tibble()
ord_prd = fread('Order Details.csv') %>% tibble()
cust_info = fread('Customer Segmentation.csv') %>% tibble()

# join | select| mutate
# 1. 주문-정보 테이블과 주문-상품 테이블을 활용하여,
# 2. 주문일자, 주문 금액을 만들어보세요.
# 3. 이후 주문일자 컬럼을 기반으로, 주문 주차 (ord_week) 컬럼과 주문 요일(ord_dow) 컬럼을 추가하되,
# 4. 주문 주차, 주문 요일, 주문 금액 컬럼으로 배치된 테이블을 만들어주세요.
# 5. 이후 이 테이블은 week_sales라는 객체로 할당해주세요.

week_sales <- left_join(ord_info, ord_prd, by='ord_cd') %>% 
  mutate('주문일자' = ord_dt,
         '주문금액' = ord_amt,
         ord_week = ord_dt %>% week,
         ord_dow = ord_dt %>% wday(label=T)) %>% 
  select(ord_week, ord_dow, '주문금액')

## 활용 방안 및 예습 ##
week_sales %>% 
  group_by(ord_dow) %>% 
  summarise(dow_sales = sum(주문금액))

week_sales %>% 
  group_by(ord_week, ord_dow) %>% 
  summarize(dow_sales = sum(주문금액)) %>% 
  data.table() %>% 
  dcast.data.table(ord_week ~ ord_dow, value.var = 'dow_sales', sum) %>% tibble()


# join | distinct| select
# 1. 주문 정보 테이블과 회원 정보 테이블을 활용하여,
# 2. 주문코드를 기준으로 중복을 제거하되, 모든 컬럼이 나오도록 표기 한 후,
# 3. 주문 코드, 주문일자, 회원명, 성별, 연령 순으로 배치된 테이블을 만들어주세요.

left_join(ord_info, cust_info, by='cust_nm') %>%
  distinct(ord_cd, .keep_all=T) %>%
  select(ord_cd, ord_dt, cust_nm, gender, age)


# join | distinct| select
# 1. 주문 정보 테이블과 회원 정보 테이블을 활용하여,
# 2. 주문코드를 기준으로 중복을 제거하되, 모든 컬럼이 나오도록 표기 한 후,
# 3. 이 병합된 테이블에 다시 주문-상품테이블을 추가로 활용하여,
# 4. 주문코드, 주문일자, 회원명, 주, 성별, 주문금액, 주문 수익, 판매량, 카테고리로 배치된 테이블을 만들어주세요.
# 5. 이후 해당 테이블을 gender_catg_info 라는 객체로 만들어주세요.

gender_catg_info <- left_join(ord_info, cust_info) %>% 
  distinct(ord_cd, .keep_all=T) %>% 
  left_join(ord_detail) %>% 
  select(ord_cd, ord_dt, cust_nm, state, gender, ord_amt, ord_profit, qty, catg_1)

 
## 예습 ## 
gender_catg_info %>% 
  group_by(gender, catg_1) %>% 
  summarise(revenue = sum(ord_amt),
            cust = n_distinct(cust_nm)) %>% 
  mutate(aov = revenue/cust) %>% 
  data.table() %>% 
  dcast.data.table(catg_1 ~ gender, value.var = 'aov') %>% tibble()






