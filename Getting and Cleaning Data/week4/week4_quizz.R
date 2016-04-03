q1:
  strsplit(names(data),"wgtp")[123]

q2:
  dataq2 <- readCSVDataFromURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","dataquestion2")
  dataCol <- as.numeric(gsub(",","",dataq2$X.3))
  dataCol <- 
  transform(dataq2,X.3=as.numeric(gsub(",","",X.3)))
  colMeans(as.data.frame(dataCol[c(5,235)]),na.rm=TRUE)
  dataCol 
  1453710
  mean(dataCol,na.rm=TRUE)
  [1] 1453710
  
  12192344
  
  
q4:
  dataq41 <- readCSVDataFromURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","dataquestion2")
  dataq42 <- readCSVDataFromURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv","dataquestion2")
  fiscalYearOK <- dataq42[grepl("fiscal year end", tolower(dataq42$Special.Notes)),]
  dataq42Clean <- fiscalYearOK[grepl("june", tolower(fiscalYearOK$Special.Notes)),]
  countryCode2 <- (dataq42Clean$CountryCode)
  countryCode1 <- (dataq2$X)
  intersect(countryCode1,countryCode2)
  
q5:
  install.packages("quantmod")
  library(quantmod)
  install.packages("lubridate")
  library(lubridate)
  y2012 <- year(sampleTimes)==2012
  val1 <- length(y2012[y2012==TRUE])
  

  subDates <- sampleTimes[which(year(sampleTimes)==2012)]
  lundi <- weekdays(subDates)=="lundi"
  val2 <- length(lundi[lundi==TRUE])
  
  
  val2 <- which(weekdays(subDates)=="lundi")