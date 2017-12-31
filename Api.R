library(plumber)
library(RMySql)
library(neuralnet)
library(psych)
r <- plumb("argh.R") 
r$run(port=8000)




