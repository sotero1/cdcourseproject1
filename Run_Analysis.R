# here i download the file

  setwd("C:/Users/Sotero/Desktop/cleaningdata/courseproject")

  # some packages neededed
  library("plyr", lib.loc="C:/Users/Sotero/Documents/R/win-library/3.1")
  library("reshape2", lib.loc="C:/Users/Sotero/Documents/R/win-library/3.1")
  # downloaded the training data
  xtrain <- read.table("X_train.txt")
  ytrain <- read.table("y_train.txt")
  strain <- read.table("subject_train.txt")
  
  # binded the training data
  traind<-cbind(xtrain,ytrain,strain)
  
  # downloads the test data
  
  xtest <- read.table("X_test.txt"  )
  ytest <- read.table("y_test.txt"   )
  stest <- read.table("subject_test.txt" )
  
  testd <- cbind(xtest,ytest,stest)
  # merges all trainin and test data
  mdata <- rbind(traind,testd)
  
  # this completes the first part merging the data
  #-----------------------------------------------------
  
  # here we upload the column names and remove non alphanumeric charecters
  cnames<-read.table("features.txt" )
  
  cnames1<-as.character(cnames[ ,2 ])
  
  cnames2<-gsub("[^a-zA-Z0-9]","",cnames1)
  
  # canmes2 is all the variable names for mean standard deviation not including id
  #here we set the column names
  colnames(mdata) <- cnames2
  
 #here we find all the columns with Mmean and standard deviation
# nmean std is the number columns that contain mean and std i store activity ans subject colunm numer also  

  cnames3 <-c(cnames2,"activity","subject")
  
  nmeanstd <- grep("[Mm]ean|[Ss]td",cnames3 )
  
  
  # here i add subject and id to the column names
  nmeanstd <- c(nmeanstd,c(562,563))
  # here we extract data mean std and activity subject
  edata <- mdata[ ,nmeanstd]
  
  # this completes part 2 extract column the data that contains mean and standard deviation
  # it also completes step 4 i used descriptive names for variables
  #------------------------------------------------------

  colnames(edata)[87]<-"activity"
  colnames(edata)[88]<-"subject"

  # here we extract data with mean and standard deviation
  actlabel <- read.table("activity_labels.txt") 
  
  # here we change the activity number with the activity name
  
  edata$activity<-sub("1",actlabel[1,2],edata$activity )
  edata$activity<-sub("2",actlabel[2,2],edata$activity ) 
  edata$activity<-sub("3",actlabel[3,2],edata$activity ) 
  edata$activity<-sub("4",actlabel[4,2],edata$activity ) 
  edata$activity<-sub("5",actlabel[5,2],edata$activity )
  edata$activity<-sub("6",actlabel[6,2],edata$activity )
  
  #-------------------------------------------------------------
  # this completes part 3 replacing the activity number with descriptive names
  
  
   nedata<-colnames(edata)
    # nedata1  are the variable names including means and standard deviations
    # nedata1 exclude id names activity and subject
  nedata1 <- nedata[1:86]
  
  # here we melt the data ids activity and subject all other col names are variables
  
  datamelt <- melt(edata,id = c("activity","subject"), measure.vars = nedata1   )
  
  # here we compute the mean of each variable for each subject and activity
  
  tidydata <- dcast(datamelt,subject~variable+activity,mean)
 
  
  
  
  