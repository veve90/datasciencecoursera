#read data
quizz<-read.csv("hw1_data.csv")


# get the mean from ozone
ozone<-quizz$Ozone
ozone_missing <- is.na(ozone)
ozone_not_missing <- ozone[!ozone_missing]
mean(ozone_not_missing)

# number of missing values in ozone
ozone_missing_vect <- ozone[ozone_missing]

# ozone > 31, temp > 90 , what is the mean of Solar.R?
ozone_temp_solar <- quizz[c("Ozone","Solar.R","Temp")]
names(ozone_temp_solar)
filtered<-subset(ozone_temp_solar,ozone_temp_solar$Ozone>31 & ozone_temp_solar$Temp>90)
mean(filtered$Solar.R)

#mean of temp when month = 6
month_quizz <- a[c("Temp","Month")]
filtered<-subset(month_quizz,month_quizz$Month==6)
mean(filtered$Temp)


#max ozone in month = 5
month_quizz <- a[c("Ozone","Month")]
filtered<-subset(month_quizz,month_quizz$Month==5)
filtered_na<-is.na(filtered)
filtered_almost_good<-subset(filtered,!is.na(filtered))
filtered_good<-filtered_almost_good[0:31,]
max(filtered_good$Ozone)
