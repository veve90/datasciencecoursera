
# Argument state:  a state name, ex: TX
# Argument outcome: a death outcome like "heart attack"
# Example of run: best("TX", "heart attack")
#
#
#> best("TX", "heart attack")
#[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
#> best("TX", "heart failure")
#[1] "FORT DUNCAN MEDICAL CENTER"
#> best("MD", "heart attack")
#[1] "JOHNS HOPKINS HOSPITAL, THE"
#> best("MD", "pneumonia")
#[1] "GREATER BALTIMORE MEDICAL CENTER"
#> best("BB", "heart attack")
#Error in best("BB", "heart attack") : invalid state
#> best("NY", "hert attack")
#Error
best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if(is.null(state) || (state %in% data$State != TRUE)){
    stop("invalid state")
  }  
  validOutcome <- c("heart attack","heart failure","pneumonia")
  if(is.null(outcome) || (outcome %in% validOutcome != TRUE)){
    stop("invalid outcome")
  }  
  ## Return hospital name in that state with  lowest 30-day death
  # set column by death cause (outcome)
  columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  if(outcome == "heart attack") {
    columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  }else if (outcome == "heart failure") {
    columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }else columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  
  # Filter columns
  keepColumns <- c("State","Hospital.Name", columnToKeep)
  data <- data[ , keepColumns, drop = FALSE]
  data <- setNames(data, c("State","Hospital","Rate"))
  
  # Filter data by the state
  stateIndexes <- which(data["State"] == state )
  dataWithGivenState <- data[stateIndexes,]

  # Filter data by "Not Available" for the given outcome
  availableRateIndexes <- which(dataWithGivenState["Rate"] != "Not Available" )
  finalData <- dataWithGivenState[availableRateIndexes,]
  finalData$Rate <- as.numeric(as.character(finalData$Rate))
  
  # Find minimum death rate
  minimumDeathRate <- min(finalData$Rate)
  indexMin <- which(finalData["Rate"] == minimumDeathRate)
  dataWithMinimumRate <- finalData[indexMin,]
  ## Hospital Name
  dataWithMinimumRate$Hospital
}


# Argument state: state in wich we are going to search for death cause
# Argument outcome : death cause
# Argument num: rank of hospital in state with given outcome
#
#> rankhospital("TX", "heart failure", 4)
#[1] "DETAR HOSPITAL NAVARRO"
#> rankhospital("MD", "heart attack", "worst")
#3
#[1] "HARFORD MEMORIAL HOSPITAL"
#> rankhospital("MN", "heart attack", 5000)
#[1] NA
rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if(is.null(state) || (state %in% data$State != TRUE)){
    stop("invalid state")
  }  
  validOutcome <- c("heart attack","heart failure","pneumonia")
  if(is.null(outcome) || (outcome %in% validOutcome != TRUE)){
    stop("invalid outcome")
  } 
  

  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  ## Return hospital name in that state with  lowest 30-day death
  # set column by death cause (outcome)
  columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  if(outcome == "heart attack") {
    columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  }else if (outcome == "heart failure") {
    columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }else columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  
  # Filter columns
  keepColumns <- c("State","Hospital.Name", columnToKeep)
  data <- data[ , keepColumns, drop = FALSE]
  data <- setNames(data, c("State","Hospital","Rate"))
  
  # Filter data by the state
  stateIndexes <- which(data["State"] == state )
  dataWithGivenState <- data[stateIndexes,]
  
  
  # Filter data by "Not Available" for the given outcome
  availableRateIndexes <- which(dataWithGivenState["Rate"] != "Not Available" )
  finalData <- dataWithGivenState[availableRateIndexes,]
  finalData$Rate <- as.numeric(as.character(finalData$Rate))
  finalData <- finalData[order(finalData$Rate,finalData$Hospital),]
  
  ## set num 
  if(num == "best") num = 1
  else if(num == "worst") num = nrow(finalData)
  
  
  finalData[num,]$Hospital
  
}


# Ranks hospitals in all states
# head(rankall("heart attack", 20), 10)
# For each state, it finds the hospital of the given rank(num)
rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  validOutcome <- c("heart attack","heart failure","pneumonia")
  if(is.null(outcome) || (outcome %in% validOutcome != TRUE)){
    stop("invalid outcome")
  } 
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  # set column by death cause (outcome)
  columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  if(outcome == "heart attack") {
    columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  }else if (outcome == "heart failure") {
    columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }else columnToKeep = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  
  # Filter columns
  keepColumns <- c("State","Hospital.Name", columnToKeep)
  data <- data[ , keepColumns, drop = FALSE]
  data <- setNames(data, c("State","Hospital","Rate"))
  
  
  # Filter data by "Not Available" for the given outcome
  availableRateIndexes <- which(data["Rate"] != "Not Available" )
  finalData <- data[availableRateIndexes,]
  finalData$Rate <- as.numeric(as.character(finalData$Rate))
  finalData <- finalData[order(finalData$Rate,finalData$Hospital),]
  
  # For each state, find the hospital of the given rank
  splitByState <- lapply(split(finalData,finalData["State"]), 
                        function(x) { 
                          
                          if(num == "best") num = 1
                          else if(num == "worst") num = nrow(x)
                          
                          orderdData <- x[order(x$Rate,x$Hospital),]

                          keepColumns <- c("State","Hospital")
                          data <- orderdData[ , keepColumns, drop = FALSE]
                          data[num,]$Hospital
                          
                          })
  splitByState
}
