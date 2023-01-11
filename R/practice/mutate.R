library(dplyr)
library(data.table)
library(stringr)

setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website/practices")

ListofOrders = fread('List of Orders.csv') %>% tibble()
OrderDetails = fread('Order Details.csv') %>% tibble()
CustomerSegmentation = fread('Customer Segmentation.csv') %>% tibble()

# mutate : str_sub | select
# 1. 회원 정보 테이블을 활용하여, 
# 2. 성별 값 (Female, Male) 중 맨 앞 글자를 통해, gender_simple 컬럼을 만들어보세요. 
# 3. 이후 cust_nm, gender_simple로만 구성된 객체 gender_info 객체를 만들어보세요.

gender_info = CustomerSegmentation %>% 
  mutate(gender_simple = str_sub(gender, 1, 1)) %>% 
  select(cust_nm, gender_simple)
  

# filter : is.na | mutate : ifelse | select
# 1. 회원 정보 테이블을 활용하여,
# 2. 연차 (tenure) 중 NA 값은 제외 하고,
# 3. 이후 1년 이하인 값을 ‘신입’으로, 2년 이상인 값은 ‘경력’으로 구성된 t_grp 컬럼을 만들어보세요. 
# 4. 그리고 이 값을 cust_nm, gender_simple, t_grp로 구성된, tenure_info 객체를 만들어보세요.

tenure_info <- CustomerSegmentation %>% 
  filter(!tenure %>% is.na) %>% 
  mutate(t_grp = ifelse(tenure <= 1, '신입', '경력'),
         gender_simple = gender %>% str_sub(1, 1)) %>% 
  select(cust_nm, gender_simple, t_grp)


# mutate : ifelse | select
# 1. 회원 정보 테이블을 활용하여,
# 2. 가족수 (Family)가 1일 경우, ‘1인가구’, 2일 경우 ‘2인가구’, 3 이상일 경우 ‘대가구’로 구성된 f_grp를 만들어보세요 
# 3. 그리고 이 값을 cust_nm, gender_simple, t_grp, f_grp로 구성된, family_info 객체를 만들어보세요.

family_info = CustomerSegmentation %>% 
  filter(!is.na(tenure)) %>% 
  mutate(gender_simple = gender %>% str_sub(1,1), 
         t_grp = ifelse(tenure <= 1, '신입', '경력'), 
         f_grp=ifelse(family == 1, '1인 가구', 
               ifelse(family == 2, '2인 가구',
               ifelse(family >= 3, '대가구', '기타')))) # 혹시 모를 값들 때문에 기타도 넣어주는 방법 추천
  select(cust_nm, gender_simple, t_grp, f_grp)


# mutate : paste0| select
# 주문 정보 테이블을 활용하여,
# ‘주’ 컬럼과 ‘시’ 컬럼이 합쳐진 컬럼 addr을 만들어보세요. 
# 이후 cust_nm, addr로 구성된 addr_ino 객체를 만들어보세요.

addr_info = ListofOrders %>% 
 mutate(addr = paste(state, city)) %>% 
 select(cust_nm, addr)


# mutate | filter
# 주문 –상품 테이블을 활용하여,
# 주문 금액과 판매량을 나눈 단위 가격 price를 만들어보세요.
# 이후 price가 200원 이상인 것만 출력한 price_200_info 객체를 만들어보세요.

price_200_info = OrderDetails %>% 
  mutate(price = ord_amt/qty) %>% 
  filter(price >= 200)


# mutate : lubridate | select
# 1. 주문 정보 테이블을 활용하여,
# 2. 날짜 값을 ymd 형태로 변경 후, 요일 값에 해당하는 ord_dow 컬럼을 출력해보세요, 
# 3. 이 후 ord_cd, ord_dow, cust_nm으로 이루어진 객체 dow_info를 만들어보세요.

dow_info = ListofOrders %>% 
  mutate(ord_dt = ord_dt %>% dmy,
         ord_dow = ord_dt %>% wday(label=T)) %>% 
  select(ord_cd, ord_dow, cust_nm) 
  

# filter : is.na() | mutate(nchar())
# 1. 회원 정보 테이블을 활용하여,
# 2. tenure, family, 각 컬럼에서 NA값을 모두 제외된 테이블을 출력 해주세요. 
# 3. 이후 결혼 여부에 대해 응답하지 않은 빈 값은 married 라고 명명해주세요.
 

CustomerSegmentation %>% 
  filter(!tenure %>% is.na, 
         !family %>% is.na) %>% 
  mutate(married = ifelse(nchar(married) < 0, '무응답', married))


# Rename
# 1. 회원정보테이블을활용하여
# 2. cust_nm과 cust_no를 각각 회원명, 회원번호로 바꾸어주세요.
 
CustomerSegmentation %>% 
  rename('회원명' = cust_nm, 
         '회원번호' = cust_no)

# distinct
# 1. 회원 정보 테이블을 활용하여 
# 2. job 컬럼만 출력하되,
# 3. 중복을 제거하고 출력하세요.
 
CustomerSegmentation %>% 
  distinct(job)

# distinct
# 1. 주문 상품 테이블을 활용하여 
# 2. catg_2 컬럼을 출력하되, 다른 컬럼도 붙여서 출력하고,
# 3. 중복을 제거하고 출력하세요.

OrderDetails %>% 
  distinct(catg_2, .keep_all=T)





