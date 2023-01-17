# 01.00 분석 환경 설정 ----
# 01.10 라이브러리 설정
source("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/[Part.6 강의자료] R 기초 강의자료/Ch 05. 데이터 집계와 변환/source_test.R")

# 01.11. 경로 설정
setwd("/Users/lhs/Desktop/데이터분석_초격차_패키지/R/[Part.6 강의자료] R 기초 강의자료/R 기초 관련 CSV 파일/HR Analytics job change of data scientists")


# 02.00. 데이터 가공하기 ----
# https://www.kaggle.com/arashnic/hr-analytics-job-change-of-data-scientists
df <- fread("aug_train.csv") %>% tibble()

df %>% 
  colnames() %>% 
  as_tibble()

df %>% head(3) %>% t

df %>% 
  group_by(education_level) %>% 
  summarise(n = n())

df %>% 
  count(gender)


# 02.10 데이터 진단하기 ----
df_refine <- df %>% 
  mutate(id = enrollee_id %>% as.character(),
         city = city %>% str_remove_all("city_") %>% as.character(),
         city_idx = city_development_index,
         gender = ifelse(gender == "Male", "M",
                         ifelse(gender == "Female","F",
                                ifelse(gender %>% nchar()<1 , NA, gender))),
         rlvt_ex = ifelse(relevent_experience == "Has relevent experience", "Y", "N"),
         course = ifelse(enrolled_university == 'Full time course', "full",
                         ifelse(enrolled_university == 'Part time course', "part",
                                ifelse(enrolled_university == 'no_enrollment', "not",
                                       ifelse(enrolled_university %>% nchar() <1, NA, enrolled_university)))),
         edu_lv = ifelse(education_level == "Primary School", 'P.S',
                         ifelse(education_level == "High School", 'H.S',
                                ifelse(education_level == "Graduate", "B.A",
                                       ifelse(education_level == "Masters", 'M.A',
                                              ifelse(education_level == "Phd", 'Phd',
                                                     ifelse(education_level %>% nchar() < 1, NA,education_level)))))),
         major = ifelse(major_discipline == "Arts",'arts',
                        ifelse(major_discipline == "Business Degree",'biz',
                               ifelse(major_discipline == "Humanities",'humanities',
                                      ifelse(major_discipline == "No Major",'no_major',
                                             ifelse(major_discipline == "Other",'other',
                                                    ifelse(major_discipline == "STEM",'stem',
                                                           ifelse(major_discipline %>% nchar() < 1, NA, major_discipline))))))),
         ex = ifelse(experience %>% nchar()<1, NA, experience),
         # 순서 메기기
         ex = ex %>% as.factor %>% factor(levels=c('<1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','>20',NA), order=T),
         
         cpn_size = ifelse(company_size %>% nchar() < 1, NA ,company_size),
         cpn_type = ifelse(company_type %>% nchar() < 1, NA ,company_type),
         
         target = ifelse(target == '1', "Y", "N"),
         target = target %>% as.factor(),
         trans_term = ifelse(last_new_job %>% nchar()<1, NA, last_new_job),
         trn_hour = training_hours) %>% 
  select(target, id, city, city_idx, gender, rlvt_ex, course, edu_lv,major, ex, cpn_size, cpn_type, trans_term, trn_hour)

df
df_refine


# install.packages("dlookr")
library(dlookr)
# diagnose_report(df, output_format = "html")

# html로 뽑아주는 라이브러리..
diagnose_paged_report(df_refine, output_format = "html")

df %>%
  diagnose()  # 진단하다

df_refine %>% 
  diagnose() %>% 
  arrange(missing_percent %>% desc)

# 02.20 데이터 이해하기 ----


library(ROSE)
df_bal <- ovun.sample(target ~ ., data = df_refine, 
                      method = "both", 
                      p = 0.5,
                      N = 5000, 
                      seed = 1)$data %>% 
  as_tibble()

# 데이터 불균형 처리 ----

df_refine %>% 
  count(target) %>% 
  mutate(prop = .$n %>% prop.table)

df_bal %>% 
  count(target) %>% 
  mutate(prop = .$n %>% prop.table)

# 02.21  훈련 시간이 많을 수록 후보 선정에 영향을 미치지 않을까요?
hypo_1 <- df_bal %>% 
  group_by(target) %>% 
  summarise(avg_trnhour = mean(trn_hour),
            sd_trnhour = sd(trn_hour),
            max_trnhour = max(trn_hour),
            min_trnhour = min(trn_hour))

# 02.22  성별은 후보선정에 영향을 미치지 않을 것 같아요.
hypo_2 <- df_bal %>% 
  group_by(target, gender) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(gender ~ target, value.var = "prop", sum) %>% 
  as_tibble()

# 02.23  회사 유형과 크기에 따라 후보 선정에 영향을 미칠 것 같아요. 왜냐하면 작은 회사 일수록 더 많은 배움과 성장을 기대하지 않을까 싶어서요.
hypo_3 <- df_bal %>% 
  group_by(target, cpn_type, cpn_size) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n / .$n %>% sum) %>% round(2)) %>%  # .$n => 테이블에서 n 컬럼을 선택한 것
  data.table() %>% 
  dcast(cpn_type + cpn_size ~ target, value.var = "prop", sum) %>% 
  as_tibble() %>% 
  arrange(Y %>% desc)
print(n=100)

# 02.24  더불어 연차가 낮을 수록 새로운 직종에 대한 목표가 더 높지 않을까 싶어요.
hypo_4 <- df_bal %>% 
  group_by(target, ex) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(ex ~ target, value.var = "prop", sum) %>% 
  as_tibble() %>% 
  arrange(Y %>% desc)

df_bal %>% 
  group_by(target, ex) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(ex ~ target, value.var = "prop", sum) %>% 
  as_tibble() %>% 
  mutate(ex = ex %>% as.character()) %>% 
  mutate(gap = Y-N) %>% 
  arrange(gap %>% desc)

# 02.25  지역은 후보 선정에 있어 영향을 줄 것 같아요,  왜냐하면 거주 환경에 따라 특성이 가장 명확할 것 같거든요.
hypo_5 <- df_bal %>% 
  group_by(target, city) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(city ~ target, value.var = "n", sum) %>% 
  as_tibble() %>% 
  mutate(gap = Y-N) %>% 
  arrange(gap %>% desc) %>% 
  print(n=100)

hypo_5 %>% 
  print(n=1000)
# 02.26  전공 또한 환경에 크게 영향을 줄 것 같아요, 배웠던 경험이 크게 영향을 미칠 것 같기 떄문이에요.
hypo_6 <- df_bal %>% 
  group_by(target, major) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(major ~ target, value.var = "prop", sum) %>% 
  as_tibble() %>% 
  arrange(Y %>% desc) %>% 
  print(n=100)

# 02.27  더불어 교육 수준도 영향을 크게 미칠 것 같아요,
hypo_7 <- df_bal %>% 
  group_by(target, edu_lv) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(edu_lv ~ target, value.var = "prop", sum) %>% 
  as_tibble() %>% 
  print(n=100)

# 02.28  이직 연수 차이도 큰 영향을 끼칠 것 같아요, 직무 이동은 이직간의 고민을 많이 했을 것 같기 떄문이에요.
hypo_8 <- df_bal %>% 
  group_by(target, trans_term) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(trans_term ~ target, value.var = "prop", sum) %>% 
  as_tibble() %>% 
  print(n=100)

# 02.29 종합 
hypo_5
hypo_6
hypo_7
hypo_8
hypo_4
hypo_3 %>% arrange(Y %>% desc)
# hypo_1
# hypo_2


df_bal %>% 
  filter(city == '21') %>% 
  group_by(target, city, cpn_type, cpn_size, ex, major, edu_lv, trans_term) %>% 
  summarise(n = n()) %>% 
  data.table() %>% 
  dcast(city + cpn_type + cpn_size + ex + major + edu_lv + trans_term ~ target, value.var = 'n')


df_bal %>% 
  # filter(city == '21',
  #        major == 'stem',
  #        edu_lv == 'B.A') %>%
  group_by(target, city, cpn_type, cpn_size, ex, major, edu_lv, trans_term) %>% 
  summarise(n = n()) %>% 
  mutate(prop = (n/.$n %>% sum) %>% round(2)) %>% 
  data.table() %>% 
  dcast(city + cpn_type + cpn_size + ex + major + edu_lv + trans_term ~ target, value.var = 'n', fill = 0) %>% 
  as_tibble() %>% 
  filter(Y > 0) %>% 
  arrange(Y %>% desc) 
