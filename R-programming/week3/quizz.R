#iris
library(datasets)
data(iris)
?iris
mean(iris$Sepal.Length)
#[1] 5.843333

apply(iris[, 1:4], 2, mean)
#Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
#5.843333     3.057333     3.758000     1.199333 