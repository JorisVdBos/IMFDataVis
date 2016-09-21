plotInfo <- function(country, statistic){
  info <- IFS[Country.Name == country & Indicator.Name == statistic & Attribute != "Value"]
  if(dim(info)[1] == 0) return(NULL)
  col <- which(!is.na(t(info)[7:210]))[1] + 6
  info <- info[, c(6, col), with = FALSE]
  names(info)[1] <- "Plot Info"
  names(info)[2] <- ""
  info
}

makeTs <- function(country, statistic){
  data <- IFS[Country.Name == country & Indicator.Name == statistic & Attribute == "Value",]
  #data <- ts(t(data)[7:210], start = 2000, frequency = 12)
  data <- data.frame(date = paste(substr(names(data)[7:210], 2, 5), substr(names(data)[7:210], 7, 8), sep="-"),
                     value = as.numeric(t(data)[7:210]))
  data
}