library(data.table)
IFS <- data.table(read.csv(file = "RawData/IFS.csv", 
                           stringsAsFactors = FALSE))
CountryChoices <- unique(IFS$Country.Name)