library(dplyr)
library(data.table)
library(stringr)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website/practices")

cust_seg = fread('Customer Segmentation.csv') %>% tibble()
ord_list = fread('List of Orders.csv') %>% tibble()
ord_detail = fread('Order Details.csv') %>% tibble()

# mutate | arrange | select
# 1. 주문-상품 테이블을 활용하여
# 2. 주문 할인 변수를 만들고, (주문금액 – 주문 수익)
# 3. 주문할인을내림차순한후,
# 4. 이후 주문번호, 주문금액, 주문 수익, 주문 할인 순으로 한정된 테이블을 만들어보세요.

ord_detail %>% 
  mutate(discount = ord_amt-ord_profit) %>% 
  arrange(discount %>% desc) %>% 
  select(ord_cd, ord_amt, ord_profit, discount)


# filter| arrange
# 1. 주문-상품 테이블을 활용하여
# 2. 카테고리 (대분류) 값이 ‘Electronics’ 인 값을 기준으로, 
# 3. 주문수익을오름차순한테이블을만들어보세요.

ord_detail %>% 
  filter(catg_1 == 'Electronics') %>% 
  arrange(ord_profit)


# filter| arrange
# 1. 주문-상품 테이블을 활용하여,
# 2. 카테고리 (대분류) 값이 ‘Clothing’ 인 값을 기준으로, 
# 3. 판매량이 내림 차순된 테이블을 만들어보세요.

ord_detail %>% 
  filter(catg_1 == 'Clothing') %>% 
  arrange(ord_amt %>% desc)


# arrange| distinct| select
# 1. 주문-정보 테이블을 활용하여
# 2. 주와 시 컬럼 순서대로, 모두 오름차순 되도록 설정해보세요. 
# 3. 이후두컬럼의중복을모두제거후,해당두컬럼에한해보여지는테이블을만들어주세요.

ord_list %>% 
  arrange(state, city) %>% 
  distinct(state, city)


# mutate | distinct | select
# 1. 주문-정보 테이블을 활용하여
# 2. 주와 회원명 순서대로,오름 차순으로 정렬 한 후,
# 3. 주와 회원명 컬럼의 중복을 모두 제거 후, 두 컬럼 순서로 배치된 테이블을 만들어주세요.

ord_list %>% 
  arrange(state, cust_nm) %>% 
  distinct(state, cust_nm)


# mutate | arrange | distinct | select
# 1. 주문-정보 테이블을 활용하여
# 2. 주문일자컬럼을ymd형태로적용후,
# 3. ord_dow라는 요일 컬럼을 생성해주세요.
# 4. 이후 요일과 회원명 순서대로,오름 차순으로 정렬 한 후, (왜 요일은 알파벳 순이 아닌가?를 고민해주세요)
# 5. 요일과 회원명 컬럼의 중복을 모두 제거 후, 두 컬럼 순서로 배치된 테이블을 만들어주세요.

library(lubridate)
ord_list %>% 
  mutate(ord_dt = ord_dt %>% dmy,
         ord_dow = ord_dt %>% wday(label=T)) %>% 
  arrange(ord_dow, cust_nm) %>% 
  distinct(ord_dow, cust_nm)


# filter| arrange | select
# 1. 회원 정보 테이블을 활용하여
# 2. 졸업 여부 컬럼이 Yes에 값에 한하여,
# 3. 가족수는 내림차순, 나이는 오름차순 한 후,
# 4. 회원명, 가족수, 나이, 직업 컬럼으로 배치된 테이블을 만들어주세요.

cust_seg %>% 
  filter(graduated == 'Yes') %>% 
  arrange(family %>% desc, age) %>% 
  select(cust_nm, family, age, job)


# filter| arrange | select
# 1. 회원 정보 테이블을 활용하여,
# 2. 남성이면서, 기혼인 사람 중, 30대 이상인 사람에 한하여 출력 후,
# 3. 소비 수준을 내림 차순된 테이블을 만들어주세요.
# 4. 이 후, 회원명, 소비 수준, 직업, 가족 수 컬럼으로 배치된 테이블을 만들어주세요.

cust_seg %>% 
  filter(gender == 'Male', married == 'Yes', age >= 30) %>% 
  arrange(spend %>% desc) %>% 
  select(cust_nm, spend, job, family)





