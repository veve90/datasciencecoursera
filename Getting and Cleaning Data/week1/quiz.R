data <-  read.csv(file="getdata-data-ss06hid.csv",head=TRUE,sep=",")
logicalVector <- data$VAL>1
length(logicalVector[logicalVector == TRUE])


source("https://gist.github.com/schaunwheeler/5825002/raw/3526a15b032c06392740e20b6c9a179add2cee49/xlsxToR.r")
xlsxToR = function("myfile.xlsx", header = TRUE)