library(dplyr)
library(data.table)
library(lubridate)
library(stringr)
library(clipr)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website/practices")

ord_info <- fread("List of Orders.csv") %>% tibble()
ord_prd <- fread("Order Details.csv") %>% tibble()
cust_info <- fread("Customer Segmentation.csv") %>% tibble()


# group | summarise
# 회원 정보 테이블을 활용하여
# 성별의 고객 수는 각각 얼마나 되는지 만들어보세요.

cust_info %>% 
  group_by(gender) %>%
  summarise(gender_count = n())

# group | summarise| arrange
# 회원 정보 테이블을 활용하여
# 직업별 고객 수는 각각 얼마나 되는지 만들어보세요. 
# 그리고 고객 수별로 내림차순 해주세요.

cust_info %>% 
  group_by(job) %>% 
  summarise(c_job = n()) %>% 
  arrange(c_job %>% desc)

# group | summarise| arrange
# 회원 정보 테이블을 활용하여
# 성별에 따른 직업별 고객 수는 각각 얼마나 되는지 만들어보세요.
# 그리고 성별은 오름차순, 직업도 오름차순, 각 그룹별 고객 수는 내림차순 순서로 정렬해주세요.

cust_info %>% 
  group_by(gender, job) %>% 
  summarise(cust_n = n()) %>% 
  arrange(gender, job, cust_n %>% desc)

# group | summarise| arrange
# 회원 정보 테이블을 활용하여
# 성별에 따른 결혼 여부별 고객 수와 평균 연령은 각각 얼마나 되는지 만들어보세요.
# 그리고 성별은 오름차순, 각 그룹별 고객 수 내림차순 순서로 정렬해주세요.

cust_info %>% 
  select(gender, married, age) %>% 
  group_by(gender, married) %>% 
  summarise(c_married = n(),
            avg_age = mean(age)) %>% 
  arrange(gender, c_married %>% desc)


# group | summarise| arrange
# 회원 정보 테이블을 활용하여
# 직업별 고객 수, 평균 연령, 최대 연령, 최소 연령은 각각 얼마나 되는지 만들어보세요. 
# 그리고 고객수를 기준으로 내림차순해주세요.

cust_info %>% 
  group_by(job) %>% 
  summarise(c_cust = sum(cust_no),
            mean_age = mean(age),
            max_age = max(age),
            min_age = min(age)) %>% 
  arrange(c_cust %>% desc)

 
# group | summarise
# 주문-상품 테이블을 활용하여
# 카테고리 (대분류)와 카테고리 (중분류)별 총 주문 금액을 구해보세요.

ord_prd %>% 
  group_by(catg_1, catg_2) %>% 
  summarise(revenue = sum(ord_amt))


# group | summarise
# 주문-상품 테이블을 활용하여
# 카테고리 (대분류)와 카테고리 (중분류)별 총 주문 금액과 평균 주문금액을 구해보세요.

ord_prd %>% 
  group_by(catg_1, catg_2) %>% 
  summarise(revenue = sum(ord_amt),
            aov = mean(ord_amt))


# group | summarise| join | arrange
# 주문-상품 테이블과 주문 정보 테이블을 활용하여 
# 주문코드별 총 주문금액을 구해보세요.
# 이후 주문 정보 테이블을 병합하여
# 회원별 총 주문금액, 평균 주문금액 , 주문 수를 구해보세요. 
# 그리고 총 주문금액을 내림차순 해보세요.

ord_prd %>% 
  group_by(ord_cd) %>%
  summarise(ord_rev = sum(ord_amt)) %>%
  left_join(ord_info, by='ord_cd') %>% 
  group_by(cust_nm) %>% 
  summarise(cust_rev = sum(ord_rev),
            cust_rev_avg = mean(ord_rev), 
            cust_ord = n_distinct(ord_cd)) %>% 
  arrange(cust_rev %>% desc)
  
  

