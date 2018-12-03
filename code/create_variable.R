library(tidyverse)
library(tidytext)
library(Matrix)
library(topicmodels)
library(glmnet) 

data_ori <- read_csv("../data/random100000.csv")

N <- nrow(data_ori)

result <- read_csv("../data/pos_neg.csv")
  
S1 <- result %>%
  arrange(desc(V1)) %>%
  top_n(1000, V1) %>%
  select(word, V1)

S2 <- result %>%
  arrange(desc(V2)) %>%
  top_n(1000, V2) %>%
  select(word, V2)

S3 <- result %>%
  arrange(desc(V3)) %>%
  top_n(1000, V3) %>%
  select(word, V3)

S4 <- result %>%
  arrange(desc(V4)) %>%
  top_n(1000, V4) %>%
  select(word, V4)

S5 <- result %>%
  arrange(desc(V5)) %>%
  top_n(1000, V5) %>%
  select(word, V5)



data_df = data_frame(line = 1:N,
                     text = data_ori$text, 
                     stars = data_ori$stars)


t1 = Sys.time()
data_tidy <- data_df %>%
  unnest_tokens(word, text)
t2 = Sys.time()
t2-t1

t1 = Sys.time()
data_tidy_unique <- data_tidy %>%
  distinct(line, word, stars)
t2 = Sys.time()
t2-t1

new_data <- tibble(line = c(1:N),
                   S1 = rep(0,N),
                   S2 = rep(0,N),
                   S3 = rep(0,N),
                   S4 = rep(0,N),
                   S5 = rep(0,N))

t1 = Sys.time()

linshi <- data_tidy %>%
  right_join(S1, by = "word") %>%
  group_by(line) %>%
  summarise(count = n())
new_data[linshi$line,2] <- linshi$count

linshi <- data_tidy %>%
  right_join(S2, by = "word") %>%
  group_by(line) %>%
  summarise(count = n())
new_data[linshi$line,3] <- linshi$count

linshi <- data_tidy %>%
  right_join(S3, by = "word") %>%
  group_by(line) %>%
  summarise(count = n())
new_data[linshi$line,4] <- linshi$count

linshi <- data_tidy %>%
  right_join(S4, by = "word") %>%
  group_by(line) %>%
  summarise(count = n())
new_data[linshi$line,5] <- linshi$count

linshi <- data_tidy %>%
  right_join(S5, by = "word") %>%
  group_by(line) %>%
  summarise(count = n())
new_data[linshi$line,6] <- linshi$count

t2 = Sys.time()
t2-t1

new_data$stars <- data_ori$stars


filename = paste("../data/data_final.csv")
write_csv(new_data, filename)
