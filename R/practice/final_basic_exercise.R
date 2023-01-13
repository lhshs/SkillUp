library(dplyr)
library(data.table)
library(stringr)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website/practices")

ord_info = fread('Order Details.csv') %>% tibble()
ord_prd = fread('List of Orders.csv') %>% tibble()
cust_info = fread('Customer Segmentation.csv') %>% tibble()

# 고객의 분포 현황은 어떻게 될까요? 자유롭게 확인해보세요.
# 예를 들면, 무엇을 보고 싶은지 : 성별, 결혼여부 인원 분포는 어떻게 될까?
# 어떻게 보면 좋을지 : 성별 x 결혼여부 | 인원을 비율로 보는게 좋을까? 절대수로 보는게 좋을까?
## 직업별 구매 현황 
cust_info %>% 
  left_join(ord_prd) %>% 
  left_join(ord_info) %>% 
  select(job, catg_1) %>% 
  group_by(job) %>% 
  data.table() %>% 
  dcast.data.table(job~catg_1, value.var='catg_1') %>% 
  arrange(Clothing %>% desc, Electronics %>% desc, Furniture %>% desc)
  tibble()
  # summarise(total_amt = sum(ord_amt)) %>% 
  # arrange(total_amt %>% desc) 
  # print(n = 1500)
  
cust_info %>% 
  left_join(ord_prd) %>%
  group_by(gender, married, graduated, spend) %>% 
  summarise(spend_count = n()) %>% 
  data.table() %>%
  dcast.data.table(gender + married + graduated ~ spend, value.var='spend_count', sum) %>%
  tibble() %>% 
  arrange(High %>% desc) %>% 
  select(gender, married, graduated, Low, Average, High)


# 평균 주문액이 가장 높은 직업은 어디인가요?

cust_info %>% 
  left_join(ord_prd) %>% 
  left_join(ord_info) %>% 
  group_by(job) %>% 
  filter(nchar(job) > 1) %>% 
  summarise(mean_ord = mean(ord_amt)) %>% 
  arrange(mean_ord %>% desc)


# 주문수가 가장 많았던 직업은 어디인가?

cust_info %>% 
  left_join(ord_prd) %>% 
  left_join(ord_info) %>% 
  group_by(job) %>% 
  filter(nchar(job) > 1) %>% 
  summarise(sum_ord = n())


# 주문수가 가장 많았던 직업 중 결혼 여부는 유의미한가? 주문수가 가장 많았던 직업 중 성별 여부는 유의미한가?

cust_info %>% 
  left_join(ord_prd) %>% 
  left_join(ord_info) %>% 
  group_by(job, married, gender) %>% 
  filter(nchar(job) > 1, nchar(married) > 1) %>% 
  summarise(sum_ord = n()) %>% 
  print(n=40)


# 평균 주문액이 월별로 성장하는 직업은 어디인가?


# 연령별로 선호하는 중분류 카테고리 어떻게 분포되어있는가?
# 관점 1) 선호의 기준은 무엇인가? 주문수인가? 총주문액인가? 평균 주문액인가? 
# 관점 2) 분포는 왜 보는가? 어떻게 보면 쉽게 볼 수 있을까?


# 고객별 평균 구매주기 구하기 카테고리별 (중분류) 재구매율 구하기

