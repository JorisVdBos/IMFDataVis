library(data.table)
IFS <- data.table(read.csv(file = "RawData/IFSSam.csv", 
                           stringsAsFactors = FALSE))
CountryChoices <- unique(IFS$Country.Name)