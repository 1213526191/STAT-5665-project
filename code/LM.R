library(tidyverse)
library(caret)


dat <- read_csv("../data/data_final.csv")

N <- nrow(dat)
X <- dat[,2:6]
y <- dat[,7]

cv <- createFolds(c(1:N), k = 5, list = TRUE, returnTrain = FALSE)

sse <- 0
for(i in 1:5){
  train <- dat[-cv[[i]],2:7]
  test <- dat[cv[[i]],2:7]
  model <- lm(stars~S1+S2+S3+S4+S5, train)
  y_fit <- predict(model, test[,1:5])
  sse <- sse + sum((y_fit-test[,6])^2)
}
sse/nrow(dat)










