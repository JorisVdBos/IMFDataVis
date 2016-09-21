IMF data Visualization
========================================================
author: Joris Van den Bossche
date: September 21, 2016
autosize: true

Overview
========================================================
For the coursera course "Making Data Products", I have made a shiny application where you can view all the staticstics that were gathered by the International Monetary Fund (IMF). In this presentation I will give you an overview of:
- The data origin
- Cleaning the data
- Creating the shiny app

And of course in the last slide, I will show you the shiny app!

The Data origin
========================================================

Data was downloaded from the [IMF website](http://www.imf.org/en/Data>). The chosen data set name is [International Financial Statistics](http://data.imf.org/?sk=388DFA60-1D26-4ADE-B505-A05A558D9A42&sid=1459341854713&ss=1469128361826).
![Choose set](download1.png)

<img src="download2.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="400px" />

More information about the data set can be found [here](http://data.imf.org/?sk=5DABAFF2-C5AD-4D27-A175-1253419C02D1).

The data can then be read as such:

```r
IFS <- read.csv("raw_data/IFS_08-26-2016 00-07-35-66_timeSeries.csv", stringsAsFactors = FALSE)
```


Cleaning the data
========================================================
The data has been cleaned as following. First all the data from before 2000 was removed, since it contained mostly missing data

```r
IFS <- IFS[, -grep("19",names(IFS))]
```
The data was structered so that every year, quarter and month had a column. The rows had three copies of the same data for each type of time window. I removed all but the month's columns and then remove all the rows that contain no data. The first 5 columns had to remain untouched, since they contained the country data.

```r
IFS <- IFS[, c(1:(n-1),grep("M",names(IFS)))]
for(i in 6:dim(IFS)[2]) IFS[, i] <- as.numeric(IFS[, i])
library(data.table)
IFS <- data.table(IFS)
IFS <- IFS[, nas := sum(sapply(.SD, is.na)), .SDcols = 6:dim(IFS)[2], by=1:NROW(IFS)]
IFS <- IFS[nas<dim(IFS)[2]-6,]
IFS$nas <- NULL
```
Last, I changed the name of the column "ï.Country.Name" to "Country.Name", because the "ï" was fairly troublesome.

```r
names(IFS)[1] <- "Country.Name"
```

Creating the Shiny app
========================================================

[Here](https://github.com/JorisVdBos/IMFDataVis) you can find the source code of the Shiny app (and also this presentation!). To illustrate how the graphs are made, an example for country Belgium, and statistic Value of Imports in Euro:


```r
country <- "Belgium"
statistic <- "Value of Imports, Euros"
data <- IFS[Country.Name == country & Indicator.Name == statistic & Attribute == "Value",]
data <- data.frame(date = paste(substr(names(data)[7:210], 2, 5), substr(names(data)[7:210], 7, 8), sep="-"),
                   value = as.numeric(t(data)[7:210]))
plot <- mPlot(x = "date", y = "value", type = "Line", 
                  data = data)
plot$set(pointSize = 0, lineWidth = 1)
plot$print('chart2', include_assets = TRUE, cdn = TRUE)
```

The Shiny app: Example output
========================================================
<link rel='stylesheet' href=//cdn.oesmith.co.uk/morris-0.4.2.min.css>
<script type='text/javascript' src=//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js></script>
<script type='text/javascript' src=//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js></script>
<script type='text/javascript' src=//cdn.oesmith.co.uk/morris-0.4.2.min.js></script> 
 <style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 800px;
    height: 400px;
  }  
  </style>
<div id = 'chart2' class = 'rChart morris'></div>
<script type='text/javascript'>
    var chartParams = {
 "element": "chart2",
"width":            800,
"height":            400,
"xkey": "date",
"ykeys": [
 "value" 
],
"data": [
 {
 "date": "2000-1",
"value":    13530000000 
},
{
 "date": "2000-2",
"value":    15450000000 
},
{
 "date": "2000-3",
"value":    17360000000 
},
{
 "date": "2000-4",
"value":    14440000000 
},
{
 "date": "2000-5",
"value":    17050000000 
},
{
 "date": "2000-6",
"value":    15590000000 
},
{
 "date": "2000-7",
"value":    14410000000 
},
{
 "date": "2000-8",
"value":    15120000000 
},
{
 "date": "2000-9",
"value":    16770000000 
},
{
 "date": "2000-10",
"value":    17490000000 
},
{
 "date": "2000-11",
"value":    18270000000 
},
{
 "date": "2000-12",
"value":    16700000000 
},
{
 "date": "2001-1",
"value":    17330000000 
},
{
 "date": "2001-2",
"value":    16960000000 
},
{
 "date": "2001-3",
"value":    18430000000 
},
{
 "date": "2001-4",
"value":    16390000000 
},
{
 "date": "2001-5",
"value":    17580000000 
},
{
 "date": "2001-6",
"value":    17190000000 
},
{
 "date": "2001-7",
"value":    15480000000 
},
{
 "date": "2001-8",
"value":    14720000000 
},
{
 "date": "2001-9",
"value":    16040000000 
},
{
 "date": "2001-10",
"value":    16820000000 
},
{
 "date": "2001-11",
"value":    16480000000 
},
{
 "date": "2001-12",
"value":    16070000000 
},
{
 "date": "2002-1",
"value":    16620000000 
},
{
 "date": "2002-2",
"value":    16700000000 
},
{
 "date": "2002-3",
"value":    18550000000 
},
{
 "date": "2002-4",
"value":    17560000000 
},
{
 "date": "2002-5",
"value":    17590000000 
},
{
 "date": "2002-6",
"value":    17600000000 
},
{
 "date": "2002-7",
"value":    16410000000 
},
{
 "date": "2002-8",
"value":    15520000000 
},
{
 "date": "2002-9",
"value":    18220000000 
},
{
 "date": "2002-10",
"value":    19170000000 
},
{
 "date": "2002-11",
"value":    17950000000 
},
{
 "date": "2002-12",
"value":    17840000000 
},
{
 "date": "2003-1",
"value":    17040000000 
},
{
 "date": "2003-2",
"value":    17200000000 
},
{
 "date": "2003-3",
"value":    18400000000 
},
{
 "date": "2003-4",
"value":    17470000000 
},
{
 "date": "2003-5",
"value":    16590000000 
},
{
 "date": "2003-6",
"value":    17590000000 
},
{
 "date": "2003-7",
"value":    16570000000 
},
{
 "date": "2003-8",
"value":    14530000000 
},
{
 "date": "2003-9",
"value":    18380000000 
},
{
 "date": "2003-10",
"value":    18700000000 
},
{
 "date": "2003-11",
"value":    17530000000 
},
{
 "date": "2003-12",
"value":    17690000000 
},
{
 "date": "2004-1",
"value":    16970000000 
},
{
 "date": "2004-2",
"value":    17800000000 
},
{
 "date": "2004-3",
"value":    21100000000 
},
{
 "date": "2004-4",
"value":    18870000000 
},
{
 "date": "2004-5",
"value":    17560000000 
},
{
 "date": "2004-6",
"value":    21630000000 
},
{
 "date": "2004-7",
"value":    17850000000 
},
{
 "date": "2004-8",
"value":    17100000000 
},
{
 "date": "2004-9",
"value":    20900000000 
},
{
 "date": "2004-10",
"value":    19680000000 
},
{
 "date": "2004-11",
"value":    20670000000 
},
{
 "date": "2004-12",
"value":    20200000000 
},
{
 "date": "2005-1",
"value":    18900000000 
},
{
 "date": "2005-2",
"value":    20310000000 
},
{
 "date": "2005-3",
"value":    23420000000 
},
{
 "date": "2005-4",
"value":    20720000000 
},
{
 "date": "2005-5",
"value":    20620000000 
},
{
 "date": "2005-6",
"value":    22640000000 
},
{
 "date": "2005-7",
"value":    19020000000 
},
{
 "date": "2005-8",
"value":    20100000000 
},
{
 "date": "2005-9",
"value":    22650000000 
},
{
 "date": "2005-10",
"value":    20770000000 
},
{
 "date": "2005-11",
"value":    23940000000 
},
{
 "date": "2005-12",
"value":    23350000000 
},
{
 "date": "2006-1",
"value":    22680000000 
},
{
 "date": "2006-2",
"value":    22450000000 
},
{
 "date": "2006-3",
"value":    26630000000 
},
{
 "date": "2006-4",
"value":    21530000000 
},
{
 "date": "2006-5",
"value":    23660000000 
},
{
 "date": "2006-6",
"value":    24300000000 
},
{
 "date": "2006-7",
"value":    21220000000 
},
{
 "date": "2006-8",
"value":    22180000000 
},
{
 "date": "2006-9",
"value":    24450000000 
},
{
 "date": "2006-10",
"value":    24710000000 
},
{
 "date": "2006-11",
"value":    25520000000 
},
{
 "date": "2006-12",
"value":    21840000000 
},
{
 "date": "2007-1",
"value":    24250000000 
},
{
 "date": "2007-2",
"value":    23490000000 
},
{
 "date": "2007-3",
"value":    27080000000 
},
{
 "date": "2007-4",
"value":    23420000000 
},
{
 "date": "2007-5",
"value":    24720000000 
},
{
 "date": "2007-6",
"value":    25790000000 
},
{
 "date": "2007-7",
"value":    24520000000 
},
{
 "date": "2007-8",
"value":    23530000000 
},
{
 "date": "2007-9",
"value":    25290000000 
},
{
 "date": "2007-10",
"value":    28090000000 
},
{
 "date": "2007-11",
"value":    27190000000 
},
{
 "date": "2007-12",
"value":    23750000000 
},
{
 "date": "2008-1",
"value":    26680000000 
},
{
 "date": "2008-2",
"value":    25130000000 
},
{
 "date": "2008-3",
"value":    26740000000 
},
{
 "date": "2008-4",
"value":    28090000000 
},
{
 "date": "2008-5",
"value":    25670000000 
},
{
 "date": "2008-6",
"value":    28150000000 
},
{
 "date": "2008-7",
"value":    27490000000 
},
{
 "date": "2008-8",
"value":    24670000000 
},
{
 "date": "2008-9",
"value":    29070000000 
},
{
 "date": "2008-10",
"value":    28180000000 
},
{
 "date": "2008-11",
"value":    24300000000 
},
{
 "date": "2008-12",
"value":    22160000000 
},
{
 "date": "2009-1",
"value":    20790000000 
},
{
 "date": "2009-2",
"value":    20640000000 
},
{
 "date": "2009-3",
"value":    22780000000 
},
{
 "date": "2009-4",
"value":    20120000000 
},
{
 "date": "2009-5",
"value":    19390000000 
},
{
 "date": "2009-6",
"value":    21590000000 
},
{
 "date": "2009-7",
"value":    20420000000 
},
{
 "date": "2009-8",
"value":    18740000000 
},
{
 "date": "2009-9",
"value":    22930000000 
},
{
 "date": "2009-10",
"value":    23050000000 
},
{
 "date": "2009-11",
"value":    21560000000 
},
{
 "date": "2009-12",
"value":    22360000000 
},
{
 "date": "2010-1",
"value":    21540000000 
},
{
 "date": "2010-2",
"value":    22010000000 
},
{
 "date": "2010-3",
"value":    26270000000 
},
{
 "date": "2010-4",
"value":    24110000000 
},
{
 "date": "2010-5",
"value":    23390000000 
},
{
 "date": "2010-6",
"value":    26100000000 
},
{
 "date": "2010-7",
"value":    23920000000 
},
{
 "date": "2010-8",
"value":    23210000000 
},
{
 "date": "2010-9",
"value":    26140000000 
},
{
 "date": "2010-10",
"value":    26230000000 
},
{
 "date": "2010-11",
"value":    26700000000 
},
{
 "date": "2010-12",
"value":    25460000000 
},
{
 "date": "2011-1",
"value":    26970000000 
},
{
 "date": "2011-2",
"value":    27330000000 
},
{
 "date": "2011-3",
"value":    31340000000 
},
{
 "date": "2011-4",
"value":    26790000000 
},
{
 "date": "2011-5",
"value":    29850000000 
},
{
 "date": "2011-6",
"value":    28520000000 
},
{
 "date": "2011-7",
"value":    25940000000 
},
{
 "date": "2011-8",
"value":    26940000000 
},
{
 "date": "2011-9",
"value":    28610000000 
},
{
 "date": "2011-10",
"value":    27410000000 
},
{
 "date": "2011-11",
"value":    28590000000 
},
{
 "date": "2011-12",
"value":    27170000000 
},
{
 "date": "2012-1",
"value":    27460000000 
},
{
 "date": "2012-2",
"value":    28750000000 
},
{
 "date": "2012-3",
"value":    31560000000 
},
{
 "date": "2012-4",
"value":    27730000000 
},
{
 "date": "2012-5",
"value":    29010000000 
},
{
 "date": "2012-6",
"value":    28730000000 
},
{
 "date": "2012-7",
"value":    27880000000 
},
{
 "date": "2012-8",
"value":    26960000000 
},
{
 "date": "2012-9",
"value":    26840000000 
},
{
 "date": "2012-10",
"value":    29860000000 
},
{
 "date": "2012-11",
"value":    30640000000 
},
{
 "date": "2012-12",
"value":    26340000000 
},
{
 "date": "2013-1",
"value":    28630000000 
},
{
 "date": "2013-2",
"value":    28070000000 
},
{
 "date": "2013-3",
"value":    30930000000 
},
{
 "date": "2013-4",
"value":    29080000000 
},
{
 "date": "2013-5",
"value":    28290000000 
},
{
 "date": "2013-6",
"value":    27440000000 
},
{
 "date": "2013-7",
"value":    28580000000 
},
{
 "date": "2013-8",
"value":    25450000000 
},
{
 "date": "2013-9",
"value":    28260000000 
},
{
 "date": "2013-10",
"value":    30380000000 
},
{
 "date": "2013-11",
"value":    28070000000 
},
{
 "date": "2013-12",
"value":    27150000000 
},
{
 "date": "2014-1",
"value":    28680000000 
},
{
 "date": "2014-2",
"value":    27680000000 
},
{
 "date": "2014-3",
"value":    30020000000 
},
{
 "date": "2014-4",
"value":    28700000000 
},
{
 "date": "2014-5",
"value":    27770000000 
},
{
 "date": "2014-6",
"value":    28590000000 
},
{
 "date": "2014-7",
"value":    28120000000 
},
{
 "date": "2014-8",
"value":    26550000000 
},
{
 "date": "2014-9",
"value":    30820000000 
},
{
 "date": "2014-10",
"value":    30630000000 
},
{
 "date": "2014-11",
"value":    27540000000 
},
{
 "date": "2014-12",
"value":    27150000000 
},
{
 "date": "2015-1",
"value":    26550000000 
},
{
 "date": "2015-2",
"value":    27200000000 
},
{
 "date": "2015-3",
"value":    31250000000 
},
{
 "date": "2015-4",
"value":    29670000000 
},
{
 "date": "2015-5",
"value":    27860000000 
},
{
 "date": "2015-6",
"value":    31300000000 
},
{
 "date": "2015-7",
"value":    28820000000 
},
{
 "date": "2015-8",
"value":    26220000000 
},
{
 "date": "2015-9",
"value":    28710000000 
},
{
 "date": "2015-10",
"value":    29860000000 
},
{
 "date": "2015-11",
"value":    28250000000 
},
{
 "date": "2015-12",
"value":    27670000000 
},
{
 "date": "2016-1",
"value":    25830000000 
},
{
 "date": "2016-2",
"value":    27800000000 
},
{
 "date": "2016-3",
"value":    28470000000 
},
{
 "date": "2016-4",
"value":    27130000000 
},
{
 "date": "2016-5",
"value":    25800000000 
},
{
 "date": "2016-6",
"value": null 
},
{
 "date": "2016-7",
"value": null 
},
{
 "date": "2016-8",
"value": null 
},
{
 "date": "2016-9",
"value": null 
},
{
 "date": "2016-10",
"value": null 
},
{
 "date": "2016-11",
"value": null 
},
{
 "date": "2016-12",
"value": null 
} 
],
"pointSize":              0,
"lineWidth":              1,
"id": "chart2",
"labels": "value" 
},
      chartType = "Line"
    new Morris[chartType](chartParams)
</script>

The Shiny app!
========================================================

Click [here](https://jorisvdbos.shinyapps.io/IMFdataVis/) to be taken to the shiny app webpage.
