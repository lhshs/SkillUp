
library(dplyr)
library(data.table)
library(lubridate)
library(stringr)
library(clipr)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website/practices")

ord_info <- fread("List of Orders.csv") %>% tibble()
ord_prd <- fread("Order Details.csv") %>% tibble()
cust_info <- fread("Customer Segmentation.csv") %>% tibble()


# join| group |summarise | data.table | dcast
# 주문-상품 테이블과 주문 정보 테이블을 활용하여
# 카테고리 (대분류)와 주 컬럼을 기준으로 그룹핑 후
# 주문금액의 총액을 집계하여
# 주 ~ 대분류, 측정값은 총액으로 적용된 wide-format 테이블을 만든 후 tibble 형태로 변환하세요.

ord_prd %>% 
  left_join(ord_info, by='ord_cd') %>% 
  group_by(catg_1, state) %>% 
  summarise(revenue = sum(ord_amt)) %>% 
  data.table() %>% 
  dcast.data.table(state ~ catg_1, value.var = 'revenue', sum) %>% 
  tibble()


# join| mutate | group |summarise | data.table | dcast
# 주문-상품 테이블과 주문 정보 테이블을 활용 후
# 주문 날짜 컬럼을 가공하여 ymd 형태의 날짜 컬럼으로 만들어주세요.
# 이후 카테고리 (대분류)와 ymd 형태의 날짜 컬럼을 기준으로 그룹핑 후
# 주문금액의 총액을 집계하여
# 주문날짜(ymd) ~ 대분류, 측정값은 총액으로 적용된 wide-format 테이블을 만든 후 tibble 형태로 변환하세요.

ord_prd %>% 
  left_join(ord_info) %>% 
  mutate(ord_dt = ord_dt %>% dmy()) %>% 
  group_by(catg_1, ord_dt) %>% 
  summarise(rev = sum(ord_amt)) %>% 
  data.table() %>% 
  dcast.data.table(ord_dt ~ catg_1, value.var = 'rev', sum) %>% 
  tibble()
  
# join| mutate | group |summarise | data.table | dcast
# 주문-상품 테이블과 주문 정보 테이블을 활용 후
# 주문 날짜 컬럼을 가공하여 ymd 형태의 날짜 컬럼으로 만들어주세요.
# 이후 카테고리 (대분류)와 ymd 형태의 날짜 컬럼을 기준으로 그룹핑 후
# 주문금액의 총액을 집계하여
# 대분류 ~ 주문날짜, 측정값은 총액으로 적용된 wide-format 테이블을 만든 후 tibble 형태로 변환하세요.

ord_prd %>% 
  left_join(ord_info) %>% 
  mutate(ord_dt = ord_dt %>% dmy) %>% 
  group_by(catg_1, ord_dt) %>% 
  summarise(rev = sum(ord_amt)) %>% 
  data.table() %>% 
  dcast.data.table(catg_1 ~ ord_dt, value.var = 'rev', sum) %>% 
  tibble()


# join| group |summarise | data.table | dcast
# 주문-정보 테이블과 주문-상품 테이블 그리고 회원 정보 테이블을 활용하여 하나의 테이블로 병합 후 
# 주문날짜 컬럼을 활용하여, 요일 컬럼을 만들어주세요.
# 이후 성별과 요일을 기준으로 그룹핑 후 주문 금액 총액으로 한 집계값을 만들어주세요.
# 그리고 요일 ~ 성별, 집계값은 주문 총액으로 구성한 wide format의 테이블을 만들어주세요.

ord_prd %>% 
  left_join(ord_info) %>% 
  left_join(cust_info) %>% 
  mutate(wday = ord_dt %>% dmy %>% wday(label=T)) %>% 
  group_by(gender, wday) %>% 
  summarise(total_ord_amt = sum(ord_amt)) %>% 
  data.table() %>% 
  dcast.data.table(wday ~ gender, value.var='total_ord_amt', sum) %>% 
  tibble()


# join| group |summarise | data.table | dcast
# 주문-정보 테이블과 주문-상품 테이블 그리고 회원 정보 테이블을 활용하여 하나의 테이블로 병합 후 
# 주문날짜 컬럼을 활용하여, 요일 컬럼을 만들어주세요.
# 이후 성별과 결혼여부 그리고 요일을 기준으로 그룹핑 후 주문 금액 총액으로 한 집계값을 만들어주세요. 
# 그리고 성별 + 결혼여부 ~ 요일, 집계값은 주문 총액으로 구성한 wide format의 테이블을 만들어주세요.

wide_format <- ord_info %>% 
  left_join(ord_prd) %>% 
  left_join(cust_info) %>% 
  mutate(wday = ord_dt %>% dmy %>%  wday(label=T)) %>% 
  group_by(gender, married, wday) %>% 
  summarise(total_ord_amt = sum(ord_amt)) %>% 
  data.table() %>% 
  dcast.data.table(gender + married ~ wday, value.var='total_ord_amt', sum) %>% 
  arrange(gender, married %>% desc) %>% 
  tibble()


# join| mutate | group |summarise | dcast | melt
# 2번 문제를 다시 long-format으로 전환해보세요.
# 원래 long-format값과 무엇이 다른지 확인해보아주세요.

wide_format %>% 
  data.table() %>% 
  melt.data.table(id.vars = c('married','gender')) %>% 
  tibble() %>% 
  View()
  
