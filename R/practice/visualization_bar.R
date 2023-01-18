
source("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/[Part.6 강의자료] R 기초 강의자료/Ch 05. 데이터 집계와 변환/source_test.R")
setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/Indian E-commerce website")


# 01.10 데이터 불러오기 ----
ord_info <- fread("practices/List of Orders.csv") %>% tibble()
ord_prd <- fread("practices/Order Details.csv") %>% tibble()
cust_info <- fread("practices/Customer Segmentation.csv") %>% tibble()

# Q. 분기별 매출 및 수익 현황은 어떻게 되는가?

ord_info %>%
  left_join(ord_prd) %>% 
  mutate(ord_q = ord_dt %>% dmy %>% quarter(with_year=T) %>% as.character()) %>% 
  group_by(ord_q) %>% 
  summarise(rev = sum(ord_amt),
            net = sum(ord_profit)
            ) %>% 
  e_chart(ord_q) %>% 
  e_line(rev, name="매출액") %>% 
  e_line(net, name = "이익액") %>% 
  e_bar()
  e_theme('vintage') %>% 

  # zoom, view, saveas 기능 추가
  e_toolbox_feature(feature = c('dataZoom', 'dataView')) %>% 
  # 값 보이게
  e_tooltip(trigger = 'axis')
  
  
?e_toolbox_feature

  