# outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
# outcome[, 11] <- as.numeric(outcome[, 11])
# hist(outcome[, 11])

# Argument state:  a state name, ex: TX
# Argument outcome: a death outcome like "heart attack"
# Example of run: best("TX", "heart attack")
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
  
  # remove State column from final Data
  #keepColumns <- c("Hospital", "Rate")
  #finalData <- finalData[ , keepColumns, drop = FALSE]
  
  
  
  
  #find the hospital name
  #splitByRate <- lapply(split(finalData,finalData["Rate"]), 
  #                      function(x) { 
  #                        hospitals <- x$Hospital
  #                        hospitals[order(hospitals)][1]})
  ## set num 
  if(num == "best") num = 1
  else if(num == "worst") num = nrow(finalData)
  
  
  finalData[num,]$Hospital
  
}



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
