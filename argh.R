library(RMySQL)
library(psych)
library(neuralnet)

#* @get /neuralnet
net <- function(){
  con <- dbConnect(MySQL(),
                   user = 'root',
                   password = 'Myszka123',
                   host = 'localhost',
                   dbname='meh')
  rs = dbSendQuery(con, "Select a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,iduser from val")
  data=fetch(rs,n=-1)
  
  set.seed(123)
  
  ind <-sample(1:nrow(data)-1,nrow(data))
  trainDF <- data[ind,]
  testDF <- data[-ind,]
  
  allVars <- colnames(data)
  predictorVar <- allVars[!allVars%in%"iduser"]
  
  predictorVar<-paste(predictorVar,collapse="+")
  form= as.formula(paste("iduser~",predictorVar,collapse="+"))
  
  neuralModel <-neuralnet(formula = form, hidden= c(4,2),linear.output = T, data= trainDF) 
  
  predictions<-compute(neuralModel,testDF[,1:26])
  predictions$net.result
  }