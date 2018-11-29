library(tidyverse)
library(tidytext)
library(Matrix)
library(topicmodels)
library(glmnet) 

data_ori = read_csv("../../data/random100000.csv")

data_df = data_frame(line = 1:nrow(data_ori),
                     text = data_ori$text, 
                     stars = data_ori$stars)


t1 = Sys.time()
data_tidy <- data_df %>%
  unnest_tokens(word, text)
t2 = Sys.time()
t2-t1


#####

# 同一个句子中出现多次同一个单词视做出现一次。同一个句子出现两个good和一个，效果都是一样的，说明是positive

t1 = Sys.time()
data_tidy_unique <- data_tidy %>%
  distinct(line, word, stars)
t2 = Sys.time()
t2-t1


#######



data_tidy_group <- data_tidy_unique %>%
  group_by(stars, word) %>%
  summarise(count = n()) # 是第几行不重要，删掉

data_tidy_group_100 <- data_tidy_group %>%
  group_by(word) %>%
  summarise(count2_5 = sum(count)) %>%
  filter(count2_5 > 100) # 只保留出现次数超过100次的单词

major_word <- data_tidy_group_100 %>%
  select(word)

data_tidy3 <- data_tidy_group %>%
  inner_join(major_word, by = "word") %>%
  spread(stars, count, fill = 0) # 显示词频

star_count <- data_df %>%
  group_by(stars) %>%
  summarise(count = n())
  
mycount = star_count$count


myprop = function(data_row, counts){
  data2 = as.numeric(data_row[2:6])
  xx = numeric(5)
  for(i in 1:5){
    if(counts[i] == 0){
      xx[i] = 0
    }else if(sum(data2[-i]) == 0){
      xx[i] = 100
    }else if(sum(counts[-i]) == 0){
      xx[i] = 100
    }else{
      y1 = data2[i]/counts[i]
      y2 = sum(data2[-i])/sum(counts[-i])
      xx[i] = y1/y2
    }
  }
  return(xx)
}

t1 = Sys.time()
result = as.tibble(t(apply(data_tidy3, 1, myprop, counts = mycount)))
t2 = Sys.time()
t2-t1
result$word = data_tidy3$word
result <- result %>%
  select(word, V1:V5)


filename = paste("../data/pos_neg.csv")
write_csv(result, filename)



# data_tidy3[which(data_tidy3$word %in% "refund"),][2:6]/mycount
# result[which(result$word %in% "and"),]


