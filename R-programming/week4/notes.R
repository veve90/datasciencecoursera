# looking at data
class(my_var)
dim(my_var)
nrow(my_var)
ncol(my_var)
object.size(my_var)
names(my_var)
head(my_var)
head(my_var,n=10)
tail(my_var)
summary(my_var)
table(my_var$columnName)
str(my_var)

# simulating
my_pois <- replicate(100, rpois(5, 10))
cm <- colMeans(my_pois)
hist(cm)

# graphics
plot(matrix_name)
hist(matrix_name)
